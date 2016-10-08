//
//  store.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/6.
//  Copyright © 2016年 Allen. All rights reserved.
//

import Foundation


class Stores {
    var fbPage:String
    var isDrink:String
    var isFood:String
    var isPet:String
    var isWifi:String
    var latitude:String
    var longitude:String
    var serviceTime:String
    var storeAddress:String
    var storeID:String
    var storeImage:String
    var storeImageID : String
    var storeName:String
    var storePhone:String

    
    init(data: NSDictionary) {
        
        
         fbPage = data["fbPage"] as? String ?? ""
         isDrink = data["isDrink"] as? String ?? ""
         isFood = data["isFood"] as? String ?? ""
         isPet = data["isPet"] as? String ?? ""
         isWifi = data["isWifi"] as? String ?? ""
         latitude = data["latitude"] as? String ?? ""
         longitude = data["longitude"] as? String ?? ""
         serviceTime = data["serviceTime"] as? String ?? ""
         storeAddress = data["storeAddress"] as? String ?? ""
         storeID = data["storeID"] as? String ?? ""
         storeImage = data["storeImage"] as? String ?? ""
         storeImageID = data["storeImageID"] as? String ?? ""
         storeName = data["storeName"] as? String ?? ""
         storePhone = data["storePhone"] as? String ?? ""
        
        
    }
}
