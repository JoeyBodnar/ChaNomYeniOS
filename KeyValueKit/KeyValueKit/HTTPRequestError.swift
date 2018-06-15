//
//  HTTPRequestError.swift
//  KeyValueKit
//
//  Created by Jason Nam on 14/6/18.
//  Copyright © 2018 KeyValueKit. All rights reserved.
//

import Foundation

enum HTTPRequestError: Error {
    case error(Error)
    case noHTTPResponse
    case emptyData
    case requestFailed(Data)
}
