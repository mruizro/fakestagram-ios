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
        self.init(client: Client(), path: "/posts/\(String(describing: post.id))/comments")
    }
    
//    func like() -> Post {
//        guard let postId = post.id else { return post }
//        client.request("POST", path: "\(basePath)/\(postId)/like", body: nil, completionHandler: onSuccessLike(response:data:), errorHandler: onError(error:))
//        return post
//    }
}
