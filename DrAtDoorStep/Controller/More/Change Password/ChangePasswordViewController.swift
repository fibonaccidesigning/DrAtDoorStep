//
//  ChangePasswordViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChangePasswordViewController: UIViewController {

    
    // MARK: DataModel
    
    let changePasswordDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let ChangePassword_URL = "http://dratdoorstep.com/livemob/changePassword"
    
    let notification = UINotificationFeedbackGenerator()
    
    var RetriveFechData = 0
    
    //MARK: - ViewController
    
    @IBOutlet var OldPasswordTextField: UITextField!
    @IBOutlet var NewPasswordTextField: UITextField!
    @IBOutlet var ConfirmPasswordTextField: UITextField!
    @IBOutlet var MessageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
        MessageLabel.text = ""
    }
    
    
    @IBAction func OldPassword(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func NewPassword(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func ConfirmPassword(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    @IBAction func ChangePassword(_ sender: Any) {
        
        let userIdDM =  "\(RetriveFechData)"
        let deviceTypeDM = "ios"
        let currentPasswordDM = OldPasswordTextField.text!
        let newPasswordDM = NewPasswordTextField.text!
        
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "currentPassword" : currentPasswordDM,
                                         "newPassword" : newPasswordDM,
                                         "deviceType" : deviceTypeDM]
    
        getData(url: ChangePassword_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let ChangePasswordJSON : JSON = JSON(respondse.result.value!)
                self.updateRegisterData(json: ChangePasswordJSON)
                
                if self.OldPasswordTextField.text != "" && self.NewPasswordTextField.text != "" && self.ConfirmPasswordTextField.text != ""  {
                    
                    if self.changePasswordDataModel.isSuccess == true{
                        self.MessageLabel.text = self.changePasswordDataModel.message
                        
                            let alert = UIAlertController(title: "Successfull", message: "\(self.changePasswordDataModel.message!)", preferredStyle: .alert)
                            
                            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                            
                            alert.addAction(action)
                            
                            self.present(alert, animated: true, completion: nil )
                        
                        self.notification.notificationOccurred(.success)
                        
                        self.OldPasswordTextField.text = ""
                        self.NewPasswordTextField.text = ""
                        self.ConfirmPasswordTextField.text = ""
                        
                        
                    }
                    else{
                   
                        let alert = UIAlertController(title: "Error", message: "\(self.changePasswordDataModel.message!)", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done!", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                       self.present(alert, animated: true, completion: nil )
                        
                        self.notification.notificationOccurred(.warning)
                        
                    }
                }
                else{
                  
                    let alert = UIAlertController(title: "Error", message: "\(self.changePasswordDataModel.message!)", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done!", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                }
                
                self.notification.notificationOccurred(.warning)
            }
            else{
                print("Error")
            }
        }
        
    }
    
    func updateRegisterData(json : JSON)  {
        
        changePasswordDataModel.newPassword = json["newPassword"].stringValue
        changePasswordDataModel.currentPassword = json["currentPassword"].stringValue
        
        changePasswordDataModel.message = json["message"].stringValue
        changePasswordDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
}
