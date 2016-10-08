//
//  products.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/5.
//  Copyright © 2016年 Allen. All rights reserved.
//

import Foundation

struct products {
    
    let productName:String
    let producer:String
    let manor:String
    let price:Int
    let flavor:String
    let flavorID:Int
    let productImageID:Int
    let productImage:String
    let storeID:Int
    let weight:String
    
    init(productName:String,producer:String,manor:String,price:Int,flavorID:Int,flavor:String,productImageID:Int,productImage:String,storeID:Int,weight:String){
        self.productName = productName
        self.producer = producer
        self.productImageID = productImageID
        self.productImage = productImage
        self.manor = manor
        self.price = price
        self.flavor = flavor
        self.flavorID = flavorID
        self.storeID = storeID
        self.weight = weight

        
        
    }
    
}
