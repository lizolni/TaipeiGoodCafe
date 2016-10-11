//
//  ProductsViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/8.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import SafariServices

class ProductsViewController: UIViewController,SFSafariViewControllerDelegate {

   let systemVersion = UIDevice.currentDevice().systemVersion
    
    @IBOutlet weak var storeImage: UIImageView!
    
    var getStoreName : String!
    var facebookFanPage :String!
    var getStoreImage : String!
    var getLatitude : String!
    var getLongitude : String!
    
    var getStoreArray:[Stores]!
    var getProductArray:[Products]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NivagationBar title Name
        self.title = getStoreName
        
        //處理store頁傳來的圖片方式，要先轉型成URL，再轉成NSData
        if let imageURL = NSURL(string: getStoreImage ){
            if let data = NSData(contentsOfURL: imageURL) {
                self.storeImage.image = UIImage(data:data)
                }
            }
        }

    @IBAction func fbFanPage(sender: UIButton) {
        //判斷iPhone iOS版本
        //iOS 9
        if #available(iOS 9, *) {
            //取得NSUserDefault所儲存的Picture值 (FBLoginViewController.swift)
            if let fbImageURL = facebookFanPage as? String {
                //使用SFSafariViewController載入網頁內容
                let safariViewController = SFSafariViewController(URL: NSURL(string:(facebookFanPage as? String)!)!, entersReaderIfAvailable: true)
                //設定delegate
                safariViewController.delegate = self
                self.presentViewController(safariViewController, animated: true, completion: nil)
            }
        } else {
            //iOS 8
            if let fbImageUrl = NSUserDefaults.standardUserDefaults().objectForKey("link"){
                let url = NSURL(string:(fbImageUrl as? String)!)!
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    
//    @IBAction func viewStoreMap(sender: UIButton) {
//    
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?) {
            if segue.identifier == "showStoreMap" {
                if let  passLocation = segue.destinationViewController as? MapViewController {
                    
                    
                    passLocation.getStoreLatitude = getLatitude
                    passLocation.getStoreLongtitude = getLongitude
                    
                }
            }
        }
    
}
