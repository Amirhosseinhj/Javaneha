//
//  News.swift
//  Javaneha
//
//  Created by Amirhossein on 6/30/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import Foundation

struct DataModelItem {
    
    private(set) var imageAddress : String
    private(set) var heading : String
    private(set) var slug : String
    
    init ( imageAddress : String , heading : String , slug : String){
        
        self.imageAddress = imageAddress
        self.heading = heading
        self.slug = slug
    }
    
    init(){
        imageAddress = ""
        heading = ""
        slug = ""
    }
    
}



