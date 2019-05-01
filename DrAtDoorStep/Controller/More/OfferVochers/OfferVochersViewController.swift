//
//  OfferVochersViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit

class OfferVochersViewController: UIViewController {

    let notification = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: "", message: "No Data Found", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil )
        
        self.notification.notificationOccurred(.warning)
       
    }
    

    
  

}
