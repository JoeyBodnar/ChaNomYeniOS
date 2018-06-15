//
//  GetResponse.swift
//  KeyValueKit
//
//  Created by Stephen Bodnar on 15/6/2561 BE.
//  Copyright © 2561 KeyValueKit. All rights reserved.
//

import Foundation

struct GetResponse: Codable {
    let key: String
    let value: Data
}
