//
//  NewsCell.swift
//  Javaneha
//
//  Created by Amirhossein on 6/30/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage : UIImageView!
    @IBOutlet weak var cellLabel : UILabel!
    
    class var identifire : String{
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        cellImage.af_cancelImageRequest()
        cellImage.image = nil
    }
    
    
    func updateCellWith (data: DataModelItem) {
        
        if let url = URL(string: data.imageAddress) {
        cellImage.af_setImage(withURL: url)
            
        }
        cellLabel.text = data.heading
        cellLabel.adjustsFontSizeToFitWidth = true
        
        
        
        
        }
        
    }



