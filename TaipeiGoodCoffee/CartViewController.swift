//
//  CartViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var order = [Order]()
    var product = [Products]()
    var cards = [CreditCard]()
    var getProdID :String = ""
    var getProdName :String = ""
    var getProdPrice : String = ""
    var getProdImage : String!
    var cartProduct = [Products]()
    var cardNumber : String = ""
    var cardMonths : String = ""
    var cardYears : String = ""
    var cvc : String = ""
    var shipping : Int = 60
    var quantities:[String] = [String]()
    
    //section - productName
    @IBOutlet weak var prodImage: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var quantity: UIPickerView!
    
    //payment - UIsegment
    @IBAction func paymentSegment(sender: AnyObject) {
        
        
    }
    
    //section - Credit Card
    @IBOutlet weak var creditCardNumber: UITextField!
    @IBOutlet weak var creditCardDatePicker: UIDatePicker!
    @IBOutlet weak var creditCardCVC: UITextField!
    
    //buyer
    @IBOutlet weak var buyerName: UITextField!
    @IBOutlet weak var buyerPhone: UITextField!
    @IBOutlet weak var buyerAddress: UITextField!
    
    //reciver
    @IBOutlet weak var receiverName: UITextField!
    @IBOutlet weak var receiverPhone: UIView!
    @IBOutlet weak var receiverAddress: UITextField!
    
    //price
    @IBOutlet weak var prodPrices: UILabel!
    @IBOutlet weak var prodship: UILabel!
    @IBOutlet weak var checkoutPrice: UILabel!
    
    //submit
    @IBAction func checkoutSubmit(sender: AnyObject) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.quantity.delegate = self
        self.quantity.dataSource = self
        
        
        
        var prod = product
        var card = cards
        prodName.text = getProdName
        prodPrice.text = ("$\(getProdPrice)")
        
        
        //圖片要先轉型成URL，再轉成NSData
        if let imageURL = NSURL(string: getProdImage){
            if let data = NSData(contentsOfURL: imageURL) {
                self.prodImage.image = UIImage(data:data)
            }
        }

        quantities = ["1","2","3"]
        
               
        
        
        //TODO intitial fake data, user/product/store
        
  

        // Do any additional setup after loading the view.
    }
    
    //PickerView Delegate & DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantities.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return quantities[row]
    }
    
//    func pickerview pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if (row == 0){
//    
//    
//        }else {
//    
//        }
//    }

    
    
    
    
//    public func loadView(user/product/store){
//        
//    }
    
       //檢查信用卡
    func checkCreditCard(){
       
    }
    
    //計算商品金額
    func countProdPrice(){
        
    }
    
    //計算運費
    func countProdShip(){
        
    }
    
    //計算結帳費用
    func countCheckoutPrice(){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
