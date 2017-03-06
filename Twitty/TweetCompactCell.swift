//
//  TweetCompactCell.swift
//  Twitty
//
//  Created by Ленар on 02.02.17.
//  Copyright © 2017 com.lenar. All rights reserved.
//

import UIKit

class TweetCompactCell: TweetCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func tweetSetConfigure() {
        super.tweetSetConfigure()
        retweetCountLabel.text = tweet.retweetsCount > 0 ? String(tweet.retweetsCount) : ""
        favoriteCountLabel.text = tweet.favoritesCount > 0 ? String(tweet.favoritesCount) : ""
    }

}
