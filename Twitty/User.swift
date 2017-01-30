//
//  User.swift
//  Twitty
//
//  Created by Ленар on 30.01.17.
//  Copyright © 2017 com.lenar. All rights reserved.
//

import UIKit

class User {
    //OAuth = Fetch Request Token + Redirect to Auth + Fetch Access Token + Callback URL
    
    static let userDidLogoutNotification = "UserDidlogout"
    
    static var _currentUser: User?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
    }
    
    class var currentUser:User? {
        get{
            if (_currentUser == nil) {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUser") as? Data
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!)
                defaults.set(data, forKey: "currentUser")
            } else {
                defaults.set(nil, forKey: "currentUser")
            }
        }
    }
}
