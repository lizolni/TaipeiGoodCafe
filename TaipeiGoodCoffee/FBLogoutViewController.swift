//
//  FBLogoutViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/1.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FirebaseAuth

class FBLogoutViewController: UIViewController {
    
    @IBAction func logout(sender: AnyObject) {
        
        navigationItem.title = "facebook設定"
        
        // sign the user out of the firebase
        try! FIRAuth.auth()!.signOut()
        
        //sign the user out of the Facebook
        FBSDKAccessToken.setCurrentAccessToken(nil)
        var n = 1
        for fetch in 1...3 {
            if NSUserDefaults.standardUserDefaults().objectForKey("FlavorSelect_\(n)") != nil{
                
                // facebook logout -> clean select flavor
                NSUserDefaults.standardUserDefaults().removeObjectForKey("FlavorSelect_\(n)")
                
            }
            n += 1
        }
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("FBLogin") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
