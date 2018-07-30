//
//  AboutUsVC.swift
//  Javaneha
//
//  Created by Amirhossein on 7/1/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class AboutUsVC: UIViewController , WKUIDelegate , WKNavigationDelegate  {
    
    @IBOutlet weak var aboutWebView: WKWebView!
    
    var tracker : Bool = true
    
    let aboutUsURL =  "http://javaneonline.ir/blog/post/about"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutWebView.uiDelegate = self
        aboutWebView.navigationDelegate = self
        aboutWebView.backgroundColor = .white
        if tracker {
            tracker = false
            aboutWebView.loadWebPage(urlString: aboutUsURL)
        }
        
        //        MARK: Configuring SVProgressHUD
        
        if aboutWebView.isLoading {
            SVProgressHUD.setContainerView(self.view)
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.show()
            
        }
        

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
        webView.initialZoomScale(scalable: false)
        
    }


    
    
    

}
