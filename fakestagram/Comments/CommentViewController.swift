//
//  CommentViewController.swift
//  fakestagram
//
//  Created by Marco Antonio Ruiz Robles on 6/5/19.
//  Copyright © 2019 ruizro. All rights reserved.
//

import Foundation
import UIKit

class CommentViewController: UIViewController{
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var commentsTV: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    static let reuseIdentifier = "commentVC"
    public var post:Post!
    var comments: [Comment] = [] {
        didSet { commentsTV.reloadData() }
    }
    lazy var client = CommentClient(post: post)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTV.delegate = self
        commentsTV.dataSource = self
        client.all {[weak self] data in
            self!.comments =  data
        }
        setValues()
    }
    
     @IBAction func sendComment(_ sender: Any) {
        print("Enviando comentario")
        let payload = Comment(id: 100, content: commentTextField.text!, created_at: "", updated_at: "", author: post.author!)
        client.create(codable: payload) { (comment) in
            print(comment.content)
            self.client.all {[weak self] data in
                self!.comments =  data
            }
            self.commentsTV.reloadData()
        }
    }
    
    func setValues() {
        authorLbl.text = post?.author?.name
        descriptionLbl.text = post?.title
    }
    
}
extension CommentViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(comments.count)
        let cell = commentsTV.dequeueReusableCell(withIdentifier:
            CommentTableViewCell.reuseIdentifier, for: indexPath) as! CommentTableViewCell
        cell.authorName.text = comments[indexPath.row].author?.name
        cell.contentTV.text = comments[indexPath.row].content
        return cell
    }
}
