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
//    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var commentsTV: UITableView!
    @IBOutlet weak var commentTextField:
    UITextField!
    @IBOutlet weak var authorView: PostAuthorView!
    @IBOutlet weak var closeBtn: UIButton!
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        client.all {[weak self] data in
            self!.comments =  data
        }
        setValues()
    }
    
     @IBAction func sendComment(_ sender: Any) {
        let payload = Comment(content: commentTextField.text!, author: post.author!)
        client.create(codable: payload) { (comment) in
            self.client.all {[weak self] data in
                self!.comments =  data
                self!.commentTextField.text = ""
            }
            self.commentsTV.reloadData()
        }
    }
    
    @IBAction func closeComments(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func setValues() {
        authorView.author = post.author
        descriptionLbl.text = post?.title
    }
    
}
extension CommentViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTV.dequeueReusableCell(withIdentifier:
            CommentTableViewCell.reuseIdentifier, for: indexPath) as! CommentTableViewCell
        cell.authorName.text = comments[indexPath.row].author?.name
        cell.contentTV.text = comments[indexPath.row].content
        cell.created.text = comments[indexPath.row].created_at
        return cell
    }
}
