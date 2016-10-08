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
    var flavor:String
    var flavorID:String
    var productImageID:String
    var productImage:String
    var storeID:String
    var weight:String
    
    init(data: NSDictionary) {
        productName = data["productName"] as? String ?? ""
        producer = data["producer"] as? String ?? ""
        manor = data["manor"] as? String ?? ""
        price = data["price"] as? String ?? ""
        flavor = data["flavor"] as? String ?? ""
        flavorID = data["flavorID"] as? String ?? ""
        productImageID = data["productImageID"] as? String ?? ""
        productImage = data["productName"] as? String ?? ""
        storeID = data["storeID"] as? String ?? ""
        weight = data["weight"] as? String ?? ""

        
    }
}