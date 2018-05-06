//
//  GitHubNetworkClient.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

struct Unauthorized: Error {}
struct InvalidResponse: Error {}
struct GitHubAPIError: Error {
    struct Response: Codable {
        let message: String
    }
    
    let statusCode: Int
    let response: Response?
}

class GitHubNetworkClient {
    
    private let client: HTTPNetworkClient
    private let store: StateStore
    private let tokenGenerator: BasicAuthTokenGenerator
    
    init(
        client: HTTPNetworkClient,
        store: StateStore,
        tokenGenerator: BasicAuthTokenGenerator = BasicAuthTokenGenerator()
    ) {
        self.client = client
        self.store = store
        self.tokenGenerator = tokenGenerator
        client.headerFields["User-Agent"] = "bartlomiejn/redux-swift"
    }
    
    func request(
        _ method: HTTPMethod,
        path: String,
        successCallback: @escaping (Data?) -> Void,
        failureCallback: ((Error?) -> Void)?
    ) {
        client.request(method, path: path) { data, response, error in
            guard let unwrappedResponse = response else {
                failureCallback?(InvalidResponse())
                return
            }
            switch unwrappedResponse.statusCode {
            case 200:
                successCallback(data)
            case 401:
                failureCallback?(Unauthorized())
            case 400..., 500...:
                if let data = data {
                    failureCallback?(GitHubAPIError(
                        statusCode: unwrappedResponse.statusCode,
                        response: ModelDecoder<GitHubAPIError.Response>().model(from: data)))
                } else {
                    failureCallback?(GitHubAPIError(statusCode: unwrappedResponse.statusCode, response: nil))
                }
            default:
                failureCallback?(error)
            }
        }
    }
    
    func setBasicAuthToken(username: String, password: String) throws {
        client.headerFields["Authorization"] = "Basic \(try tokenGenerator.token(from: username, password: password))"
    }
}
