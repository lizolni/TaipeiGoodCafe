//
//  CartViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


enum payments {
    case creditCard,ATM
}

class CartViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource , UITextFieldDelegate{
    
    var NSuser = NSUserDefaults.standardUserDefaults()
    let conditionRef = FIRDatabase.database().reference()
    var getProdID :String = ""
    var getProdName :String = ""
    var getProdPrice : String = ""
    var getProdImage : String = ""
    var getCardNumber : String = ""
    var getCardMonths : String = ""
    var getCardYears : String = ""
    var getCVC : String = ""
    var shipping : Int  = 0
    var countShipping : Int = 0
    var quantity : Int = 0

    
    //section - productName
    @IBOutlet weak var prodImage: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    
    
    //payment - UIsegment - Part 2
//    @IBOutlet weak var creditCardContainer: UIView!
//    @IBOutlet weak var atmContainer: UIView!
//    @IBAction func paymentSegment(sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex{
//            case 0 :
//                atmContainer.hidden = true
//                creditCardContainer.hidden = false
//            case 1 :
//                atmContainer.hidden = false
//                creditCardContainer.hidden = true
//            default:
//                atmContainer.hidden = true
//                creditCardContainer.hidden = false
//        }
//    }
    
    //get subContainer View Status - part 2
//    var creditCardContainerView = CreditCardViewController()
//    var atmContainerView = ATMViewController()
    
    
    //creditCard
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardMonth: UITextField!
    @IBOutlet weak var cardYear: UITextField!
    @IBOutlet weak var cvc: UITextField!
    
    //buyer
    @IBOutlet weak var buyerName: UITextField!
    @IBOutlet weak var buyerPhone: UITextField!
    @IBOutlet weak var buyerAddress: UITextField!
    
    //reciver
    @IBOutlet weak var receiverName: UITextField!
    @IBOutlet weak var receiverPhone: UITextField!
    @IBOutlet weak var receiverAddress: UITextField!
    
    //price
    @IBOutlet weak var prodPrices: UILabel!
    @IBOutlet weak var prodship: UILabel!
    @IBOutlet weak var checkoutPrice: UILabel!
    
    //order
    @IBAction func checkoutorder(sender: AnyObject) {
        //更新頁面之商品價格、運費、結帳金額
        countTotalPrice()
        
        //寫入firebase開關，預設為false
        
        
        //valitated All textField isEmpty
        let returnValue = checkTextField()
        //判斷firebase開關為true, 執行saveOrder func , 寫入firebase
        if returnValue == true {
            saveOrder()
        }
    }
    
    func saveOrder(){

        //Get currentTime
        let currentFormat = NSDateFormatter()
        currentFormat.dateFormat = "MM-dd-yy HH:MM"
        let currentDate = NSDate()
        let orderDate = currentFormat.stringFromDate(currentDate)
        
        //enum
        var atmPayment = payments.ATM
        var ccPayment = payments.creditCard
        //get data
        let uid = NSuser.objectForKey("uid")
        let orderProdID = getProdID
        let orderProdName = prodName.text
        let orderBuyName = buyerName.text
        let orderQuantity = quantity
        let orderBuyPhone = buyerPhone.text
        let orderBuyAddress = buyerAddress.text
        let orderReceiverName = receiverName.text
        let orderReceiverPhone = receiverPhone.text
        let orderReceiverAddress = receiverAddress.text
        let orderProdPrice = prodPrices.text
        let orderProdShip = prodship.text
        let orderCheckout = checkoutPrice.text
        let paymentType = "CreditCard"
        
        //save to order array
        let order:[String:AnyObject] = [
            "userID":uid!,
            "productID":orderProdID,
            "buyerName":orderBuyName!,
            "buyerPhone":orderBuyPhone!,
            "buyerAddress":orderBuyAddress!,
            "receiverName":orderReceiverName!,
            "receiverPhone":orderBuyPhone!,
            "receiverAddress":orderReceiverAddress!,
            "prodPrice":orderProdPrice!,
            "prodShipping":orderProdShip!,
            "checkoutPrice":orderCheckout!,
            "paymentType": paymentType,
            "createdTime" : orderDate
        ]
        
        // 加上判斷全部都有值才能儲到firebase
        // childByAutoId -> firebase 自動產生亂數ID (訂單ID)
        let saveOrdertoFirebase = conditionRef.child("Coffee").childByAppendingPath("Orders").childByAutoId()
            //saveOrdertoFirebase.setValue(["createdTime":FIRServerValue.timestamp()])
            saveOrdertoFirebase.setValue(order)
        
        //GA
        
            FIRAnalytics.logEventWithName( "order_complete", parameters: [
            "userID": uid as! NSObject,
            "productID": orderProdID as NSObject,
            "prodPrice": orderProdPrice! as NSObject,
            "prodShipping": orderProdShip! as NSObject,
            "checkoutPrice": orderCheckout! as NSObject,
            "createdTime": orderDate as NSObject
            ])
        
        
        //轉跳頁面到訂單完成頁
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("OrderCompleteViewController") as! UIViewController
        vc.navigationItem.hidesBackButton = true

        self.navigationController?.pushViewController(vc, animated: true)
        //self.presentViewController(vc, animated: true, completion: nil)
    }
    
 
    
