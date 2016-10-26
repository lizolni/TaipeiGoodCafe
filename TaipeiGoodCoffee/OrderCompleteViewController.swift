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
    
    
    @IBAction func gotoTableView(sender: AnyObject) {
        
        //轉跳頁面到訂單完成頁
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("StoreTableView")
        
        self.navigationItem.hidesBackButton = true
        //vc.navigationItem.hidesBackButton = true
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        //self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        getOrderResult()
        
        // Do any additional setup after loading the view.
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
        
        
        
        conditionRef.child("Coffee/Orders").queryOrderedByKey().observeEventType(.ChildAdded, withBlock: { snapshot in
            print ("procuts KEY: \(snapshot.key) . products value: \(snapshot.value)")
        
        //fetch firebase Coffee/Order/uid
//        conditionRef.child("Coffee/Orders").queryOrderedByChild("userID").queryEqualToValue(uid).observeEventType(.ChildAdded, withBlock:{ snapshot in
//          
//            //print ("procuts KEY: \(snapshot.key) . products value: \(snapshot.value)")
        })
    }
}
