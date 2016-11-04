//
//  FlavorsCollectionViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/9/29.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit


//private let reuseIdentifier = "FlavorCell"

class FlavorsCollectionViewController: UICollectionViewController {

    @IBOutlet var collection: UICollectionView!
    
    var fullScreenSize:CGSize!
    var flavorData = [FlavorInfo]()
    var clickCount = 0
    var flavorSet = NSUserDefaults.standardUserDefaults()
    var flavorName = [String]()
    var flavorId = [Int]()
    var reSetButtonVisible:Bool?
    
    //Navigation right button
    @IBAction func reSaveFlavors(sender: AnyObject) {
        
        self.saveFlavor(sender)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.barTintColor=UIColor.redColor();


        
        //UINavigationBar.appearance().barTintColor = UIColor(red: 125/255, green: 205/255, blue: 206/255, alpha: 1.0)
        
        
        
        //設定collectionView的上下左右間距
        self.collectionView!.contentInset = UIEdgeInsetsMake(20,0,10,0)
        
        //取得 Screen size
        fullScreenSize = UIScreen.mainScreen().bounds.size
        
        // Register cell classes，建立collectionView自動產生，Mark掉就可以執行不會crash
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
        
        //畫Layout
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(CGFloat(UIScreen.mainScreen().bounds.width/3 - 20.0),CGFloat(UIScreen.mainScreen().bounds.width/3 - 20.0))
        //set Grid Spacing
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        //header的高度
        layout.headerReferenceSize = CGSize(
            width: fullScreenSize.width, height: 40)
        
        //在UICollectionViewFlowLayout中註冊UIColectionReusbleView
        collection.registerClass(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier: "Header")

        
        
        //flavor Data
        let flavorArrayName = ["草莓","巧克力","檸檬","薄菏","麥茶","黑莓","木頭香","紅酒","茉莉花","玫瑰","蜂蜜","青蘋果"]
        
        //將flavor儲存到FlavorInfo class的Instance
        for i in 1...flavorArrayName.count {
            let info = FlavorInfo()
            info.id = i
            info.name = flavorArrayName[i-1]
            let value:CGFloat = CGFloat(i)
            flavorData.append(info)
            
        //get from Setting pass value.
        // visible/hide reSaveFlavors (@IBaction)
            let saveButton = reSetButtonVisible
            
                if  saveButton == false {
                    self.navigationItem.rightBarButtonItem?.enabled = false
                    self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clearColor()
                } else {
                    self.navigationItem.rightBarButtonItem?.enabled = true
                    self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blackColor()
            }
        }
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveFlavor(sender: AnyObject) {
               
        //submit處理
        if clickCount < 3 {  //選擇少於3種的處理 //"Please choose 3 flavors"
            let nonSelectAlert = UIAlertController(title: "風味選擇", message:
                "請選擇三種風味", preferredStyle: UIAlertControllerStyle.Alert)
            nonSelectAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler:nil))
            
            self.presentViewController(nonSelectAlert, animated: true, completion: nil)
            
        } else {
        for FlavorInfo  in flavorData {
            if FlavorInfo.isSelect { //處理被選到的值
                self.flavorId.append(FlavorInfo.id) //取出ID
                //self.flavorName.append(FlavorInfo.name) //取出味道的名稱
                //print ("this is flavor id \(self.flavorId)") -> 存成Array
                
                //判斷是否有NSUserDefault， 如果有就先清掉
                var m = 1
                for clean  in 1...3 {
                    if flavorSet.objectForKey("FlavorSelect_\(m)") != nil {
                    
                        flavorSet.removeObjectForKey("FlavorSelect_\(m)")
                        m += 1
                    }
                }
            }
        }
            
        var n = 1
        //儲存被選取的值到NSUserDefaults
        for tempID in self.flavorId {
            flavorSet.setObject(tempID, forKey:"FlavorSelect_\(n)")
                n += 1
            }
            
            flavorSet.synchronize()
            
            let select1 = self.flavorSet.objectForKey("FlavorSelect_1")
            let select2 = self.flavorSet.objectForKey("FlavorSelect_2")
            let select3 = self.flavorSet.objectForKey("FlavorSelect_3")
            
            print("saveFlavorSelect1 \(select1)")
            print("saveFlavorSelect2 \(select2)")
            print("saveFlavorSelect3 \(select3)")
            
    }
        //儲存完NSUserDefault後導頁至store頁
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TarBarController") as! UITableViewController
        self.presentViewController(vc, animated: true, completion: nil)

}
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flavorData.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FlavorCell", forIndexPath: indexPath) as! FlavorCollectionViewCell
        
        cell.flavorName?.text = flavorData[indexPath.row].name
        
        
        return cell
    }
    
    //處理collection Header
    override func collectionView(collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,atIndexPath indexPath: NSIndexPath)-> UICollectionReusableView {
            // 建立 UICollectionReusableView
            var reusableView = UICollectionReusableView()
            
            // 顯示文字Label設定
            let label = UILabel(frame: CGRect(x: 0, y: 10,width: fullScreenSize.width, height:20))
            label.textAlignment = .Center
            
            // header
            if kind == UICollectionElementKindSectionHeader {
                // 依據前面註冊設置的識別名稱 "Header" 取得目前使用的 header
                reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(
                    UICollectionElementKindSectionHeader,
                    withReuseIdentifier: "Header",
                    forIndexPath: indexPath)
                
                // 設置 header 的內容
                reusableView.backgroundColor = UIColor(red: 255/255, green: 187/255, blue: 176/255, alpha: 0.5)
                label.text = "選擇您喜好的咖啡風味吧!";
                label.textColor = UIColor.redColor()
                
            }else{
        }
        reusableView.addSubview(label)
        return reusableView
}

        //處理點選味道
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //處理點選的方式
        let cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        var info = flavorData[indexPath.row]
        if info.isSelect {
            
            
            //淺藍色
            cell.backgroundColor = UIColor(red: 237/255, green: 1, blue: 1, alpha: 1)
            
            clickCount -= 1
            info.isSelect = false
            
        } else {
            if clickCount == 3 { //"Please do not choose more than 3 kinds of flavor!"
                let selectFlavorAlert = UIAlertController(title: "風味選擇", message:
                    "您選擇超過3種了唷~", preferredStyle: UIAlertControllerStyle.Alert)
                selectFlavorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler:{ action in
                    if info.isSelect {
                    cell.backgroundColor = UIColor(red: 237/255, green: 1, blue: 1, alpha: 1)
                    info.isSelect = false
                        print ("\(info.name) \(info.isSelect) \(self.clickCount)")
                    }}))
                
                self.presentViewController(selectFlavorAlert, animated: true, completion: nil)
                
            } else {
                
                clickCount += 1
                //桃紅色
                cell.backgroundColor = UIColor(red: 1, green: 111/255, blue: 205/255, alpha: 0.5)
            }
            
            info.isSelect = true
            
        }
    }
}

//設定每個Grid的預設屬性
class FlavorInfo : NSObject {
    var id = 0
    var name = ""
    var isSelect = false
}

