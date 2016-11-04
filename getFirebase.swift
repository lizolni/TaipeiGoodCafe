//
//  getFirebase.swift
//
//
//  Created by Allen on 2016/10/3.
//
//

import Foundation
import Firebase

protocol GetFirebaseDataDelegate:class {
    func getStoreData (manager : FirebaseData , didGetStoreData : [Stores])
    func getProductData (manager: FirebaseData , didGetProductsData : [Products])
}



class FirebaseData {
    
    //delegate GetFirebaseDataDelegate
    weak var delegate : GetFirebaseDataDelegate?
    
    //singleton
    static let shared = FirebaseData()
    
    let flavorSet = NSUserDefaults.standardUserDefaults()
    let conditionRef = FIRDatabase.database().reference()
    var stores = [Stores]()
    var products = [Products]()
    
    //依照flavoID_1取得product資料
    
    func fetchStore() {
        
        self.stores.removeAll()
        //抓取NSUserDefault 1-3 的值
        var n = 1
        for select in 1...3 {
            if let selectFlavorID = self.flavorSet.objectForKey("FlavorSelect_\(n)") as? NSNumber {
                n += 1
                
                conditionRef.child("coffee/Products").queryOrderedByChild("flavorID").queryEqualToValue("\(selectFlavorID)").observeEventType(.Value, withBlock:{ snapshot in
                    //print ("procuts KEY: \(snapshot.key) . products value: \(snapshot.value)")
                    
                    for child in snapshot.children {
                        
                        let storeID_1 = child.value["storeID"]
                        guard let id_1 = storeID_1 as? String else{
                            fatalError()
                        }
                        //依照productID取得Store資料
                        self.conditionRef.child("coffee/Stores").queryOrderedByChild("storeID").queryEqualToValue(id_1).observeEventType(.ChildAdded, withBlock:{ snapshot in
                            //print ("stores KEY\(snapshot.key) . Store Value\(snapshot.value)")
                            
                            if let getFlavor = snapshot.value as? NSDictionary {
                                let getStore = Stores(data: getFlavor)
                                
                                //判斷重複store的開關
                                var haveSameStore = false
                                
                                //判斷重複
                                for store in self.stores {
                                    if store.storeID == getStore.storeID {
                                        haveSameStore = true
                                    }
                                }
                                //重複為false的時候才把store加到stores array
                                if !haveSameStore {
                                    self.stores.append(getStore)
                                }else{
                                    print("add to array fails")
                                }
                                
                            }else{
                                print("Please check your Network")
                            }
                            //執行Delegate，若正確，回傳給StoreTableViewController
                            self.delegate?.getStoreData(self,didGetStoreData : self.stores)
                        })
                    }
                })
            }
        }
    }
    
    func fetchProducts() {
        
        self.products.removeAll()
        //抓取NSUserDefault 1-3 的值
        var n = 1
        for select in 1...3 {
            if let selectProductFlavorID = self.flavorSet.objectForKey("FlavorSelect_\(n)") as? NSNumber{
                n += 1
                
                conditionRef.child("coffee/Products").queryOrderedByChild("flavorID").queryEqualToValue("\(selectProductFlavorID)").observeEventType(.ChildAdded, withBlock:{ snapshot in
                    //print ("procuts KEY: \(snapshot.key) . products value: \(snapshot.value)")
                    
                    if let getProductFlavor = snapshot.value as? NSDictionary {
                        let getProduct = Products(data: getProductFlavor)
                        self.products.append(getProduct)
                        }else {
                        print("getProductData fails") 
                    }
                    self.delegate?.getProductData(self, didGetProductsData: self.products)
                })
            }
        }
    }
    
    func fetchAllStore() {
        
        self.stores.removeAll()
        //抓取NSUserDefault 1-12 的值
        var fid = 1
        for select in 1...12 {
            
            conditionRef.child("coffee/Products").queryOrderedByChild("flavorID").queryEqualToValue("\(fid)").observeEventType(.Value, withBlock:{ snapshot in
                print ("procuts KEY: \(snapshot.key) . products value: \(snapshot.value)")
                
                for child in snapshot.children {
                    let storeID_1 = child.value["storeID"]
                    guard let id_1 = storeID_1 as? String else {
                        print(" not match flavorID equal to storeID")
                        break
                    }

                    //依照productID取得Store資料
                    self.conditionRef.child("coffee/Stores").queryOrderedByChild("storeID").queryEqualToValue(id_1).observeEventType(.ChildAdded, withBlock:{ snapshot in
                        print ("stores ALL KEY\(snapshot.key) . Store All Value\(snapshot.value)")

                        if let getFlavor = snapshot.value as? NSDictionary {
                            let getStore = Stores(data: getFlavor)

                            //判斷重複store的開關
                            var haveSameStore = false
                            
                            //判斷重複
                            for store in self.stores {
                                if store.storeID == getStore.storeID {
                                    haveSameStore = true
                                }
                            }
                            //重複為false的時候才把store加到stores array
                            if !haveSameStore {
                                self.stores.append(getStore)
                            }else{
                                print("add to array fails")
                            }
                            
                        }else {
                            print("Please check your Network")
                        }
                        //執行Delegate，若正確，回傳給StoreTableViewController
                        self.delegate?.getStoreData(self,didGetStoreData : self.stores)
                    })
                }
            })
            fid += 1
        }
    }

    
    
    func fetchAllProducts() {
        
        self.products.removeAll()
        //抓取NSUserDefault 1-12 的值
        var fid = 1
        for select in 1...12 {
            
                conditionRef.child("coffee/Products").queryOrderedByChild("flavorID").queryEqualToValue("\(fid)").observeEventType(.ChildAdded, withBlock:{ snapshot in
                    
                    print ("procuts KEY: \(snapshot.key) . products value: \(snapshot.value)")
                    
                    if let getProductFlavor = snapshot.value as? NSDictionary {
                        let getProduct = Products(data: getProductFlavor)
                        self.products.append(getProduct)
                    }else {
                        print("getProductData fails")
                    }
                    self.delegate?.getProductData(self, didGetProductsData: self.products)
                })
            fid += 1
            }
        }
}