//
//  HTTPRequest.swift
//  KeyValueKit
//
//  Created by Jason Nam on 14/6/18.
//  Copyright © 2018 KeyValueKit. All rights reserved.
//

import Foundation

final class HTTPRequest {

    static var session: URLSession = {
        let session = URLSession.shared
        return session
    }()

    @discardableResult
    static func get(url: URL, completion: @escaping (HTTPRequestResultResult) -> Void) -> URLSessionDataTask {
        return request(.get, url: url, completion: completion)
    }

    @discardableResult
    static func post(url: URL, completion: @escaping (HTTPRequestResultResult) -> Void) -> URLSessionDataTask {
        return request(.post, url: url, completion: completion)
    }

    @discardableResult
    static func remove(url: URL, completion: @escaping (HTTPRequestResultResult) -> Void) -> URLSessionDataTask {
        return request(.remove, url: url, completion: completion)
    }

    static func request(_ method: HTTPRequestMethod,
                        url: URL,
                        completion: @escaping (HTTPRequestResultResult) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.error(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    break
                case -999:
                    completion(.canceled)
                    return
                default:
                    completion(.failure(.requestFailed(data)))
                    return
                }
            } else {
                completion(.failure(.noHTTPResponse))
                return
            }
            completion(.success(data))
        }
    }
}
