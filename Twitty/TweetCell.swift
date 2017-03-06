//
//  TweetCell.swift
//  Twitty
//
//  Created by Ленар on 02.02.17.
//  Copyright © 2017 com.lenar. All rights reserved.
//

import UIKit
import FaveButton

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorScreennameLabel: UILabel!
    
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var tweetAgeLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var mediaImageView: UIImageView!
    
    var tweetID: NSNumber!
    
    var tweet:Tweet! {
        didSet {
            tweetSetConfigure()
        }
    }
    
    func tweetSetConfigure() {
        tweetID = tweet.tweetID
        
        profilePictureImageView.setImageWith(tweet.authorProfilePicURL!)
        profilePictureImageView.layer.cornerRadius = 5
        profilePictureImageView.clipsToBounds = true
        
        authorNameLabel.text = tweet.author as String?
        authorScreennameLabel.text = "@" + (tweet.screenname)
        
        tweetContentLabel.text = tweet.text as String?
        
        //retweetButton.isSelected = tweet.retweeted
        //retweetButton.isSelected
        //favoriteButton.isSelected = tweet.favorited
        //favoriteCountLabel.select(tweet.favorited)
        
        mediaImageView.image = nil
    }
    
    @IBAction func onRetweetButton(sender: FaveButton) -> Void {
        if sender.isSelected {
            sender.isSelected = false
            tweet.retweeted = false
            retweetCountLabel.text = String(tweet.retweetsCount) 
        }else {
            sender.isSelected = true
            tweet.retweeted = true
            retweetCountLabel.text = String(tweet.retweetsCount)
        }
    }
    
    @IBAction func onFavoriteButton(sender: FaveButton) -> Void {
        if sender.isSelected {
            sender.isSelected = false
            tweet.favorited = false
            favoriteCountLabel.text = String(tweet.favoritesCount)
        }else {
            sender.isSelected = true
            tweet.favorited = true
            favoriteCountLabel.text = String(tweet.favoritesCount)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
