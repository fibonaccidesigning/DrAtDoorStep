//
//  WalletTableViewCell.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 02/04/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit

class WalletTableViewCell: UITableViewCell {

    @IBOutlet var OrderNoLbl: UILabel!
    @IBOutlet var BalanceLbl: UILabel!
    @IBOutlet var DateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

   
    }

}
