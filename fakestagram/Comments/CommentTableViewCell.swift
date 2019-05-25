//
//  CommentTableViewCell.swift
//  fakestagram
//
//  Created by Marco Antonio Ruiz Robles D3 on 5/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class CommentTableViewCell: UITableViewCell {
    static let reuseIdentifier = "commentCell"
    var comment:Comment?
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var contentTV: UITextView!
    @IBOutlet weak var created: UILabel!
    
}
