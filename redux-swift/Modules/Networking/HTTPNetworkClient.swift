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

protocol HTTPNetworkClientInterface {
    func request(_ method: HTTPMethod, path: String, callback: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
}

class HTTPNetworkClient: HTTPNetworkClientInterface {
    
    var timeoutInterval = 20.0
    var headerFields = [String: String]()
    
    private let generator: URLGenerator
    
    init(timeoutInterval: TimeInterval, generator: URLGenerator = URLGenerator()) {
        self.timeoutInterval = timeoutInterval
        self.generator = generator
    }
    
    func request(_ method: HTTPMethod, path: String, callback: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        do {
            let url = try generator.url(path: path)
            let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
            for (key, value) in headerFields {
                request.addValue(value, forHTTPHeaderField: key)
            }
            request.httpMethod = method.rawValue
            session.dataTask(with: request) { data, response, error in
                callback(data, response as? HTTPURLResponse, error)
            }.resume()
        } catch {
            callback(nil, nil, error)
        }
    }
}
