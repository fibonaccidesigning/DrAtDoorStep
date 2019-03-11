//
//  ViewPatientTableViewCell.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 08/03/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit

class ViewPatientTableViewCell: UITableViewCell {

    @IBOutlet var NameLbl: UILabel!
    @IBOutlet var GenderLbl: UILabel!
    @IBOutlet var AgeLbl: UILabel!
    @IBOutlet var AreaLbl: UILabel!
    @IBOutlet var AddressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
