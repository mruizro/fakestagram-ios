//
//  ProfileViewController.swift
//  fakestagram
//
//  Created by LuisE on 4/23/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    @IBOutlet weak var profileNameTitle: UINavigationItem!
    let client = ProfileClient()
    var posts: [Post] = [] {
        didSet { profileCollectionView.reloadData() }
    }
    
    @IBOutlet weak var authorView: PostAuthorView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        client.show { [weak self] data in
            self?.posts = data
        }
        authorView.author = Author(id: Secrets.token.value!, name: UserDefaults.standard.string(forKey: "name")!)
        profileNameTitle.title = authorView.author?.name
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier, for: indexPath) as! ProfileCollectionViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let postDetailVC = self.storyboard?.instantiateViewController(withIdentifier: PostDetailViewController.reuseIdentifier) as? PostDetailViewController {
            let post = self.posts[indexPath.row]
            postDetailVC.post = post
            self.navigationController?.pushViewController(postDetailVC, animated: true)
//            postDetailVC.delegate = self
        }
    }
}


