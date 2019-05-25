//
//  ProfileCollectionViewCell.swift
//  fakestagram
//
//  Created by Marco Antonio Ruiz Robles D3 on 5/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "profileViewCell"
    @IBOutlet weak var imageView: UIImageView!
    public var post: Post? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        updateView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 10
    }
    private func updateView() {
        guard let post = self.post else { return }
        post.load { [weak self] img in
            self?.imageView.image = img
        }
//        authorView.author = post.author
//        titleLbl?.text = post.title
//        likesCountLbl.text = post.likesCountText()
//        commentsCountLbl.text = post.commentsCountText()
}
}
