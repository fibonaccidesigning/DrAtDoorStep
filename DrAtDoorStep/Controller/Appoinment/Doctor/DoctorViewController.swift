//
//  DoctorViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DoctorViewController: UIViewController {
    
    
    // MARK: DataModel
    
    let loginDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let Login_URL = "http://dratdoorstep.com/livemob/login"
    
    
    //MARK: - ViewController
    
    @IBOutlet var SelectPatientTextField: UITextField!
    @IBOutlet var ComplainTextField: UITextField!
    @IBOutlet var DateTextField: UITextField!
    @IBOutlet var TimeTextField: UITextField!
    @IBOutlet var SelectDecotorTextField: UITextField!
    @IBOutlet var AddressTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeybord()

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapButton) )
   
        let adButton = UIBarButtonItem(barButtonSystemItem: .action , target: self, action: #selector(tapButton) )
        self.navigationItem.rightBarButtonItems = [addButton,adButton]
    
    }

    @objc func tapButton() {
        self.performSegue(withIdentifier: "goToChat", sender: self)
    }

    @IBAction func BookAppoinment(_ sender: Any) {
        
        
        
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        
        
        
    }
    
}
