//
//  StoreTableViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/2.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import Firebase

class StoreTableViewController: UITableViewController,GetFirebaseDataDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let flavorSet = NSUserDefaults.standardUserDefaults()
    let conditionRef = FIRDatabase.database().reference()
    var stores = [Stores]()
    var products = [Products]()
    var switchKey:Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "找咖啡"
        UINavigationBar.appearance().barTintColor = UIColor(red: 112/255, green: 247/255, blue: 247/255, alpha: 1.0)
        
    
        //delegate FirebaseData
        FirebaseData.shared.delegate = self
        
        let getDataSwitch = switchKey
        
        if getDataSwitch == 1 {
            
            //call Firebase fetchAllStore
            FirebaseData.shared.fetchAllStore()
            
            //call Firebase fetchAllProducts function
            FirebaseData.shared.fetchAllProducts()
            
        }else{
            
            //call Firebase fetchStore function
            FirebaseData.shared.fetchStore()
            
            //call Firebase fetchPrducts function
            FirebaseData.shared.fetchProducts()
        }
        
        //spinner
        spinner.hidesWhenStopped = true
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
                
        //refresh control
        refreshControl = UIRefreshControl()
        self.view.addSubview(refreshControl!)
        
    }
    
    func getStoreData(manager: FirebaseData, didGetStoreData: [Stores]) {
        stores = didGetStoreData
        
        dispatch_async(dispatch_get_main_queue(), {
           self.tableView.reloadData()
        })
    
        //stop spinner
        self.spinner.stopAnimating()
    }
    
    func getProductData(manager: FirebaseData, didGetProductsData: [Products]) {
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            self.products = didGetProductsData
        })
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
     func layoutSubviews() {
        tableView.frame = UIEdgeInsetsInsetRect(tableView.frame, UIEdgeInsetsMake(0, 0, 0, 0))
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
        
        //取消預設分隔線
        tableView.separatorStyle = .None
        cell.layer.borderWidth = 0
        cell.clipsToBounds = true
        
        //cell radius
        cell.layer.cornerRadius = 10
        //cell.layer.borderColor = UIColor.grayColor().CGColor
        
        
        //設定值
        cell.storeNameCell.text = stores[indexPath.row].storeName
        cell.storeAdd.text = stores[indexPath.row].storeAddress
        cell.storePhone.text = stores[indexPath.row].storePhone
        
        //處理網路上拿下來的圖片方式，要先轉型成URL，再轉成NSData
        if let imageURL = NSURL(string: stores[indexPath.row].storeImage){
            if let data = NSData(contentsOfURL: imageURL) {
                
                cell.storeImageCell.image = UIImage(data:data)
                
                cell.storeImageCell.layer.cornerRadius = 5
                cell.storeImageCell.layer.masksToBounds = true
                
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
        
        //UIRefreshControl - 下拉更新, 呼叫refresh func
        self.refreshControl?.addTarget(self, action: #selector(StoreTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        
        return cell
    }
    
    //下拉更新
    func refresh(sender:AnyObject)
    {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    //傳送資料至商品清單頁
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showProductList" {
            if let productList = segue.destinationViewController as? ProductsViewController {
                guard let storeSender = sender as? StoreTableViewCell else {
                    return
                }
                
                //判斷點擊哪個cell
                guard let indexPaxh = tableView?.indexPathForCell(storeSender) as? NSIndexPath! else{
                    return
                }
                
                indexPaxh.row
                
                
                productList.getStoreName = stores[indexPaxh.row].storeName
                productList.facebookFanPage = stores[indexPaxh.row].fbPage
                productList.getStoreImage = stores[indexPaxh.row].storeImage
                productList.selectStoreID = stores[indexPaxh.row].storeID
                productList.selectProductID = products[indexPaxh.row].productID
                
                //傳送地址給商品清單頁
                productList.getLatitude = stores[indexPaxh.row].latitude
                productList.getLongitude = stores[indexPaxh.row].longitude
                
                //傳整包Store及product
                productList.getProductArray = self.products
                productList.getStoreArray = self.stores
                
                //GA
                FIRAnalytics.logEventWithName("\(stores[indexPaxh.row].storeName)", parameters: nil)
                
                
            }
        }
    }
 }