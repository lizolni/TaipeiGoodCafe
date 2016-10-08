//
//  getFirebase.swift
//  
//
//  Created by Allen on 2016/10/3.
//
//

import Foundation
import Firebase

class FirebaseData {

    let flavorSet = NSUserDefaults.standardUserDefaults()
    let conditionRef = FIRDatabase.database().reference()
    var posts = [Products]()

        //依照flavoID_1取得product資料

    func getFlavorSelectData1() {
        if let select1 = self.flavorSet.objectForKey("FlavorSelect_1") as? NSNumber{
           
            
                conditionRef.child("coffee/Products").queryOrderedByChild("flavorID").queryEqualToValue("\(select1)").observeEventType(.Value, withBlock:{ snapshot in
                    print ("\(snapshot.key) \(snapshot.value)")
                    if let gerProducts = snapshot.value as? NSDictionary {
                        let post = Products(data: gerProducts)
                        self.posts.append(post)
                        print("+++++++++\(self.posts)")
                       // talbeView.reloadData()
                    }else {
                        print("getdata fails")
                    }
            })
        }
    }
    
                    
//                    print(productName)
//                    
//                    
//                    
//                    let t = snapshot.value!["productName"]
//                    
//                    self.test1.append(test(
//                        productName:snapshot.value!["productName"])
//                    )
                    
                    //self.test1[0].productName
//                    print("product1Struct")
//                    print(self.test1[0].productName)
//                    
//                    for child in snapshot.children {
//                        let storeID_1 = child.value["storeID"]
//                        guard let id_1 = storeID_1 as? String else{
//                            fatalError()
//                        }
//                        //依照productID取得Store資料
//                        self.conditionRef.child("coffee/Stores").queryOrderedByChild("storeID").queryEqualToValue(id_1).observeEventType(.Value, withBlock:{ snapshot in
//                            print ("\(snapshot.key) \(snapshot.value)")
//                            
//                        })}})}
//        }
    
//    //依照flavoID_2取得product資料
//    func getFlavorSelectData2() {
//        if let select2 = self.flavorSet.objectForKey("FlavorSelect_2") as? NSNumber{
//            
//            conditionRef.child("coffee/Products").queryOrderedByChild("flavorID").queryEqualToValue("\(select2)").observeEventType(.Value, withBlock:{ snapshot in
//                print ("\(snapshot.key) \(snapshot.value)")
//                
//                let testaaa = snapshot.value as? NSDictionary
//                print("testaaa")
//                print(testaaa)
//                
//                let t = snapshot.value!["productName"]
//                
//                self.test1.append(test(
//                    productName: t )
//                )
//                
//                print("product2Struct")
//                print(self.test1[0].productName)
//                
//                for child_2 in snapshot.children {
//                    let storeID_2 = child_2.value["storeID"]
//                    guard let id_2 = storeID_2 as? String else{
//                        fatalError()
//                    }
//                    
//                    //依照productID取得Store資料
//                    self.conditionRef.child("coffee/Stores").queryOrderedByChild("storeID").queryEqualToValue(id_2).observeEventType(.Value, withBlock:{ snapshot in
//                        print ("\(snapshot.key) \(snapshot.value)")
//                        
//                    })}})}
//    }
//
//    //依照flavoID_3取得product資料
//    func getFlavorSelectData3() {
//        if let select3 = self.flavorSet.objectForKey("FlavorSelect_3") as? NSNumber{
//           
//            
//        conditionRef.child("coffee/Products").queryOrderedByChild("flavorID").queryEqualToValue("\(select3)").observeEventType(.Value, withBlock:{ snapshot in
//            print ("\(snapshot.key) \(snapshot.value)")
//            
//            for child_3 in snapshot.children {
//                let stordID = child_3.value["storeID"]
//                guard let id = stordID as? String else{
//                    fatalError()
//                }
//                //依照productID取得Store資料
//                self.conditionRef.child("coffee/Stores").queryOrderedByChild("storeID").queryEqualToValue(id).observeEventType(.Value, withBlock:{ snapshot in
//                    print ("\(snapshot.key) \(snapshot.value)")
//                    
//                })}})}
//    }
//
//

//                    var dict = [String:Any]()
//                    dict["productName"] = snapshot.value!["productName"]
//                    dict["flavor"] = snapshot.value!["flavor"]
//                    dict["manor"] = snapshot.value!["manor"]
//                    dict["price"] = snapshot.value!["price"]
//                    dict["producer"] = snapshot.value!["producer"]
//                    dict["productImage"] = snapshot.value!["productImage"]
//                    dict["weight"] = snapshot.value!["weight"]

}
