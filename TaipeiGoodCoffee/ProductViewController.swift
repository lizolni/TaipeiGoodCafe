//
//  ProductViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/13.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FBSDKShareKit

class ProductViewController: UIViewController {
    
    //show product items
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productFavorites: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productProducer: UILabel!
    @IBOutlet weak var productManor: UILabel!
    @IBOutlet weak var productWeight: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
   

    var image : String!

    var name : String = ""
    var producer : String = ""
    var manor : String = ""
    var weight : String = ""
    var flavorDescription : String = ""
    var price : String = ""
    var productId : String = ""
    
    var showProduct = [Products]()
    let conditionRef = FIRDatabase.database().reference()
    var NSuser = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productName.text = name
        productProducer.text = producer
        productManor.text = manor
        productWeight.text = weight
        productDescription.text = flavorDescription
        productPrice.text = ("$\(price)")
          
        //圖片要先轉型成URL，再轉成NSData
        
        if let imageURL = NSURL(string: image){
            if let data = NSData(contentsOfURL: imageURL) {
                self.productImage.image = UIImage(data:data)
                self.productImage.layer.cornerRadius = 5
                self.productImage.layer.masksToBounds = true
            }
        }
    }
    

    //share
    @IBAction func shareToFB(sender: UIButton) {
        let imageToShare : UIImage
        if let imageURL = NSURL(string: image){
            if let data = NSData(contentsOfURL: imageURL) {
                imageToShare = UIImage(data:data)!
                share(shareText: self.name, shareImage: imageToShare)
            }
        }
    }
    
    func share(shareText shareText:String?,shareImage:UIImage?){
        
        var objectsToShare = [AnyObject]()
        
        if let shareTextObj = shareText{
            objectsToShare.append(shareTextObj)
        }
        
        if let shareImageObj = shareImage{
            objectsToShare.append(shareImageObj)
        }
        
        if shareText != nil || shareImage != nil{
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            presentViewController(activityViewController, animated: true, completion: nil)
        }else{
            print("There is nothing to share")
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //傳值至購物車頁
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addCart" {
            if let addToCart = segue.destinationViewController as? CartViewController {
                addToCart.getProdName = self.name
                addToCart.getProdPrice = self.price
                addToCart.getProdImage = self.image
                addToCart.getProdID = self.productId
                
                //GA
                FIRAnalytics.logEventWithName("addToCart", parameters: nil)
                
                
            }
        }
    }
    
    //點擊我的最愛by商品
    @IBAction func productFavorites(sender: AnyObject) {
        var prodFlavorites : NSDictionary = [:]
        var prodID : AnyObject = ""
        let uid = self.NSuser.objectForKey("uid")
        
        if uid == nil {
            return fatalError()
        }
        let user = uid
        prodID = self.productId
        
        prodFlavorites = [user as! String : true]
        let addProdFlavoritesTOFirebase = conditionRef.child("Coffee").childByAppendingPath("productFavorites").childByAppendingPath(productId)
        addProdFlavoritesTOFirebase.setValue(prodFlavorites)
        
        //GA
        FIRAnalytics.logEventWithName("Product_Favorites", parameters: nil)
        
        //showAlert 3 Sec
        let alertController = UIAlertController(title: "", message: "已加入我的最愛", preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        
        
    }

    
}
