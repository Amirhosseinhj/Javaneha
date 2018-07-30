//
//  NewsVC.swift
//  Javaneha
//
//  Created by Amirhossein on 6/30/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit
import SVProgressHUD

class TableVC: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    let dataSource = DataModel()

    var slug : String? = nil
    
    fileprivate var tableViewDataArray = [DataModelItem](){
        didSet{
            SVProgressHUD.dismiss()
            if tableViewDataArray.count == 0 {
                alert()
            }
        }
    }
    
    var tracker : Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        Checking if it's the first time that this view controller is being presented
        if tracker {
            tracker = false
            
//            Checking if the API Address link has a Slug
            if let hasSlug = self.slug {
                dataSource.fetch(.slug, slug: hasSlug)
            } else {
                dataSource.fetch(.news , slug: nil)
            }
            
        }
      
        
        // MARK: Setting up SVProgressHUD
        
        SVProgressHUD.dismiss()
        if tableViewDataArray.count == 0 {
            SVProgressHUD.setContainerView(self.inputView )
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.show()

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        

    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumoffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumoffset - currentOffset <= 10 {
            dataSource.loadMoreCells()
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostVC" {

            if let destinationVC = segue.destination as? PostVC {
                if let news = sender as? DataModelItem {
                    destinationVC.news = news
                }
            }
            
        }
    }
    
    
    func alert(){
        
        let alert = UIAlertController(title: "عدم وجود اطلاعات", message: "هیج موردی یافت نشد.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "باشه!", style: .default) {
            (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true , completion: nil)
        
    }
    
    
}


extension TableVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifire ) as? TableViewCell {
                cell.updateCellWith(data: tableViewDataArray[indexPath.row])
                return cell
                
            } else {
                return TableViewCell()
            }
        
        }
    
}


extension TableVC: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "PostVC", sender: tableViewDataArray[indexPath.row] )
    }
    
    
}


extension TableVC:DataDelegate {
    
    func didParsed(data : [DataModelItem]) {
        self.tableViewDataArray.append(contentsOf: data)
        tableView.reloadData()
    }
    
    func didNotGetAnyData() {

    }

    
}





