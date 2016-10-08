//
//  storeModel.swift
//  
//
//  Created by Allen on 2016/10/3.
//
//

import Foundation

 class StoreModel {
    
    let name : String
    let address : String
    let phone : String
    let imageID : Int
    let image  : String
    let serviceTime : String
    let latitude : Double
    let longitude : Double
    let fbPage : String
    let isFood : Bool
    let isDrink : Bool
    let isPet : Bool
    let isWIFI : Bool

    
    init (name:String,address:String,phone:String,imageID:Int,image:String,serviceTime:String,latitude:Double,longitude:Double,fbPage:String,isFood:Bool,isDrink:Bool,isPet:Bool,isWIFI:Bool) {
        self.name = name
        self.address = address
        self.phone = phone
        self.imageID = imageID
        self.image = image
        self.serviceTime = serviceTime
        self.latitude = latitude
        self.longitude = longitude
        self.fbPage = fbPage
        self.isFood = isFood
        self.isDrink = isDrink
        self.isPet = isPet
        self.isWIFI = isWIFI
    }
}