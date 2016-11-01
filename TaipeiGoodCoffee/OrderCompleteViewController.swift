//
//  OrderCompleteViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/20.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import Firebase

class OrderCompleteViewController: UIViewController {
    
    let conditionRef = FIRDatabase.database().reference()
    let user = NSUserDefaults.standardUserDefaults()
    var getOrders : [Order] = []
    
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var buyerName: UILabel!
    @IBOutlet weak var receiverName: UILabel!
    @IBOutlet weak var receiverPhone: UILabel!
    @IBOutlet weak var receiverAddress: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
    @IBOutlet weak var goHome: UIButton!
    @IBAction func gotoTableView(sender: UIButton) {
        
        self.goHome.layer.cornerRadius = 5
        self.goHome.layer.masksToBounds = true
        
        //轉跳頁面到訂單完成頁
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("StoreTableView")
        
        self.navigationItem.hidesBackButton = true
        //vc.navigationItem.hidesBackButton = true
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        //self.navigationController?.pushViewController(vc, animated: true)
        
        //GA
        FIRAnalytics.logEventWithName("Goback_Home", parameters: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOrderResult()
        
        self.navigationItem.hidesBackButton = true
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Get from OrderResult from firebase
    func getOrderResult(){
        
        
        //Get User ID
        guard let uid = user.objectForKey("uid") as? String else {fatalError()}
        print("uid \(uid)")
        
        
        //Get firebase Orders
        conditionRef.child("Coffee/Orders").queryOrderedByKey().queryLimitedToLast(1).observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let orderID = snapshot.key as? String
            
          
            guard let data = snapshot.value as? Dictionary<String,String> else { return }
            let userID = data["userID"]
            let buyerName = data["buyerName"]
            let buyerPhone = data["buyerPhone"]
            let buyerAddress = data["buyerAddress"]
            let receiverName = data["receiverName"]
            let receiverPhone = data["receiverPhone"]
            let receiverAddress = data["receiverAddress"]
            let prodPrice = data["prodPrice"]
            let prodShipping = data["prodShipping"]
            let checkoutPrice = data["checkoutPrice"]
            let productID = data["productID"]
            let orderDate = data["createdTime"]
            let paymentType = data ["paymentType"]
            
            self.getOrders.append(Order(orderID: orderID! , productID: productID!, buyerName: buyerName!, buyerPhone:buyerPhone!, buyerAddress: buyerAddress!, recvicerName: receiverName!, receiverPhone: receiverPhone!, receiverAddress: receiverAddress!, shipping: prodShipping!, productPrice: prodPrice!, checkoutPrice: checkoutPrice!, orderCreateDate: orderDate!, paymentType: paymentType!, userID: userID!))
            
            //設定UILabel
            self.orderDate.text = self.getOrders[0].orderCreateDate
            self.buyerName.text = self.getOrders[0].buyerName
            self.receiverName.text = self.getOrders[0].recvicerName
            self.receiverPhone.text = self.getOrders[0].receiverPhone
            self.receiverAddress.text  = self.getOrders[0].receiverAddress
            self.orderPrice.text = self.getOrders[0].checkoutPrice
            
            
        
                
            self.conditionRef.child("coffee/Products").queryOrderedByChild("productID").queryEqualToValue("\(self.getOrders[0].productID)").observeEventType(.ChildAdded, withBlock:{ snapshot in
            
                    guard let getProduct = snapshot.value as? Dictionary<String,String> else { return }
                    let productName = getProduct["productName"]
                    //設定UILabel
                    self.prodName.text = productName
            })
            
        })
    }
}

    


    