//
//  HomeViewController.swift
//  Twitty
//
//  Created by Ленар on 30.01.17.
//  Copyright © 2017 com.lenar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView:UITableView!
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
        reloadData()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tweets == nil) {
            return 0
        } else {
            return tweets!.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! TweetCompactCell
        print("\(indexPath.row):\(tweets![indexPath.row].text)")
        cell.tweet = tweets![indexPath.row]
        return cell
    }
    
    func reloadData() {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets:[Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }

}
