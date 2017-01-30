//
//  SplashViewController.swift
//  Twitty
//
//  Created by Ленар on 30.01.17.
//  Copyright © 2017 com.lenar. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController,TwitterLoginDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterClient.sharedInstance?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!appDelegate.splashDelay) {
            delay(delay: 1.0, closure: { 
                self.continueLogin()
            })
        }
    }
    
    func goToLogin(){
        self.performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    func goToApp() {
        self.performSegue(withIdentifier: "HomeSegue", sender: self)
    }
    
    func continueLogin() {
        appDelegate.splashDelay = false
        if User.currentUser == nil {
            self.goToLogin()
        } else {
            self.goToApp()
        }
    }

}
