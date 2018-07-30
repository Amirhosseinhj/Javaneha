//
//  CollectionVC.swift
//  Javaneha
//
//  Created by Amirhossein on 7/10/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit
import SVProgressHUD

class CollectionVC: UIViewController {
    
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    let categoryDataSource = DataModel()

    var myIndexPath : IndexPath? = nil
    
    var mySlug : String? = nil
    
    var futureResponseType : String? = nil {
        didSet{
            switch futureResponseType {
        
            case "post":
                performSegue(withIdentifier: "tableVC", sender: dataArray[myIndexPath!.row].slug)
                
            case "category":
            
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "collectionViewController") as! CollectionVC
                controller.navigationItem.title = barTitle
                controller.type = .slug
                controller.mySlug = dataArray[myIndexPath!.row].slug
                self.navigationController?.pushViewController(controller, animated: true)
                
            default :
                return
            }
            
        }
    }
    
    var type : Type? = nil
    
    fileprivate var dataArray = [DataModelItem]() {
        didSet{
            SVProgressHUD.dismiss()
            if dataArray.count == 0 {
                alert(goBack: true)
            }
        }
    }
    
    var tracker : Bool = true
    
    var barTitle : String? = nil
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if tracker{
            tracker = false
            
            if let hasType = self.type {
                categoryDataSource.fetch(hasType, slug: self.mySlug)
   
            }
            
        }
        
        SVProgressHUD.dismiss()
        if dataArray.count == 0 {
            SVProgressHUD.setContainerView(self.inputView)
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.show()
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        categoryDataSource.delegate = self

        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }

    
    func alert(goBack: Bool){
        
        let alert = UIAlertController(title: "عدم وجود اطلاعات", message: "هیج موردی یافت نشد.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "باشه!", style: .default) {
            (UIAlertAction) in
            if goBack {
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                
            }
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true , completion: nil)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableVC" {
            
            if let destinationVC = segue.destination as? TableVC {
                if let slug = sender as? String , let title = self.barTitle {
                    destinationVC.navigationItem.title = title
                    destinationVC.slug = slug
                }
            }
        }
    }


}



extension CollectionVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifire, for: indexPath) as? CollectionViewCell{
            cell.updateView(data: dataArray[indexPath.row])
            return cell
            
        } else {
            return CollectionViewCell()
        }
    }
    
}



extension CollectionVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        SVProgressHUD.setContainerView(self.inputView)
        SVProgressHUD.show()
        
        barTitle = dataArray[indexPath.row].heading
        
        myIndexPath = indexPath
        
        categoryDataSource.futureJSONTypeWith(url: "http://javaneonline.ir/api/category/" + dataArray[indexPath.row].slug)
        
        
        }

        
    }
    


extension CollectionVC: DataDelegate{
    
    func didParsed(data: [DataModelItem]) {

        self.dataArray.append(contentsOf: data)
        collectionView.reloadData()
        
    }
    
    func didNotGetAnyData() {
        SVProgressHUD.dismiss()
        alert(goBack: false)
    }
    func futureJSON(type: String) {
        self.futureResponseType = type
    }
}
