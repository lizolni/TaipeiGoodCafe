//
//  ProductViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/13.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productName.text = name
        productProducer.text = producer
        productManor.text = manor
        productWeight.text = weight
        productDescription.text = flavorDescription
        productPrice.text = price
        
        
        //圖片要先轉型成URL，再轉成NSData
        if let imageURL = NSURL(string: image){
            if let data = NSData(contentsOfURL: imageURL) {
                self.productImage.image = UIImage(data:data)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
