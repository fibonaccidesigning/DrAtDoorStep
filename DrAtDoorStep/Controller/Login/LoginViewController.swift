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

    
    // MARK: DataModel
    
    let loginDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let Login_URL = "http://dratdoorstep.com/livemob/login"
    
    
    //MARK: - ViewController
    
    @IBOutlet var UsernameTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var LoginBtn: UIButton!
    @IBOutlet var ForgotPasswordBtn: UIButton!
    @IBOutlet var SignUpBtn: UIButton!
    @IBOutlet var FacebookBtn: UIButton!
    @IBOutlet var GoogleBtn: UIButton!
    @IBOutlet var MessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
        MessageLabel.text = ""

    }
    
     //MARK: - Login

    @IBAction func Login(_ sender: Any) {
        
        let emailDM = UsernameTextField.text!
        let passwordDM = PasswordTextField.text!
        
        let parms : [String : String] = ["emailMobile" : emailDM,
                                         "password" : passwordDM]
        
        getData(url: Login_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let LoginJSON : JSON = JSON(respondse.result.value!)
                self.updateLoginData(json: LoginJSON)
                
                if self.UsernameTextField.text != "" && self.PasswordTextField.text != ""{
                    
                    if self.loginDataModel.isSuccess == true{
                        self.MessageLabel.text = self.loginDataModel.message
                        self.performSegue(withIdentifier: "goToAppoinment", sender: self)
                    }
                    else{
                        self.MessageLabel.text = self.loginDataModel.message
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
    
    func updateLoginData(json : JSON)  {
        
        loginDataModel.emailAddress = json["emailAddress"].stringValue
        loginDataModel.password = json["password"].stringValue
        loginDataModel.message = json["message"].stringValue
        loginDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
    
}

extension UIViewController{
    
    func HideKeybord() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
}
