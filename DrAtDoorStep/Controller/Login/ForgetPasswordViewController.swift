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

    
    // MARK: - DataModel
    
    let forgetPasswordDataModel = DrAtDoorDataModel()
    
    let notification = UINotificationFeedbackGenerator()
    
    
    // MARK: - URL
    
    let ForgotPassword_URL = "http://dratdoorstep.com/livemob/forgotPassword"
    
    @IBOutlet var EmailMobileTextField: UITextField!

    @IBOutlet var GifImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
       
    }
    
    
    // MARK: - SendButton
    
    @IBAction func SendOTP(_ sender: Any) {
        
        let emailMobileDM = EmailMobileTextField.text!
        let deviceTypeDM = "ios"
        
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
                     
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let second = main.instantiateViewController(withIdentifier: "LoginVC")
                        self.present(second, animated: true, completion: nil)
                        
                        self.notification.notificationOccurred(.success)
                  
                    }
                    else{
                        let alert = UIAlertController(title: "Error", message: "\(String(describing: self.forgetPasswordDataModel.message!))", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                        self.notification.notificationOccurred(.warning)                    }
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: self.forgetPasswordDataModel.message!))", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                    
                    self.notification.notificationOccurred(.warning)
                }
                
            }
            else{
                
                let alert = UIAlertController(title: "Error", message: "\(String(describing: self.forgetPasswordDataModel.message!))", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil )
                
                self.notification.notificationOccurred(.warning)
            }
        }
        
    }
    
    func updateChangePassData(json : JSON)  {
        
        forgetPasswordDataModel.emailAddress = json["emailMobile"].stringValue
        
        forgetPasswordDataModel.message = json["message"].stringValue
        forgetPasswordDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
    
    
    // MARK: - CancelButton
    
    @IBAction func CancelBtn(_ sender: Any) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "LoginVC")
        self.present(second, animated: true, completion: nil)
        
        self.notification.notificationOccurred(.success)
        
    }
    
}
