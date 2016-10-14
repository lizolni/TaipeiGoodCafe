//
//  post.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/5.
//  Copyright © 2016年 Allen. All rights reserved.
//

import Foundation


class Products {
    var productName:String
    var producer:String
    var manor:String
    var price:String
    var flavorDescription:String
    var flavorID:String
    var productID : String
    var productImageID:String
    var productImage:String
    var storeID:String
    var weight:String
    
    init(data: NSDictionary) {
        productName = data["productName"] as? String ?? ""
        producer = data["producer"] as? String ?? ""
        manor = data["manor"] as? String ?? ""
        price = data["price"] as? String ?? ""
        flavorDescription = data["flavorDescription"] as? String ?? ""
        flavorID = data["flavorID"] as? String ?? ""
        productImageID = data["productImageID"] as? String ?? ""
        productImage = data["productImage"] as? String ?? ""
        storeID = data["storeID"] as? String ?? ""
        weight = data["weight"] as? String ?? ""
        productID = data["productID"] as? String ?? ""

        
    }
}