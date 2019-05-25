//
//  ProfilePost.swift
//  fakestagram
//
//  Created by Marco Antonio Ruiz Robles D3 on 5/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct Postu: Codable {
    let id: Int?
    let title: String
    let imageUrl: String?
    let author: Author?
    var likesCount: Int
    //    var commentsCount: Int
    //    let createdAt: String
    //    var liked: Bool
    

func load(_ image: @escaping (UIImage) -> Void) {
    let cache = ImageCache(filename: "image-\(self.id!).jpg")
    if let img = cache.load() {
        image(img)
        return
    }
    guard let urlString = imageUrl, let url = URL(string: urlString) else { return }
    DispatchQueue.global(qos: .background).async {
        if let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
            DispatchQueue.main.async { image(img) }
            _ = cache.save(image: img)
        }
    }
}
}