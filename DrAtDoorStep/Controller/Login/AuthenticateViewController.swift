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
    
     let notification = UINotificationFeedbackGenerator()
    
    
    // MARK: - URL
    
    let Authenticate_URL = "http://dratdoorstep.com/livemob/authenticatePassword"
    let ResendPassword_URL = "http://dratdoorstep.com/livemob/resendPassword"
    
    
    // MARK: - ViewController
    
    @IBOutlet var PasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
    }
    
    // MARK: - Continue
    
    @IBAction func Continue(_ sender: Any) {
        
        let passwordDM = PasswordTextField.text!
        let mobileNumberDM = authenticationDataModel.mobile
        let deviceTypeDM = "ios"
        
        let parms : [String : String] = ["password" : passwordDM,
                                         "deviceType" : deviceTypeDM,
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
                       
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let second = main.instantiateViewController(withIdentifier: "GoToCreatePasswordVC")
                        self.present(second, animated: true, completion: nil)
                        self.notification.notificationOccurred(.success)
                    }
                    else{
                        
                        let alert = UIAlertController(title: "Error", message: "\(String(describing: self.authenticationDataModel.message!))", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                        self.notification.notificationOccurred(.warning)
                    }
                }
                else{
                    
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: self.authenticationDataModel.message!))", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                    
                    self.notification.notificationOccurred(.warning)
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
                       
                        let alert = UIAlertController(title: "Sent", message: "\(String(describing: self.authenticationDataModel.message!))", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                        self.notification.notificationOccurred(.success)
                        
                    }
                    else{
                        let alert = UIAlertController(title: "Error", message: "\(String(describing: self.authenticationDataModel.message!))", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                        self.notification.notificationOccurred(.warning)
                    }
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: self.authenticationDataModel.message!))", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                    
                    self.notification.notificationOccurred(.warning)
                }
                
            }
            else{
                let alert = UIAlertController(title: "Error", message: "\(String(describing: self.authenticationDataModel.message!))", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil )
                
                self.notification.notificationOccurred(.warning)
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
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "LoginVC")
        self.present(second, animated: true, completion: nil)
        
        self.notification.notificationOccurred(.success)
    }
    
}
