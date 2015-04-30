//
//  TopicViewController.swift
//  BTVKichen
//
//  Created by Cassius Chen on 3/31/15.
//  Copyright (c) 2015 com.seaver. All rights reserved.
//

import Foundation
import UIKit
import AVOSCloud

class TopicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    var topics : NSArray! = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRectMake(0.0, 0.0, 996.0, 685.0)
        let query = AVQuery(className: "Topic")
        query.cachePolicy = AVCachePolicy.CacheElseNetwork
        query.findObjectsInBackgroundWithBlock({
            (object : [AnyObject]!, error : NSError!) in
            if !(error != nil) {
                self.topics = object
                self.collectionView.reloadData()
            } else {
                NSLog("Error %@ %@", error, error.userInfo!)
            }
        })
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        let label = cell.contentView.viewWithTag(1) as UILabel
        let thumb = cell.contentView.viewWithTag(2) as UIImageView
        
        let topic : AVObject = topics.objectAtIndex(indexPath.row) as AVObject
        let topicThumb : AVRelation = topic.objectForKey("thumb") as AVRelation
        
        let thumbQuery : AVQuery = topicThumb.query()
        
        let topicImage : NSData? = thumbQuery.findObjects().first?.objectForKey("file")?.getData()
        
        
        label.text = topic.objectForKey("title") as NSString
        
        
        if (topicImage != nil) {
            thumb.image = UIImage(data: topicImage!)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let topicVC = storyboard?.instantiateViewControllerWithIdentifier("showTopic") as ShowTopicViewController
        let topic: AnyObject = topics.objectAtIndex(indexPath.row)
        
        topicVC.titleText = topic.objectForKey("title") as String
        topicVC.requestUrl = topic.objectForKey("url") as String
        topicVC.topicView = self
        
        
        let contentView = self.view.superview
        
        /* topicVC.titleText = "TEST"
        topicVC.requestUrl = "http://www.baidu.com" */
        
        //self.view.removeFromSuperview()
        //contentView!.addSubview(topicVC.view)
        self.view.addSubview(topicVC.view)
    }
}