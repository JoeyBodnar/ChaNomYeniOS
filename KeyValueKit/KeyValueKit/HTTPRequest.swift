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
        return request(.get, url: url, params: nil, completion: completion)
    }
    
    @discardableResult
    static func post(url: URL, forKey key: String, withValue value:Data,  completion: @escaping (HTTPRequestResultResult) -> Void) -> URLSessionDataTask {
        return request(.post, url: url, params: ["key": key, "value": value], completion: completion)
    }
    
    @discardableResult
    static func remove(url: URL, completion: @escaping (HTTPRequestResultResult) -> Void) -> URLSessionDataTask {
        return request(.remove, url: url, params: nil, completion: completion)
    }
    
    static func request(_ method: HTTPRequestMethod,
                        url: URL,
                        params: [String: Any]?,
                        completion: @escaping (HTTPRequestResultResult) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(KeyValueKit.secretKey, forHTTPHeaderField: "Authorization")
        if method == .post {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            if let parameters = params {
                let paramsgegr = GetResponse(key: parameters["key"] as! String, value: parameters["value"] as! Data)
                do { try request.httpBody = JSONEncoder().encode(paramsgegr) }
                catch let error { print("could not encode data with error \(error)") }
            }
        }
        let task = session.dataTask(with: request) { data, response, error in
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
        task.resume()
        return task
    }
}
