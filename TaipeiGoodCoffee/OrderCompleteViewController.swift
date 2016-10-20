//
//  OrderCompleteViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/20.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class OrderCompleteViewController: UIViewController {

    @IBAction func gotoTableView(sender: AnyObject) {
        
        //轉跳頁面到訂單完成頁
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("StoreTableView")
        
        self.navigationItem.hidesBackButton = true
        //vc.navigationItem.hidesBackButton = true
        
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
