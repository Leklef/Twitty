//
//  HomeViewController.swift
//  Twitty
//
//  Created by Ленар on 30.01.17.
//  Copyright © 2017 com.lenar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout() {
        TwitterClient.sharedInstance?.logout()
    }

}
