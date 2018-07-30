//
//  ViewController.swift
//  Javaneha
//
//  Created by Amirhossein on 6/28/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import SwiftyJSON
class HomeVC: UIViewController {
    
    //    MARK: Definig outlets
    @IBOutlet weak var announcementsBtn: UIButton!
    @IBOutlet weak var newsBtn: UIButton!
    @IBOutlet weak var creativityBtn: UIButton!
    @IBOutlet weak var achievementsBtn: UIButton!
    @IBOutlet weak var lessonsBtn: UIButton!
    @IBOutlet var slideshow: ImageSlideshow!
    
    //    MARK: Definig required constants
    let slideShowApiURL = "http://javaneonline.ir/api/slideshow"
    let imageLinks = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        MARK: Buttons Appearance
//        Button Radius
        announcementsBtn.layer.cornerRadius = 5
        newsBtn.layer.cornerRadius = 5
        creativityBtn.layer.cornerRadius = 5
        achievementsBtn.layer.cornerRadius = 5
        lessonsBtn.layer.cornerRadius = 5
        
//        Button Title Label font size
        announcementsBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        newsBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        creativityBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        achievementsBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        lessonsBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        //MARK: ImageSlideshow setup
        getSlideShowImagesData(url: slideShowApiURL)
        slideshow.slideshowInterval = 4.0
        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(HomeVC.didTap))
        slideshow.addGestureRecognizer(recognizer)

            
        
    }
    
    
    //    MARK: Button Actions
    
    @IBAction func homeButtonsPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            performSegue(withIdentifier: "CollectionVC", sender: Type.announcements)
        case 2 :
            performSegue(withIdentifier: "newsVC", sender: self)
        case 3 :
            performSegue(withIdentifier: "CollectionVC", sender: Type.creativity)
        case 4:
            performSegue(withIdentifier: "CollectionVC", sender: Type.achievements)
        case 5:
            performSegue(withIdentifier: "CollectionVC", sender: Type.lessons)
        default:
            return
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CollectionVC"{
            if let destinationVC = segue.destination as? CollectionVC {
                if let type = sender as? Type {
                    destinationVC.type = type
                    switch type {
                    case .achievements :
                        destinationVC.navigationItem.title = "دستاورد ها"
                    case .announcements:
                        destinationVC.navigationItem.title = "اطلاعیه ها"
                    case .creativity:
                        destinationVC.navigationItem.title = "خلاقیت ها"
                    case .lessons:
                        destinationVC.navigationItem.title = "موارد درسی"
                    default:
                        return

                    }
                }
            }
        }
    }

    // MARK: Alamofire Request

    func getSlideShowImagesData(url : String) {
        Alamofire.request(url).responseJSON {
            response in
            if response.result.isSuccess {
                
                let imageJSON : JSON = JSON(response.result.value!)
                self.imageSlideShowlinks(json: imageJSON)
                
                
            } else {
                print("Slideshow Address link Error")
            }
        }
    }
    
    
    //MARK: JSON Parsing
    
    func imageSlideShowlinks (json: JSON) {

        var alamofireSource : [AlamofireSource] = []
        
        for index in 1 ... (json["results"].count) {
            
            alamofireSource.append(AlamofireSource(urlString: json["results"][index - 1]["image"].stringValue)!)
            
        }
        
        slideshow.setImageInputs(alamofireSource)
        
    }
    
    
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    
    

    

}

