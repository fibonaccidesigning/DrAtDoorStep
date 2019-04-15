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

    
    // MARK: - DataModel
    
    let registerDataModel = DrAtDoorDataModel()
    
    
    // MARK: - URL
    
    let Register_URL = "http://dratdoorstep.com/livemob/registration"
    
    
    // MARK: - ViewController
    
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var MobileTextField: UITextField!
    @IBOutlet var ReferalCodeTextFiels: UITextField!
    
    let notification = UINotificationFeedbackGenerator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
    }
    
    // MARK: - Registration Button
    
    @IBAction func RegisterBtn(_ sender: Any) {
        
        let emailDM = EmailTextField.text!
        let mobileDM = MobileTextField.text!
        let referalDM = ReferalCodeTextFiels.text!
        let deviceTypeDM = "ios"
        
//        let deviceType = ""
        
        let parms : [String : String] = ["email" : emailDM,
                                         "mobileNumber" : mobileDM,
                                         "deviceType" : deviceTypeDM,
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
                        
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let second = main.instantiateViewController(withIdentifier: "GoToAuthenticate")
                        self.present(second, animated: true, completion: nil)
                        
                        self.notification.notificationOccurred(.success)
                        
                    }
                    else{
                        let alert = UIAlertController(title: "Error", message: "\(String(describing: self.registerDataModel.message!))", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                        self.notification.notificationOccurred(.warning)
                    }
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: self.registerDataModel.message!))", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                    
                    self.notification.notificationOccurred(.warning)
                }
            
            }
            else{
                let alert = UIAlertController(title: "Error", message: "\(String(describing: self.registerDataModel.message!))", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil )
                
                self.notification.notificationOccurred(.warning)
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
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "LoginVC")
        self.present(second, animated: true, completion: nil)
        
        self.notification.notificationOccurred(.success)
    }
    
}
