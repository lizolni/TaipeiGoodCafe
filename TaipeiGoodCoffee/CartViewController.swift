//
//  CartViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    //section - productName
    @IBOutlet weak var prodImage: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    
    
//payment - UIsegment
//    @IBAction func paymentSegment(sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex{
//            case 0 :
//                atmView.hidden = true
//                creditCardView.hidden = false
//            case 1 :
//                atmView.hidden = false
//                creditCardView.hidden = true
//            default:
//                atmView.hidden = true
//                creditCardView.hidden = false
//        }
//    }
    
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
    
    var getProdID :String = ""
    var getProdName :String = ""
    var getProdPrice : String = ""
    var getProdImage : String = ""
//    var cardNumber : String = ""
//    var cardMonths : String = ""
//    var cardYears : String = ""
//    var cvc : String = ""
//    var shipping : Int = 60
    
    
    @IBOutlet weak var callPicker: UITextField!
    var pickerViewData = ["1","2","3","4","5","6","7","8","9"]
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIPickerView
        picker.delegate = self
        picker.dataSource = self
        callPicker.inputView = picker
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        picker.showsSelectionIndicator = true
//        
////        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Bordered, target: self, action: "donePicker")
////        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
////        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "canclePicker")
//        
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.userInteractionEnabled = true
        callPicker.inputAccessoryView = toolBar

        
        
        
        
        
//        var prod = product
//        var card = cards
        prodName.text = getProdName
        prodPrice.text = ("$\(getProdPrice)")
        
        //圖片要先轉型成URL，再轉成NSData
        if let imageURL = NSURL(string: getProdImage){
            if let data = NSData(contentsOfURL: imageURL) {
                self.prodImage.image = UIImage(data:data)
            }
        }

        
        //TODO intitial fake data, user/product/store
        
    }
    
    //PickerView Delegate & DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    
    //toggle pickerView from text field
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callPicker.text = pickerViewData[row]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerViewData[row]
    }

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
