//
//  order.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import Foundation

class Order {
    
    let orderID : String
    let productID : String
    let buyerName : String
    let buyerPhone : String
    let buyerAddress : String
    let recvicerName : String
    let receiverPhone : String
    let receiverAddress : String
    let shipping : String
    let productPrice : String
    let checkoutPrice : String
    let orderCreateDate : String
    let paymentType : String
    let userID : String
    
    init(orderID:String,productID:String,buyerName:String,buyerPhone:String,buyerAddress:String,recvicerName:String,receiverPhone:String,receiverAddress:String,shipping:String,productPrice:String,checkoutPrice:String,orderCreateDate:String,paymentType:String,userID:String){
        
        self.orderID = orderID
        self.productID = productID
        self.buyerName = buyerName
        self.buyerPhone = buyerPhone
        self.buyerAddress = buyerAddress
        self.recvicerName = recvicerName
        self.receiverPhone = receiverPhone
        self.receiverAddress = receiverAddress
        self.shipping = shipping
        self.productPrice = productPrice
        self.checkoutPrice = checkoutPrice
        self.orderCreateDate = orderCreateDate
        self.paymentType = paymentType
        self.userID = userID
        
    }
}