    @IBAction func callPicker(sender: AnyObject) {
        countTotalPrice()
        
    }
    @IBOutlet weak var callPicker: UITextField!
    let pickerViewData = ["1","2","3","4","5","6","7","8","9"]
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: ("dismissKeyboard")))
        
        //UIPickerView
        picker.delegate = self
        picker.dataSource = self
        callPicker.inputView = picker
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        picker.showsSelectionIndicator = true
        toolBar.userInteractionEnabled = true
        callPicker.inputAccessoryView = toolBar
        
        prodName.text = getProdName
        prodPrices.text = ("$\(getProdPrice)")
        
        //增加Picker預設值
        picker.selectRow(0, inComponent: 0, animated: true)
    
        //textfield delegate
        callPicker.delegate = self
        //callPicker.tag = 1 - 設定tag，也可以從storyboard做
        cardNumber.delegate = self
        cardYear.delegate = self
        cardMonth.delegate = self
        cvc.delegate = self
        
        //圖片要先轉型成URL，再轉成NSData
        if let imageURL = NSURL(string: getProdImage){
            if let data = NSData(contentsOfURL: imageURL) {
                self.prodImage.image = UIImage(data:data)
                self.prodImage.layer.cornerRadius = 5
                self.prodImage.layer.masksToBounds = true
            }
        }
        
        //更新頁面之商品價格、運費、結帳金額
        countTotalPrice()
    }
    
    func dismissKeyboard(){
        cardYear.resignFirstResponder()
        cardMonth.resignFirstResponder()
        cardNumber.resignFirstResponder()
        cvc.resignFirstResponder()
        buyerName.resignFirstResponder()
        buyerPhone.resignFirstResponder()
        buyerAddress.resignFirstResponder()
        receiverName.resignFirstResponder()
        receiverPhone.resignFirstResponder()
        receiverAddress.resignFirstResponder()
    }
    
    //validated textfield
    func checkTextField()->Bool{
 
        guard
            cardNumber.text == "" ||
            cardMonth.text == "" ||
            cardYear.text == "" ||
            cvc.text == "" ||
            buyerName.text == "" ||
            buyerPhone.text == "" ||
            buyerAddress.text == "" ||
            receiverName.text == "" ||
            receiverPhone.text == "" ||
            receiverAddress.text == ""
            else {
                
                //更新頁面之商品價格、運費、結帳金額
               countTotalPrice()
                
                //全部都有值，回傳false，準備寫入訂單至firebase
                print("All text field have data")
                //textFieldStatus == true
            return true
        }
        //所有 text filed 只要有一個沒值，顯示Alert訊息
        let nonSelectAlert = UIAlertController(title: "", message:
            "請填寫完整訂單資料", preferredStyle: UIAlertControllerStyle.Alert)
        nonSelectAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler:nil))
        
        self.presentViewController(nonSelectAlert, animated: true, completion: nil)
        //回傳true, 不寫入訂單到firebase
        return  false
    }

    
    //判斷credit card text field maxLength
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        
        if textField.tag == 1{
            let maxLength = 16
            let currentString: NSString = textField.text!
            let newString: NSString =
                currentString.stringByReplacingCharactersInRange(range, withString: string)
            return newString.length <= maxLength
        }
        
        if textField.tag == 2{
            let maxLength = 2
            let currentString: NSString = textField.text!
            let newString: NSString =
                currentString.stringByReplacingCharactersInRange(range, withString: string)
            return newString.length <= maxLength
        }
        
        if textField.tag == 3{
            let maxLength = 2
            let currentString: NSString = textField.text!
            let newString: NSString =
                currentString.stringByReplacingCharactersInRange(range, withString: string)
            return newString.length <= maxLength
        }
        
        if textField.tag == 4{
            let maxLength = 3
            let currentString: NSString = textField.text!
            let newString: NSString =
                currentString.stringByReplacingCharactersInRange(range, withString: string)
            return newString.length <= maxLength
        }
        
        return true
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
 
  
    //信用卡檢查
