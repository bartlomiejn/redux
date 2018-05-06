//
//  HTTPNetworkClient.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
}

struct HTTPURLResponseGenerationError: Error {}

protocol HTTPNetworkClientInterface {
    typealias Path = String
    func request(_ method: HTTPMethod, path: String, callback: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
    func stub(
        _ path: Path,
        _ method: HTTPMethod,
        statusCode: Int,
        body: Any?,
        headers: [String : String]?
    ) throws
}

class HTTPNetworkClient: HTTPNetworkClientInterface {

    var timeoutInterval = 20.0
    var headerFields = [String: String]()
    private let generator: URLGenerator
    private var stubbedResponses = [Path: [HTTPMethod: HTTPResponseStub]]()
    
    init(timeoutInterval: TimeInterval, generator: URLGenerator = URLGenerator()) {
        self.timeoutInterval = timeoutInterval
        self.generator = generator
    }
    
    func request(_ method: HTTPMethod, path: Path, callback: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        do {
            let url = try generator.url(path: path)
            let session = urlSession(for: path, method: method)
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
            request.httpMethod = method.rawValue
            headerFields.forEach {
                request.addValue($1, forHTTPHeaderField: $0)
            }
            session.dataTask(with: request) { data, response, error in
                callback(data, response as? HTTPURLResponse, error)
            }.resume()
        } catch {
            callback(nil, nil, error)
        }
    }
    
    func stub(
        _ path: Path,
        _ method: HTTPMethod,
        statusCode: Int,
        body: Any? = nil,
        headers: [String : String]? = nil
    ) throws {
        guard let urlResponse = HTTPURLResponse(
            url: try generator.url(path: path),
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: headers
        ) else {
            throw HTTPURLResponseGenerationError()
        }
        let bodyData = try? JSONSerialization.data(withJSONObject: body as Any, options: .prettyPrinted)
        let stub = HTTPResponseStub(urlResponse: urlResponse, statusCode: statusCode, body: bodyData)
        if var responsesForMethods = stubbedResponses[path] {
            responsesForMethods[method] = stub
            stubbedResponses[path] = responsesForMethods
        } else {
            stubbedResponses[path] = [method : stub]
        }
    }
    
    private func urlSession(for path: Path, method: HTTPMethod) -> URLSession {
        if let stub = stubbedResponses[path]?[method] {
            return StubbedURLSession(body: stub.body, response: stub.urlResponse)
        } else {
            return URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: nil)
        }
    }
}
