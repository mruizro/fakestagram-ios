//
//  LikeClient.swift
//  fakestagram
//
//  Created by LuisE on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//
import Foundation

class LikeUpdaterClient {
    private let client = Client()
    private let basePath = "/api/posts"
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func call() -> Post {
        if !post.liked {
            return like()
        } else {
            return dislike()
        }
    }
    
    func like() -> Post {
        var post = self.post
        guard let postId = post.id else { return post }
        client.request("POST", path: "\(basePath)/\(postId)/like", body: nil, completionHandler: onSuccess(response:data:), errorHandler: onError(error:))
        post.likesCount += 1
        post.liked = true
        return post
    }
    
    func dislike() -> Post {
        var post = self.post
        guard let postId = post.id else { return post }
        client.request("DELETE", path: "\(basePath)/\(postId)/like", body: nil, completionHandler: onSuccess(response:data:), errorHandler: onError(error:))
        post.likesCount -= 1
        post.liked = false
        return post
    }
    
    func onSuccess(response: HTTPResponse, data: Data?) {
        guard response.successful() else { return }
    }
    
    private func onError(error: Error?) {
        guard let err = error else { return }
        print("Error on request: \(err.localizedDescription)")
    }
}
