//
//  LoadingInformation .swift
//  Balinatesttask2
//
//  Created by mac on 5/17/17.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import Alamofire
import AEXML

class LoadingInformation {
    
    static let sharedInstance = LoadingInformation()
    
    private init() {}
    
    var categories = [Category]()
    var dishes = [Dish]()
    
    func getInformation(completionHandler: @escaping () -> Void) {
        Alamofire.request("http://ufa.farfor.ru/getyml/?key=ukAXxeJYZN").responseString { response in
            switch response.result {
            case .success(let value):
                let data = value
                self.parseDataFromApi(data: data)
                completionHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseDataFromApi(data: String) {
        
        var options = AEXMLOptions()
        options.parserSettings.shouldProcessNamespaces = false
        options.parserSettings.shouldReportNamespacePrefixes = false
        options.parserSettings.shouldResolveExternalEntities = false
        
        let xml = try! AEXMLDocument(xml: data, encoding: String.Encoding.windowsCP1251, options: options)
        
        // categories name and id
        if let category = xml.root["shop"]["categories"]["category"].all {
            for item in category {
                if let name = item.value, let id = item.attributes["id"] {
                    let newCategory = Category(categoryName: name, categoryId: id)
                    categories.append(newCategory)
                }
            }
        }
        
        //dishes information
        if let dish = xml.root["shop"]["offers"]["offer"].all {
            let defaultPhoto = "?"
            let defaultName = "No name"
            let defaultWeight = "?"
            let defaultPrice = "?"
            let defaultInfo = "No information"
            let defaultCategory = "?"
            for item in dish {
                let imageURL = item["picture"].value ?? defaultPhoto
                let name = item["name"].value ?? defaultName
                let weight = item["param"].last?.value ?? defaultWeight
                let price = item["price"].value ?? defaultPrice
                let info = item["description"].value ?? defaultInfo
                let id = item["categoryId"].value ?? defaultCategory
                
                let newDish = Dish(dishName: name, dishImageUrl: imageURL, dishWeight: weight, dishPrice: price, dishInfo: info, categoryId: id)
                
                dishes.append(newDish)
            }
        }
    }
}

