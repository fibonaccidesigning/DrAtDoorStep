//
//  CartTableViewCell.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 05/04/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet var ProfileImg: UIImageView!
    
    @IBOutlet var NameLbl: UILabel!
    @IBOutlet var PriceLbl: UILabel!
    @IBOutlet var DateLbl: UILabel!
    @IBOutlet var AppoinmentForLbl: UILabel!
    @IBOutlet var AppoinmentTypeLbl: UILabel!
    
    @IBOutlet var EditBt: UIImageView!
    @IBOutlet var DeleteBtn: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
