//
//  StoreTableViewCell.swift
//  TaipeiGoodCoffee
//
//  Created by Allen on 2016/10/2.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    @IBOutlet weak var isWifi: UIImageView!
    @IBOutlet weak var isPet: UIImageView!
    @IBOutlet weak var isDrink: UIImageView!
    @IBOutlet weak var isFood: UIImageView!
    @IBOutlet weak var serviceTime: UILabel!
    @IBOutlet weak var storeAdd: UILabel!
    @IBOutlet weak var storePhone: UILabel!
    @IBOutlet weak var storeNameCell: UILabel!
    @IBOutlet weak var storeImageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



}
