//
//  SettingViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/19.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    let passButtonVisible = true

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?) {
        if segue.identifier == "reSetFlavor" {
            if let  reSetFlavor = segue.destinationViewController as? FlavorsCollectionViewController {
                
                //pass "false" to FlavorsCollectionViewController
                reSetFlavor.reSetButtonVisible = passButtonVisible
                
            }
        }
        
    }

}
