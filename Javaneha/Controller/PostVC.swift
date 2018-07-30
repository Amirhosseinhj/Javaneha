//
//  PostVC.swift
//  Javaneha
//
//  Created by Amirhossein on 7/2/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit
import AlamofireImage
import WebKit
import SVProgressHUD

class PostVC: UIViewController, WKUIDelegate , WKNavigationDelegate {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var webView: WKWebView!
    
    var news = DataModelItem()
    var tracker : Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.backgroundColor = .white
        webView.scrollView.isScrollEnabled = false
        
        if tracker{
            tracker = false
            webView.loadWebPage(urlString: "http://javaneonline.ir/blog/post/" + news.slug)
        }
        
        if webView.isLoading {
            SVProgressHUD.setContainerView(self.inputAccessoryView)
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.show()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        postImage.af_setImage(withURL: URL(string: news.imageAddress)!)
        postLabel.text = news.heading
        
        
        scrollView.isScrollEnabled = true
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        SVProgressHUD.dismiss()
        webView.initialZoomScale(scalable: true)
        
        webView.getScrollableHeight{
            (height: CGFloat) in
            self.webView.frame.size.height = height
            self.scrollView.contentInset = UIEdgeInsetsMake(0.0,0.0,height - self.postImage.frame.size.height,0.0)
        }
        
        
    }
    
    
    


}

