//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Harjas Monga on 1/10/18.
//  Copyright © 2018 Harjas Monga. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts: [[String: Any]] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getPhotos(useRefreshControl: false)
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

    }
    func getPhotos(useRefreshControl: Bool) {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // print(dataDictionary)
                let response = dataDictionary["response"] as! [String: Any]
                self.posts = response["posts"] as! [[String: Any]]
                if useRefreshControl {
                    self.refreshControl.endRefreshing()
                }
            }
            self.tableView.reloadData()
            
        }
        task.resume()
    }
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        getPhotos(useRefreshControl: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.postImage.af_setImage(withURL: url!)
        }
        
        return cell
    }
    
    
    

}
