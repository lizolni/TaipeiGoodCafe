//
//  ProductsViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/8.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

   
    
    
    var getStoreName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NivagationBar title Name
        self.title = getStoreName

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
