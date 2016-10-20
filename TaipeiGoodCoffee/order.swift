//
//  order.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import Foundation

class Order {
    
    var orderID : String
    let productID : String
    let productName : String
    var price : String
    var quantity : String
    var buyer : String
    var buyerPhone : String
    var buyerAddress : String
    var recvicer : String
    var receiverPhone : String
    var receiverAddress : String
    var shipping : Int
    var productPrice : Int
    var checkoutPrice : Int
    
    init(orderID:String,productID:String,productName:String,price:String,quantity:String,buyer:String,buyerPhone:String,buyerAddress:String,recvicer:String,receiverPhone:String,receiverAddress:String,shipping:Int,productPrice:Int,checkoutPrice:Int){
        
        self.orderID = orderID
        self.productID = productID
        self.productName = productName
        self.price = price
        self.quantity = quantity
        self.buyer = buyer
        self.buyerPhone = buyerPhone
        self.buyerAddress = buyerAddress
        self.recvicer = recvicer
        self.receiverPhone = receiverPhone
        self.receiverAddress = receiverAddress
        self.shipping = shipping
        self.productPrice = productPrice
        self.checkoutPrice = checkoutPrice
        
    }
}
