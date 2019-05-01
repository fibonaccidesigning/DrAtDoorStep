//
//  LoginViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 28/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    
    // MARK: - DataModel
    
    let loginDataModel = DrAtDoorDataModel()
    
    
    // MARK: - URL
    
    let Login_URL = "http://dratdoorstep.com/livemob/login"
    let View_Patient_URL = "http://dratdoorstep.com/livemob/viewPatients"
    
    var reachability : Reachability?
    
    let notification = UINotificationFeedbackGenerator()
    
    var flag : Int?
    
    // MARK: - ViewController
    
    @IBOutlet var UsernameTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var LoginBtn: UIButton!
    @IBOutlet var ForgotPasswordBtn: UIButton!
    @IBOutlet var SignUpBtn: UIButton!

    @IBOutlet var GifImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
        
        InternetConnection()
       
    }
    
    
    //MARK: - Check Internet Connection
    
    func InternetConnection()  {
        
        self.reachability = Reachability.init()
        
        if((self.reachability!.connection) != .none){
            print("Internet Availabel")
            
            LoginBtn.setTitle("SIGN IN", for: .normal)
            
            flag = 1
        }else{
            print("Inter Not Availabel")
            flag = 0
            
        }
    }
    
    
     //MARK: - Login

    @IBAction func Login(_ sender: Any) {
        
        let emailDM = UsernameTextField.text!
        let passwordDM = PasswordTextField.text!
        let deviceTypeDM = "ios"
        
        let parms : [String : String] = ["emailMobile" : emailDM,
                                         "password" : passwordDM,
                                         "deviceType" : deviceTypeDM]
        
        InternetConnection()
        
        if flag == 1{
            
             if self.UsernameTextField.text != "" && self.PasswordTextField.text != ""{
                
                getData(url: Login_URL, parameters: parms)
            
             }else{
                
                let alert = UIAlertController(title: "Error", message: "Required Field Missing", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil )
                
                self.notification.notificationOccurred(.warning)
            }
            
            
            
        }else if flag == 0{
            
            self.notification.notificationOccurred(.error)
            
            LoginBtn.setTitle("Internet Not Availabel", for: .normal)
            
        }
        
       
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let LoginJSON : JSON = JSON(respondse.result.value!)
                self.updateLoginData(json: LoginJSON)
                
                if self.loginDataModel.isSuccess == true{
                    
                    self.performSegue(withIdentifier: "goToAppoinment", sender: self)
                    
                }
                else{
                    
                    let alert = UIAlertController(title: "Error", message: "\(self.loginDataModel.message!)", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                    
                    self.notification.notificationOccurred(.warning)
                    
                }
                
            }
            else{
                let alert = UIAlertController(title: "Error", message: "\(String(describing: self.loginDataModel.message!))", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil )
                
                self.notification.notificationOccurred(.warning)
            }
        }
        
    }
    
    func updateLoginData(json : JSON)  {
        
        loginDataModel.emailAddress = json["emailAddress"].stringValue
        loginDataModel.password = json["password"].stringValue
        loginDataModel.userId = json["user"]["userId"].intValue
        
        loginDataModel.message = json["message"].stringValue
        loginDataModel.isSuccess = json["isSuccess"].boolValue
        
        updateUIData()
        
    }
    
    func updateUIData() {
    
        
        let dataUserId = "\(loginDataModel.userId!)"
        
        UserDefaults.standard.set(dataUserId, forKey: "userId")
      
         UserDefaults.standard.synchronize()
        
    }
    
}


//MARK: - Hide Keybord

extension UIViewController{
    
    func HideKeybord() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
}
