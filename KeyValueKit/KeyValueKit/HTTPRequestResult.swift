//
//  HTTPRequestResult.swift
//  KeyValueKit
//
//  Created by Jason Nam on 14/6/18.
//  Copyright © 2018 KeyValueKit. All rights reserved.
//

import Foundation

enum HTTPRequestResultResult {
    case success(Data)
    case canceled
    case failure(HTTPRequestError)
}
