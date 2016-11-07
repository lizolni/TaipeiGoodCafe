//
//  TarBarViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/11/6.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class TarBarViewController: UITabBarController {
    
    var switchKey:Int = 0
    var passValue : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passValue = switchKey
        
        //print("print passValue \(passValue)")
        
        if passValue == 1 {
            jumptoTableView()
        }
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func jumptoTableView () {
        
        let tarbarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("StoreTableView") as! StoreTableViewController
        tarbarVC.switchKey = 1
        presentViewController(tarbarVC, animated: true, completion: nil)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "StoreTableView" {
//            if let  passkey = segue.destinationViewController as? StoreTableViewController {
//                print("print passValue \(passValue)")
//                passkey.switchKey = passValue
//            }
//        }
//    }

}
