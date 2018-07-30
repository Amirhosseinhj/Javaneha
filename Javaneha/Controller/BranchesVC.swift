//
//  BranchesVC.swift
//  Javaneha
//
//  Created by Amirhossein on 7/1/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class BranchesVC: UIViewController ,WKUIDelegate , WKNavigationDelegate {
    
    @IBOutlet weak var branchesWebView: WKWebView!
    
    var tracker : Bool = true
    
    let branchesURL = "http://javaneonline.ir/blog/post/branch"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        branchesWebView.uiDelegate = self
        branchesWebView.navigationDelegate = self
        branchesWebView.backgroundColor = .white
        if tracker {
            tracker = false
            branchesWebView.loadWebPage(urlString: branchesURL)
            
        }
        
        //        MARK: Configuring SVProgressHUD
        
        if branchesWebView.isLoading {
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
