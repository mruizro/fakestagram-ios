//
//  Secrets.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

enum Secrets {
    static let account = "com.ruizro.fakestagram"
    case host
    case token
    
    var value: String? {
        switch self {
        case .host:
            return "https://fakestagram-api.herokuapp.com/"
        case .token:
           return KeychainService.getValue(forService: "authentication", account:  Secrets.account)
        }
    }

    func set(value: String) -> Bool {
        switch self {
        case .token:
            KeychainService.setValue(value: value, forService: "authentication", account: Secrets.account)
            return true
        default:
            return false
        }
    }
}
