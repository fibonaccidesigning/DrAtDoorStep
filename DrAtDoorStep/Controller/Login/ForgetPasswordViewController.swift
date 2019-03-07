//
//  ForgetPasswordViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 28/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForgetPasswordViewController: UIViewController {

    
    // MARK: DataModel
    
    let forgetPasswordDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let ForgotPassword_URL = "http://dratdoorstep.com/livemob/forgotPassword"
    
    @IBOutlet var EmailMobileTextField: UITextField!
    @IBOutlet var MessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
        MessageLabel.text = ""
    }
    
    @IBAction func SendOTP(_ sender: Any) {
        
        let emailMobileDM = EmailMobileTextField.text!
        let deviceTypeDM = ""
        
        let parms : [String : String] = ["emailMobile" : emailMobileDM,
                                         "deviceType" : deviceTypeDM]
        
        getData(url: ForgotPassword_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let ChangePassJSON : JSON = JSON(respondse.result.value!)
                self.updateChangePassData(json: ChangePassJSON)
                
                if self.EmailMobileTextField.text != ""{
                    
                    if self.forgetPasswordDataModel.isSuccess == true{
                        self.MessageLabel.text = self.forgetPasswordDataModel.message
                        
                        let alert = UIAlertController(title: "Sent", message: "Password Information Successfully Send to you.", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                    }
                    else{
                        self.MessageLabel.text = self.forgetPasswordDataModel.message
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
    
    func updateChangePassData(json : JSON)  {
        
        forgetPasswordDataModel.emailAddress = json["emailMobile"].stringValue
        forgetPasswordDataModel.message = json["message"].stringValue
        forgetPasswordDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
    
    
    @IBAction func CancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
