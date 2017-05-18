//
//  Dish.swift
//  Balinatesttask2
//
//  Created by mac on 5/17/17.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import UIKit


class Dish {
    
    let dishName: String
    let dishImageUrl: String
    let dishWeight: String
    let dishPrice: String
    let dishInfo: String
    let categoryId: String
    
    init(dishName: String, dishImageUrl: String, dishWeight: String, dishPrice: String, dishInfo: String, categoryId: String)
    {
        self.dishName = dishName
        self.dishImageUrl = dishImageUrl
        self.dishWeight = dishWeight
        self.dishPrice = dishPrice
        self.dishInfo = dishInfo
        self.categoryId = categoryId
    }
}
