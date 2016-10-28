//
//  FBLoginViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/9/30.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth


class FBLoginViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    
    @IBOutlet weak var loadSpinner: UIActivityIndicatorView!
    
    var loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginButton.hidden = true
        
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            
            let n = 1
            
            if user != nil {
                
                //儲存 firebase login user uid to NSUserDefault
                NSUserDefaults.standardUserDefaults().setObject(FIRAuth.auth()!.currentUser!.uid, forKey: "uid")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                //判斷是否有儲存已選擇的味道
                if NSUserDefaults.standardUserDefaults().objectForKey("FlavorSelect_\(n)") != nil{
                    
                    //舊用戶 -> 轉跳頁面至 store TableView
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("TarBarController") as? UITabBarController
                    self.presentViewController(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //新用戶 -> 轉跳頁面至flavor select
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("FlavorsCollectionViewController") as! UIViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                }
                
            } else {
                //取得facebook用戶public_profile、email、user_friends的權限
                
                self.loginButton.center = self.view.center
                self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
                self.loginButton.delegate = self
                
                self.view.addSubview(self.loginButton)
                
                self.loginButton.hidden = false
                
                
                
            }
        }
    }
    
    
    func loginButton (loginButton:FBSDKLoginButton!,didCompleteWithResult result:FBSDKLoginManagerLoginResult!, error:NSError!){
        //取得Facebook login
        print("user is login")
        
        self.loginButton.hidden = true
        loadSpinner.startAnimating()
        
        if(error != nil)
        {
            self.loginButton.hidden = false
            loadSpinner.stopAnimating()
            
        } else if (result.isCancelled) {
            
            self.loginButton.hidden = false
            loadSpinner.stopAnimating()
            
        } else {
            //沒有發生錯誤及取消login facebook，即向firebase註冊新帳號
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                print("user login  firebase app")
                
                //GA
                FIRAnalytics.logEventWithName("facebook_Login", parameters:nil)
                
            }
            
        }
        
    }
    func loginButtonDidLogOut(loginButton:FBSDKLoginButton!){
        print("user did logout")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
