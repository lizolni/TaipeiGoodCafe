//
//  CreditCard.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import Foundation

class CreditCard {
    var creditCardNumber : String
    var month : String
    var year : String
    var cvc : String
    
    init(creditCardNumber:String,month:String,year:String,cvc:String){
        
        self.creditCardNumber = creditCardNumber
        self.month = month
        self.year = year
        self.cvc = cvc
        
    }
    

    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.CaseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatchInString(text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }

    
    func checkCardNumber(input: String) -> (type: CardType, formatted: String, valid: Bool) {
        // Get only numbers from the input string
        let numberOnly = input.stringByReplacingOccurrencesOfString("[^0-9]", withString: "", options: .RegularExpressionSearch)
        
        var type: CardType = .Unknown
        var formatted = ""
        var valid = false
        
        // detect card type
        for card in CardType.allCards {
            if (matchesRegex(card.regex, text: numberOnly)) {
                type = card
                break
            }
        }
        
        // check validity
        valid = luhnCheck(numberOnly)
        
        // format
        var formatted4 = ""
        for character in numberOnly.characters {
            if formatted4.characters.count == 4 {
                formatted += formatted4 + " "
                formatted4 = ""
            }
            formatted4.append(character)
        }
        
        formatted += formatted4 // the rest
        
        // return the tuple
        return (type, formatted, valid)
    }
    
    func luhnCheck(number: String) -> Bool {
    var sum = 0
    let digitStrings = number.characters.reverse().map { String($0) }
    
    for tuple in digitStrings.enumerate() {
    guard let digit = Int(tuple.element) else { return false }
    let odd = tuple.index % 2 == 1
    
    switch (odd, digit) {
    case (true, 9):
    sum += 9
    case (true, 0...8):
    sum += (digit * 2) % 9
    default:
    sum += digit
    }
    }
    
    return sum % 10 == 0
    }
    
}

enum CardType: String {
    case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
    
    static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]
    
    var regex : String {
        switch self {
        case .Amex:
            return "^3[47][0-9]{5,}$"
        case .Visa:
            return "^4[0-9]{6,}([0-9]{3})?$"
        case .MasterCard:
            return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        case .Diners:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .Discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        case .JCB:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        case .UnionPay:
            return "^(62|88)[0-9]{5,}$"
        case .Hipercard:
            return "^(606282|3841)[0-9]{5,}$"
        case .Elo:
            return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
        default:
            return ""
        }
    }
    
    
}


