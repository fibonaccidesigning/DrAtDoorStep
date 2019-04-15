//
//  CreatePasswordViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 28/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CreatePasswordViewController: UIViewController {

    // MARK: DataModel
    
    let CreatePasswordDataModel = DrAtDoorDataModel()
    let notification = UINotificationFeedbackGenerator()
    
    
    // MARK: URL
    
    let ResetPassword_URL = "http://dratdoorstep.com/livemob/resetPassword"
    
    var RetriveFechData = 0
    
    
    //MARK: - ViewController

    @IBOutlet var NewPasswordTextField: UITextField!
    @IBOutlet var ConfirmPasswordTextField: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
        
        //MARK: - UserDefult
        
        RetriveFechData = UserDefaults.standard.integer(forKey: "userID")
        print(RetriveFechData)
       
    }
    
   
    
      //MARK: - ResetButton
    
    @IBAction func ResetPassword(_ sender: Any) {
        
        if NewPasswordTextField.text == ConfirmPasswordTextField.text{
        
            let userIdDM = "\(RetriveFechData)"
            let isSkipDM = ""
            let passwordDM = ""
            let deviceTypeDM = "ios"
            
            let parms : [String : String] = ["userId" : userIdDM,
                                             "isSkip" : isSkipDM,
                                             "deviceType" : deviceTypeDM,
                                             "password" : passwordDM]
            
            getData(url: ResetPassword_URL, parameters: parms)
        }else{
            
          // MessageLabel.text = "Password not Match"
            
        }
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let ResetPasswordJSON : JSON = JSON(respondse.result.value!)
                self.updateRegisterData(json: ResetPasswordJSON)
                
                if self.NewPasswordTextField.text != "" && self.ConfirmPasswordTextField.text != ""{
                    
                    if self.CreatePasswordDataModel.isSuccess == true{
                        
                        
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let second = main.instantiateViewController(withIdentifier: "LoginVC")
                        self.present(second, animated: true, completion: nil)
                        
                        self.notification.notificationOccurred(.success)
                    }
                    else{
                        
                        let alert = UIAlertController(title: "Error", message: "\(String(describing: self.CreatePasswordDataModel.message!))", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                        self.notification.notificationOccurred(.warning)
                    }
                }
                else{
                    
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: self.CreatePasswordDataModel.message!))", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                    
                    self.notification.notificationOccurred(.warning)
                }
                
            }
            else{
                
                let alert = UIAlertController(title: "Error", message: "\(String(describing: self.CreatePasswordDataModel.message!))", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil )
                
                self.notification.notificationOccurred(.warning)
            }
        }
        
    }
    
    func updateRegisterData(json : JSON)  {
        
        CreatePasswordDataModel.userId = json["userId"].intValue
        CreatePasswordDataModel.isSkip = json["isSkip"].boolValue
        CreatePasswordDataModel.password = json["password"].stringValue
        CreatePasswordDataModel.deviceType = json["deviceType"].stringValue
        
        CreatePasswordDataModel.message = json["message"].stringValue
        CreatePasswordDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
    
    //MARK: - SkipButton
    
    @IBAction func Skip(_ sender: Any) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "LoginVC")
        self.present(second, animated: true, completion: nil)
        
        self.notification.notificationOccurred(.success)
        
    }
}
