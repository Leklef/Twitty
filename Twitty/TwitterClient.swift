//
//  TwitterClient.swift
//  Twitty
//
//  Created by Ленар on 30.01.17.
//  Copyright © 2017 com.lenar. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "Zo22ejDVlqotalk10aFX7n5lZ", consumerSecret: "mqD5DWyiIfIOYOFXaf0hC6vGb12MTCEf8u7VoeQx4qxVsZxtk9")
    
    //Getting request token to open up auth link in safari
    
    var loginSuccess: (()->())?
    var loginFailure: ((NSError)->())?
    
    var delegate: TwitterLoginDelegate?
    
    func login(success:@escaping ()->(), failure:@escaping (NSError)->()) -> Void {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitty://oauth")!, scope: nil, success: { (requestToken) in
            print("Got token")
            
            let url = URL(string:"https://api.twitter.com/oauth/authenticate?oauth_token=" + (requestToken?.token)!)!
            UIApplication.shared.open(url, completionHandler: nil)
            
        }) { (error) in
            print("Error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        }
    }
    
    //Get access token and save user
    func handleOpenUrl(url:URL) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.splashDelay = true
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)!
        
        //Getting access token
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken) in
            self.currentAccount(success: { (user:User) in
                //Calling setter and saving user
                User.currentUser = user
                self.delegate?.continueLogin()
                self.loginSuccess?()
            }, failure: { (error) in
                self.loginFailure?(error)
            })
            self.loginSuccess?()
        }) { (error) in
            print("Error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        }
    }
    
    //Get the current account
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)
        }) { (task, error) in
            print("error: \(error.localizedDescription)")
            failure(error as NSError)
        }
    }
    
    //logout
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: Notification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
}
