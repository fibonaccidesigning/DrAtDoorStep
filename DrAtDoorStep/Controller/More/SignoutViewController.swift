//
//  SignoutViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 12/04/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignoutViewController: UIViewController {

    
    let notification = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        
    }
    

    @IBAction func Signout(_ sender: Any) {
        
      UserDefaults.standard.removeObject(forKey: "userID")
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "LoginVC")
        self.present(second, animated: true, completion: nil)
        
        
    }
}


