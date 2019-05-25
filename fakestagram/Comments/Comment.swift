//
//  Comment.swift
//  fakestagram
//
//  Created by Marco Antonio Ruiz Robles D3 on 5/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class Comment:Codable {
    let id: Int?
    let content: String
    let created_at:String?
    let updated_at:String?
    let author: Author?
    
    
  
}
