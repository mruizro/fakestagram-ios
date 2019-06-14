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
    var content: String
    var created_at:String?
    var updated_at:String?
    var author: Author?


    init(id: Int,content:String,created_at:String,updated_at:String,author:Author) { // Constructor
        self.id = nil
        self.content = content
        self.created_at = created_at
        self.updated_at = updated_at
        self.author = author
    }
    
  
}
