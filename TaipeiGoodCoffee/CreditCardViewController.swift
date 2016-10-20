//
//  CreditCardViewController.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController ,UITextFieldDelegate {

    
    @IBOutlet weak var cvc: UITextField!
    
    @IBOutlet weak var year: UITextField!
    
    @IBOutlet weak var month: UITextField!
    
    @IBOutlet weak var creditCardNumber: UITextField!
    
    var getCardNumber = ""
    var getMonth = ""
    var getYear = ""
    var getcvc = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        creditCardNumber.delegate = self
//        month.delegate = self
//        year.delegate = self
//        cvc.delegate = self
        
//        getcvc = cvc.text!
//        getYear = year.text!
//        getMonth = month.text!
//        getCardNumber = creditCardNumber.text!
        
        let creditCard = CreditCard(creditCardNumber: getCardNumber,month:getMonth ,year:getYear,cvc:getcvc)
        creditCard.checkCardNumber(creditCard.creditCardNumber)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        creditCardNumber.resignFirstResponder()
        month.resignFirstResponder()
        year.resignFirstResponder()
        cvc.resignFirstResponder()
        return true
    }

    

}
