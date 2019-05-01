//
//  BookingHistoryTableViewCell.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 11/03/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit

class BookingHistoryTableViewCell: UITableViewCell {

    @IBOutlet var OrderLbl: UILabel!
    @IBOutlet var DateLbl: UILabel!
    @IBOutlet var TitleLbl: UILabel!
    @IBOutlet var CanceledLbl: UILabel!
    @IBOutlet var InvoiceBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