//    func creditCardVerify(){
//        let getCardNum = cardNumber.text
//        let verifyCC = CreditCardValidator()
//        if verifyCC.validate(getCardNum){
//            print("validated OK")
//        } else {
//            print ("Card number is invalid")
//        }
//        
//    }
    
    //計算商品金額
    func countTotalPrice(){
    
        //count product Price
        var price = self.getProdPrice
        var quantity = callPicker.text
        var intPrice = Int(price)
        var intQuantity = Int(quantity!)
        if intQuantity != nil {
            self.prodPrice.text = ("$\(String(intPrice! * intQuantity!))")
        }else{
            self.prodPrice.text = prodPrices.text
        }
    
    
        //count shipping
        self.shipping = 60
        switch callPicker.text {
        case "2"?:
            shipping = 2 * shipping
            prodship.text = ("$\(String(shipping))")
        case "3"?:
            shipping = 2 * shipping
            prodship.text = ("$\(String(shipping))")
        case "4"?:
            shipping = 2 * shipping
            prodship.text = ("$\(String(shipping))")
        case "5"?:
            shipping = 2 * shipping
            prodship.text = ("$\(String(shipping))")
        case "6"?:
            shipping = 3 * shipping
            prodship.text = ("$\(String(shipping))")
        case "7"?:
            shipping = 3 * shipping
            prodship.text = ("$\(String(shipping))")
        case "8"?:
            shipping = 3 * shipping
            prodship.text = ("$\(String(shipping))")
        case "9"?:
            shipping = 4 * shipping
            prodship.text = ("$\(String(shipping))")
        default:
            shipping = 1 * shipping
            prodship.text = ("$\(String(shipping))")
        }
    
        //count checkout price
        if intQuantity != nil{
        var countPrice = intPrice! * intQuantity!
        var countFee = countPrice + shipping
        checkoutPrice.text = ("$\(String(countFee))")
        }else{
        checkoutPrice.text = ("$ \(String(intPrice! + self.shipping))")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject? ) {
//        if segue.identifier == "CreditCard" {
//            if let  creditCardDestination = segue.destinationViewController as? CreditCardViewController {
//                
//                creditCardContainerView = creditCardDestination
//                
//            }
//        } else if segue.identifier == "ATM" {
//            if let atmDestination = segue.destinationViewController as? ATMViewController {
//                
//                atmContainerView = atmDestination
//                
//            }
//            
//        }
//    }
    


}

extension NSDate
{
    
    func year() -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: self)
        let year = components.year
        
        //Return year
        return year

    }
    
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let timeString = formatter.stringFromDate(self)
        
        //Return Short Time String
        return timeString
    }
}
