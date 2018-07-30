//
//  CollectionViewCell.swift
//  Javaneha
//
//  Created by Amirhossein on 7/10/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit
import AlamofireImage

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var collectionViewImage : UIImageView!
    @IBOutlet weak var collectionViewLabel : UILabel!
    
    class var identifire : String{
        return String(describing: self)
    }
    
    func updateView(data: DataModelItem){
        
        if let url = URL(string: data.imageAddress){
            collectionViewImage.af_setImage(withURL: url)
        }
        collectionViewLabel.text = data.heading
        collectionViewLabel.adjustsFontSizeToFitWidth = true
    }
    
}
