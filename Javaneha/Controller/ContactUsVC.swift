//
//  ContactUsVC.swift
//  Javaneha
//
//  Created by Amirhossein on 6/30/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class ContactUsVC: UIViewController ,WKUIDelegate , WKNavigationDelegate {

    @IBOutlet weak var contactWebView: WKWebView!
    
    var tracker : Bool = true
    
    let contactUsURL = "http://javaneonline.ir/blog/post/contact"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactWebView.uiDelegate = self
        contactWebView.navigationDelegate = self
        contactWebView.backgroundColor = .white
        
        if tracker {
            tracker = false
            contactWebView.loadWebPage(urlString: contactUsURL)
        }
        
        //        MARK: Configuring SVProgressHUD
        
        if contactWebView.isLoading {
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
