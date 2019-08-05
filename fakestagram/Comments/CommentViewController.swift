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
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var commentsTV: UITableView!
    @IBOutlet weak var commentTextField:UITextField!
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
        commentsTV.reloadData()
        setValues()
    }
    
    
    @IBAction func sendComment(_ sender: Any) {
        let payload = Comment(content: commentTextField.text!, author: post.author!)
        client.create(codable: payload) { (comment) in
            self.client.all {[weak self] data in
                self!.comments =  data
                self!.commentTextField.text = ""
            }           
        }
        commentsTV.reloadData()
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
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let queue = DispatchQueue(label: "comments")
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.client.destroy(id: self.comments[indexPath.row].id!) { _ in
                self.comments.removeAll()
            }
            queue.async{
                self.client.all {[weak self] data in
                    self!.comments =  data
                }
            }
            self.commentsTV.reloadData()
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            let alert = UIAlertController(title: "Edit comment", message: "", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                alert.textFields!.first!.text = self.comments[indexPath.row].content
            })
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                if alert.textFields!.first!.text!.count >= 4{
                    if alert.textFields!.first!.text! != self.comments[indexPath.row].content{
                        self.comments[indexPath.row].content = alert.textFields!.first!.text!
                        self.client.update(id: self.comments[indexPath.row].id!, codable: self.comments[indexPath.row], success: { (comment) in
                            self.commentsTV.reloadRows(at: [indexPath], with: .middle)
                        })
                    }
                    
                }
            }
            ))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        })
        
        
        edit.backgroundColor = UIColor(red:1.00, green:0.72, blue:0.00, alpha:1.0)
        return [delete, edit]
}
}
