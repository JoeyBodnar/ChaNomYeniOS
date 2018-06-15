//
//  KeyValueKit.swift
//  KeyValueKit
//
//  Created by Jason Nam on 14/6/18.
//  Copyright © 2018 KeyValueKit. All rights reserved.
//

// Secret key for Vcliq account
// 2TIZngqYgoVidZ4jefzM/abu3Jpv9hV9XO+cBXEp

import Foundation

enum Result<T: Codable> {
    case success(Data)
    case canceled
    case failure(Error)
}

class KeyValueKit {
    static let secretKey = "2TIZngqYgoVidZ4jefzM/abu3Jpv9hV9XO+cBXEp"
    
    static var appID: String!
    static var userID: String!
    
    static func getValue<T: Codable>(forKey key: String, completion: ((Result<T>) -> Void)?) {
        HTTPRequest.get(url: URL(string: "http://localhost:8080/db/get?key=\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(GetResponse.self, from: data)
                    DispatchQueue.main.sync {
                        completion?(Result.success(response.value))
                    }
                } catch {
                    completion?(.failure(error))
                }
            case .canceled:
                completion?(.canceled)
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    static func set<T: Codable>(_ value: T, forKey key: String, completion: ((Result<T>) -> Void)?) {
        guard let data = value as? Data else { return }
        HTTPRequest.post(url: URL(string: "http://localhost:8080/db/set")!, forKey: key, withValue: data) { result in
                switch result {
                case .success(_):
                    print("success")
                    completion?(Result.success(value as! Data))
                case .canceled:
                    completion?(.canceled)
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
    }
    
    static func removeValue<T: Codable>(forKey key: String, completion: ((Result<T>) -> Void)?) {
        //        HTTPRequest.remove(url: URL(string: "")!) { result in
        //            switch result {
        //            case .success(let data):
        //                let decoder = JSONDecoder()
        //                do {
        //                    let responseObject = try decoder.decode(T.self, from: data)
        //                    completion?(.success(responseObject))
        //                } catch {
        //                    completion?(.failure(error))
        //                }
        //            case .canceled:
        //                completion?(.canceled)
        //            case .failure(let error):
        //                completion?(.failure(error))
        //            }
        //        }
    }
}
