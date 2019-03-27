//
//  AuthenticateViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 07/03/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AuthenticateViewController: UIViewController {
    

    // MARK: - DataModel
    
    let authenticationDataModel = DrAtDoorDataModel()
    
    
    // MARK: - URL
    
    let Authenticate_URL = "http://dratdoorstep.com/livemob/authenticatePassword"
    let ResendPassword_URL = "http://dratdoorstep.com/livemob/resendPassword"
    
    
    // MARK: - ViewController
    
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var MessageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
        MessageLabel.text = ""
    }
    
    // MARK: - Continue
    
    @IBAction func Continue(_ sender: Any) {
        
        let passwordDM = PasswordTextField.text!
        let mobileNumberDM = authenticationDataModel.mobile
        
//        let deviceTypeDM = ""
        
        let parms : [String : String] = ["password" : passwordDM,
                                         "mobileNumber" : mobileNumberDM!]
        
        getData(url: Authenticate_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let AuthJSON : JSON = JSON(respondse.result.value!)
                self.updateAuthData(json: AuthJSON)
                
                if self.PasswordTextField.text != ""{
                    
                    if self.authenticationDataModel.isSuccess == true{
                        self.MessageLabel.text = self.authenticationDataModel.message
                        self.performSegue(withIdentifier: "GoToCreatePassword", sender: self)
                    }
                    else{
                        self.MessageLabel.text = self.authenticationDataModel.message
                    }
                }
                else{
                    self.MessageLabel.text = "Please enter Password"
                }
                
            }
            else{
                print("Error")
            }
        }
        
    }
    
    func updateAuthData(json : JSON)  {
        
        authenticationDataModel.password = json["password"].stringValue
        
        authenticationDataModel.message = json["message"].stringValue
        authenticationDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
    
    // MARK: - Resend Password
    
    @IBAction func ResendPassword(_ sender: Any) {
    
        let mobileNumberDM = authenticationDataModel.mobile
//        let deviceTypeDM = ""
        
        let parms : [String : String] = ["mobileNumber" : mobileNumberDM!]
        
        getResendData(url: ResendPassword_URL, parameters: parms)
        
    }
    
    func getResendData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let ResendJSON : JSON = JSON(respondse.result.value!)
                self.updateResendData(json: ResendJSON)
                
                if self.PasswordTextField.text != ""{
                    
                    if self.authenticationDataModel.isSuccess == true{
                        self.MessageLabel.text = self.authenticationDataModel.message
                    }
                    else{
                        self.MessageLabel.text = self.authenticationDataModel.message
                    }
                }
                else{
                    self.MessageLabel.text = "Error"
                }
                
            }
            else{
                print("Error")
            }
        }
        
    }
    
    func updateResendData(json : JSON)  {
        
        authenticationDataModel.mobileNumber = json["mobileNumber"].intValue
        authenticationDataModel.mobile = json["mobile"].stringValue
        
        authenticationDataModel.message = json["message"].stringValue
        authenticationDataModel.isSuccess = json["isSuccess"].boolValue
        
        
    }
    
    // MARK: - Cancel
    
    @IBAction func Cancel(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
}
