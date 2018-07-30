//
//  DataService.swift
//  Javaneha
//
//  Created by Amirhossein on 6/30/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol DataDelegate: class {
    func didParsed(data: [DataModelItem])
    func didNotGetAnyData()
    func futureJSON(type : String)
    
}
// Making futureJSON(type : String) function optional
extension DataDelegate {
    func futureJSON(type : String) {
        
    }
}


enum Type {
    case news
    case announcements
    case creativity
    case achievements
    case lessons
    case slug
    
}


class DataModel {
    
    // A Singleton
//    static let instance = DataService()
    
    weak var delegate: DataDelegate?
    
    private var i : Int = 0
    private var JSONData = JSON()
    
    
    func fetch(_ type: Type , slug: String?){
        
        //        MARK: Configuring the API Link
        var url : String {
        switch type {
                    case .news:
                        return "http://javaneonline.ir/api/category/news"
                    case .announcements:
                        return "http://javaneonline.ir/api/category/announcements"
                    case .achievements:
                        return "http://javaneonline.ir/api/category/achievements"
                    case .creativity:
                        return "http://javaneonline.ir/api/category/creativity"
                    case .lessons:
                        return "http://javaneonline.ir/api/category/lessons"
                    case .slug:
                        if let hasSlug = slug {
                            return "http://javaneonline.ir/api/category/" + hasSlug
                        } else {
                            print("Slug Error")
                            return ""
            }
            
                    }
        }
        
        
        //    MARK: Alamofire request for JSON Data
        
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            
            Alamofire.request(encoded).responseJSON {
                response in
                if response.result.isSuccess {
                    
                    if (JSON(response.result.value!))["success"].stringValue == "1" {
                        
                        self.JSONData = (JSON(response.result.value!))["results"]
                        self.ParseJSON()
                        
                    } else {
                        print("Success = 0")
                        self.delegate?.didNotGetAnyData()
                    }
                    
                    
                }
                else {
                    print("API Link Error: \(url)")
                    self.delegate?.didNotGetAnyData()
                }
            }
        }
        
        
    }
    
    
    //    MARK: JSON Parsing
    
    private func ParseJSON() {
        var parsedJSONData:[DataModelItem] = []
    
        for index in i ... i + 19 {
            if index <= (self.JSONData.count - 1) {
            parsedJSONData.append( DataModelItem(
                                    imageAddress: self.JSONData[index]["image"].stringValue,
                                    heading: self.JSONData[index]["title"].stringValue,
                                    slug: self.JSONData[index]["slug"].stringValue))
            } else {
                break
            }
        }
        
        self.delegate?.didParsed(data: parsedJSONData)
        
    }
    
    
    //    MARK: A function helping to load More Cells when the User did end Dragging
    
    func loadMoreCells(){
        
        if self.i < self.JSONData.count {
            self.i += 20
            self.ParseJSON()
            
        }
        
    }
    
    
    //    MARK: Finding out Type of JSON of the selected Cell by the User in CollectionVC
    
    func futureJSONTypeWith(url: String){
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            Alamofire.request(encoded).responseJSON {
                response in
                
                if response.result.isSuccess {
                    if (JSON(response.result.value!))["success"].stringValue == "1" {
                        
                        switch (JSON(response.result.value!))["type"].stringValue {
                        case "post" :
                            self.delegate?.futureJSON(type: "post")
                        case "category" :
                            self.delegate?.futureJSON(type: "category")
                        default:
                            self.delegate?.didNotGetAnyData()
                            
                        }
                    } else {
                        self.delegate?.didNotGetAnyData()
                    }
                    
                    
                } else {
                    print(url)
                    self.delegate?.didNotGetAnyData()
                    
                }
                
            }
            
        }

    }
    
    deinit {
        print("Data Model Deinitializer!")
    }
    

    
    
}
