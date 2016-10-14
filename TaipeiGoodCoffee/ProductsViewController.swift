//
//  ProductsViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/8.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import SafariServices


class ProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,SFSafariViewControllerDelegate {
    
    //collectionView
    @IBOutlet weak var productsCollection: UICollectionView!
    
    //判斷User iOS版本
   let systemVersion = UIDevice.currentDevice().systemVersion
    
    @IBOutlet weak var storeImage: UIImageView!
    
    var getStoreName : String!
    var facebookFanPage :String?
    var getStoreImage : String!
    var getLatitude : String?
    var getLongitude : String?
    var selectStoreID : String?
    var selectProductID : String?
    var pos:Int!
    
    var getStoreArray = [Stores]()
    var getProductArray = [Products]()
    var showProductArray = [Products]()
    var clickProductArray = [Products]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.productsCollection.pagingEnabled = false
        self.productsCollection!.contentInset = UIEdgeInsetsMake(10,10,10,-10)
        
     
        
        //NivagationBar title Name
        self.title = getStoreName
        
        //處理store頁傳來的圖片方式，要先轉型成URL，再轉成NSData
        if let imageURL = NSURL(string: getStoreImage ){
            if let data = NSData(contentsOfURL: imageURL) {
                self.storeImage.image = UIImage(data:data)
                }
            }
        
        for a in getProductArray{
            print ("flavors \(String(a.flavorDescription))")
            }
        
        
        //算被點擊的product
        for fetchProduct in getProductArray {
            if fetchProduct.storeID == selectStoreID{
                showProductArray.append(fetchProduct)
                
                for clickProduct in showProductArray{
                    if clickProduct.productID == selectProductID {
                        clickProductArray.append(clickProduct)
                        print("print clickProductArray \(clickProductArray)")
                    }
                }
            }
        }
    }
    

    @IBAction func fbFanPage(sender: UIButton) {
        //判斷iPhone iOS版本
        //iOS 9
        if #available(iOS 9, *) {
            //取得NSUserDefault所儲存的Picture值 (FBLoginViewController.swift)
            if let fbImageURL = facebookFanPage as? String! {
                //使用SFSafariViewController載入網頁內容
                let safariViewController = SFSafariViewController(URL: NSURL(string:(facebookFanPage as? String!)!)!, entersReaderIfAvailable: true)
                //設定delegate
                safariViewController.delegate = self
                self.presentViewController(safariViewController, animated: true, completion: nil)
            }
        } else {
            //iOS 8
            if let fbImageUrl = facebookFanPage as? String! {
                let url = NSURL(string:(fbImageUrl as? String)!)!
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
   

     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return showProductArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductsCell", forIndexPath: indexPath) as! ProductsViewCell

        //處理網路上拿下來的圖片方式，要先轉型成URL，再轉成NSData
        //print("image \(showProductArray[indexPath.row].productImage)")
        
        if let imageURL = NSURL(string: showProductArray[indexPath.row].productImage){
            if let data = NSData(contentsOfURL: imageURL) {
                cell.productsImageForCell.image = UIImage(data:data)
            }
        }

        cell.productsNameForCell.text = self.showProductArray[indexPath.row].productName
        print("\(showProductArray[indexPath.row].productName)")

        
        return cell
    }
    
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsetsMake(0, 16, 0, 16)
    }
    
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //return CGSizeMake( self.view.frame.size.width / 3, 140);
        return CGSizeMake(200, 160)
    }
    
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?) {
        if segue.identifier == "showStoreMap" {   //傳送地圖座標+店名至地圖頁
            if let  passLocationVC = segue.destinationViewController as? MapViewController {
                
                passLocationVC.getStoreLatitude = getLatitude
                passLocationVC.getStoreLongtitude = getLongitude
                passLocationVC.getStoreNameForMap = getStoreName
                
            }
        } else if segue.identifier == "showProduct" {  //傳送collectionView被點選的商品資料至商品頁
            if let productVC = segue.destinationViewController as? ProductViewController{
                guard let productCell = sender as? ProductsViewCell else {
                    return
                }
                guard let indexPath = productsCollection?.indexPathForCell(productCell) as? NSIndexPath! else {
                    return
                }
                indexPath.row
                
                print("prepareForsegue \(self.showProductArray[indexPath.row].productName)")
                print("prepareForsegue \(self.showProductArray[indexPath.row].producer)")
                print("prepareForsegue \(self.showProductArray[indexPath.row].productImage)")
                print("prepareForsegue \(self.showProductArray[indexPath.row].manor)")
                print("prepareForsegue \(self.showProductArray[indexPath.row].weight)")
                print("prepareForsegue \(self.showProductArray[indexPath.row].price)")
                print("prepareForsegue \(self.showProductArray[indexPath.row].flavorDescription)")
                
                productVC.name = self.clickProductArray[indexPath.row].productName
                productVC.producer = self.clickProductArray[indexPath.row].producer
                productVC.manor = self.clickProductArray[indexPath.row].manor
                productVC.weight = self.clickProductArray[indexPath.row].weight
                productVC.flavorDescription = self.clickProductArray[indexPath.row].flavorDescription
                productVC.price = self.clickProductArray[indexPath.row].price
                productVC.image = self.clickProductArray[indexPath.row].productImage
                
            }
        }
    }
}
