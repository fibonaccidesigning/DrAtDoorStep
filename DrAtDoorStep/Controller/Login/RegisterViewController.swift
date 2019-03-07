//
//  RegisterViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 28/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {

    
    // MARK: DataModel
    
    let registerDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let Register_URL = "http://dratdoorstep.com/livemob/registration"
    
    
    //MARK: - ViewController
    
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var MobileTextField: UITextField!
    @IBOutlet var ReferalCodeTextFiels: UITextField!
    @IBOutlet var MessageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessageLabel.text = ""
        self.HideKeybord()
    }
    
    
    @IBAction func RegisterBtn(_ sender: Any) {
        
        let emailDM = EmailTextField.text!
        let mobileDM = MobileTextField.text!
        let referalDM = ReferalCodeTextFiels.text!
        
        let parms : [String : String] = ["email" : emailDM,
                                         "mobileNumber" : mobileDM,
                                         "referalCode" : referalDM]
                                         
        
        getData(url: Register_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let RegisterJSON : JSON = JSON(respondse.result.value!)
                self.updateRegisterData(json: RegisterJSON)
                
                if self.EmailTextField.text != "" && self.MobileTextField.text != ""{
                    
                    if self.registerDataModel.isSuccess == true{
                        self.performSegue(withIdentifier: "GoToAuthenticate", sender: self)
                        self.MessageLabel.text = self.registerDataModel.message
                    }
                    else{
                        self.MessageLabel.text = self.registerDataModel.message
                    }
                }
                else{
                    self.MessageLabel.text = "Please enter required fields"
                }
            
            }
            else{
                print("Error")
            }
        }
        
    }
    
    func updateRegisterData(json : JSON)  {
        
        registerDataModel.emailAddress = json["emailAddress"].stringValue
        registerDataModel.mobileNumber = json["mobileNumber"].intValue
        registerDataModel.referalCode = json["referalCode"].stringValue
        registerDataModel.message = json["message"].stringValue
        registerDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
    
    
    
    //MARK: - Cancel Button
    
    @IBAction func CancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
