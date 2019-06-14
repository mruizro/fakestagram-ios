//
//  CommentClient.swift
//  fakestagram
//
//  Created by Marco Antonio Ruiz Robles D3 on 5/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation


class CommentClient: RestClient<Comment> {
    
    convenience init(post: Post) {
        self.init(client: Client(), path: "/api/posts/\(String(describing: post.id!))/comments")
    }
}

