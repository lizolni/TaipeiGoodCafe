//
//  StoreTableViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/2.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import Firebase

class StoreTableViewController: UITableViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let flavorSet = NSUserDefaults.standardUserDefaults()
    let conditionRef = FIRDatabase.database().reference()
    var stores = [Stores]()
    var products = [Products]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStoredData()
        getProductData()
        
        
        //spinner
        spinner.hidesWhenStopped = true
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        
        //UIRefreshControl - 下拉更新, 呼叫refresh func
        self.refreshControl?.addTarget(self, action: #selector(StoreTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        
    }
    
    override func didReceiveMemoryWarning() {        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("storeCell", forIndexPath: indexPath) as! StoreTableViewCell
        
        cell.storeNameCell.text = stores[indexPath.row].storeName
        cell.storeAdd.text = stores[indexPath.row].storeAddress
        cell.storePhone.text = stores[indexPath.row].storePhone
        
        //處理網路上拿下來的圖片方式，要先轉型成URL，再轉成NSData
        if let imageURL = NSURL(string: stores[indexPath.row].storeImage){
            if let data = NSData(contentsOfURL: imageURL) {
                cell.storeImageCell.image = UIImage(data:data)
            }
        }
        
        cell.serviceTime.text = stores[indexPath.row].serviceTime
        
        
        if stores[indexPath.row].isFood == "Y" {
            cell.isFood.image = UIImage(named:"Food")
        }else{
            cell.isFood.hidden = true
        }
            
        if stores[indexPath.row].isDrink == "Y" {
            cell.isDrink.image = UIImage(named:"Drink")
        }else{
            cell.isDrink.hidden = true
        }
        
        if stores[indexPath.row].isPet == "Y" {
            cell.isPet.image = UIImage(named:"Pet")
        }else{
            cell.isPet.hidden = true
        }
        
        if stores[indexPath.row].isWifi == "Y" {
            cell.isWifi.image = UIImage(named:"WIFI")
        }else{
            cell.isWifi.hidden = true
        }
        
      
        return cell
    }
    
    func getStoredData() {
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
                    
                    if let getFlavor  = snapshot.value as? NSDictionary {
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
                        //重新整理tableview
                        self.spinner.stopAnimating()
                        self.tableView.reloadData()
                        
                    }else {
                        print("Please check your Network")
                    }
                })
            }
            })
        }
    }
    }
    
    
    func getProductData() {
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
                    // talbeView.reloadData()
                }else {
                    print("getProductData fails")
                }
            })
            }
        }
    }
    
    
    //下拉更新
    func refresh(sender:AnyObject)
    {
        self.getStoredData() //重取資料
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    //傳送資料至商品清單頁
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PassProductData" {
            if let productList = segue.destinationViewController as? ProductsViewController {
                guard let storeSender = sender as? StoreTableViewCell else {
                    return
                }
                //判斷click哪個cell
                guard let indexPaxh = tableView?.indexPathForCell(storeSender) as? NSIndexPath! else{
                    return
                }
                indexPaxh.row
                
                productList.getStoreName = stores[indexPaxh.row].storeName
                productList.facebookFanPage = stores[indexPaxh.row].fbPage
                productList.getStoreImage = stores[indexPaxh.row].storeImage
                //productList.getProductArray = self.products
                productList.getStoreArray = self.stores
                
                //傳送地址給商品清單頁
                productList.getLatitude = stores[indexPaxh.row].latitude
                productList.getLongitude = stores[indexPaxh.row].longitude
                
                
            }
            
        }
    }

}


