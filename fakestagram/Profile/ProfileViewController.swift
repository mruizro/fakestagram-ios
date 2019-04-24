//
//  ProfileViewController.swift
//  fakestagram
//
//  Created by LuisE on 4/23/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var authorView: PostAuthorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        authorView.author = Author(name: "jojo")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
