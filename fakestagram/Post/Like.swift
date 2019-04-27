//
//  Like.swift
//  fakestagram
//
//  Created by LuisE on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Codable {
    let author: Author?
    let createdAt: String
    let updatedAt: String
}
