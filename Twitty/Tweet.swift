//
//  Tweet.swift
//  Twitty
//
//  Created by Ленар on 02.02.17.
//  Copyright © 2017 com.lenar. All rights reserved.
//

import UIKit
import Alamofire

class Tweet {
    
    var tweetID: NSNumber!
    var screenname: String
    var author: String
    var authorProfilePicURL: URL?
    
    var urls: [NSDictionary]
    //var media: [NSDictionary]
    
    var text: String?
    var timestamp: NSDate?
    var retweetsCount: Int = 0
    var favoritesCount: Int = 0
    
    var favorited: Bool {
        didSet {
            if favorited {
                favoritesCount += 1
            } else {
                favoritesCount -= 1
            }
        }
    }
    
    var retweeted: Bool {
        didSet {
            if retweeted {
                retweetsCount += 1
            } else {
                retweetsCount -= 1
            }
        }
    }
    
    init(dictionary: NSDictionary) {
        tweetID = dictionary["id"] as! NSNumber
        
        let entities = dictionary["entities"] as! NSDictionary
        
        urls = entities["urls"] as! [NSDictionary]
        //media = entities["media"] as! [NSDictionary]
        
        let user = dictionary["user"] as! NSDictionary
        
        screenname = user["screen_name"] as! String
        author = user["name"] as! String
        authorProfilePicURL = URL(string: (user["profile_image_url_https"] as! String).replace(target: "normal.png", withString: "bigger.png"))!
        
        text = dictionary["text"] as? String
        
        retweetsCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        retweeted = (dictionary["retweeted"] as? Bool) ?? false
        favorited = (dictionary["favorited"] as? Bool) ?? false
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
}
