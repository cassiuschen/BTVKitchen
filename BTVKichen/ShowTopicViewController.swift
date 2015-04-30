//
//  ShowTopicViewController.swift
//  BTVKichen
//
//  Created by Cassius Chen on 4/14/15.
//  Copyright (c) 2015 com.seaver. All rights reserved.
//

//import Foundation
import UIKit

class ShowTopicViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var webView: UIWebView!
    
    @IBAction func back(sender: UIButton) {
        self.view.removeFromSuperview()
    }
    var titleText : String = "Nil"
    var requestUrl : String = ""
    var topicView : TopicViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Running here!")
        self.configureView()
    }
    
    func makeRequest(url: String?) -> NSURLRequest {
        let rawUrl = NSURL(string: url!)
        
        let request = NSURLRequest(URL: rawUrl!)
        
        return request
    }
    
    func configureView() {
        self.view.frame = CGRectMake(0.0, 768.9, 996, 658)
        self.titleLabel.text = titleText
        self.webView.loadRequest(makeRequest(requestUrl))
        let option = UIViewAnimationOptions.CurveLinear | UIViewAnimationOptions.AllowUserInteraction
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: option, animations: {self.view.frame = CGRectMake(0.0, 0, 996, 658)}, completion: nil)

     }
    
    
    

}
