//
//  WebKitExt.swift
//  Javaneha
//
//  Created by Amirhossein on 7/9/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import WebKit

extension WKWebView {
    
    
    func initialZoomScale(scalable: Bool){
        
        if scalable {
            self.evaluateJavaScript("var meta = document.createElement('meta');" +
                "meta.setAttribute( 'name', 'viewport' ); " +
                "meta.setAttribute( 'content', 'width = device-width, initial-scale = 1.0, user-scalable = yes' ); " +
                "document.getElementsByTagName('head')[0].appendChild(meta)" , completionHandler: nil)
            
        } else {
            self.evaluateJavaScript("var meta = document.createElement('meta');" +
                "meta.setAttribute( 'name', 'viewport' ); " +
                "meta.setAttribute( 'content', 'width = device-width, initial-scale = 1.0, user-scalable = no' ); " +
                "document.getElementsByTagName('head')[0].appendChild(meta)" , completionHandler: nil)
        }
        
    }
    
    
    func loadWebPage (urlString: String) {
        
        if let url = URL(string: urlString){
            self.load(URLRequest(url: url))
            
        } else {
            
            if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) , let url = URL(string: encoded) {
                self.load(URLRequest(url: url))
            }
        }
        
    }
    
    
    func getScrollableHeight(completion: @escaping ((_ height: CGFloat)-> Void) ) {

        self.evaluateJavaScript("document.readyState") {
            (complete, error) in
            if complete != nil {
                self.evaluateJavaScript("document.body.scrollHeight")
                    { (height, error) in
                    completion(height as! CGFloat)
                    
                }
            }

        }
        
    }
    
    
    
}
