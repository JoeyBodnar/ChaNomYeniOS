//
//  KeyValueKit.swift
//  KeyValueKit
//
//  Created by Jason Nam on 14/6/18.
//  Copyright © 2018 KeyValueKit. All rights reserved.
//

import Foundation

enum Result<T: Codable> {
    case success(T)
    case canceled
    case failure(Error)
}

class KeyValueKit {

    static var appID: String!
    static var userID: String!

    static func getValue<T: Codable>(forKey key: String, completion: ((Result<T>) -> Void)?) {
        HTTPRequest.get(url: URL(string: "")!) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(T.self, from: data)
                    completion?(.success(responseObject))
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
        HTTPRequest.post(url: URL(string: "")!) { result in
            switch result {
            case .success(_):
                completion?(.success(value))
            case .canceled:
                completion?(.canceled)
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    static func removeValue<T: Codable>(forKey key: String, completion: ((Result<T>) -> Void)?) {
        HTTPRequest.remove(url: URL(string: "")!) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(T.self, from: data)
                    completion?(.success(responseObject))
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
}
