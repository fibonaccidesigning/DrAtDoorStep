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
    
    
    // MARK: URL
    
    let ResetPassword_URL = "http://dratdoorstep.com/livemob/resetPassword"
    
    
    //MARK: - ViewController
    
    @IBOutlet var MessageLabel: UILabel!
    @IBOutlet var NewPasswordTextField: UITextField!
    @IBOutlet var ConfirmPasswordTextField: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
        MessageLabel.text = ""
    }
    
    @IBAction func Skip(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoToMenu", sender: self)
        self.MessageLabel.text = self.CreatePasswordDataModel.message
        
    }
    
    @IBAction func ResetPassword(_ sender: Any) {
        
        let userIdDM = ""
        let isSkipDM = ""
        let passwordDM = ""
        let deviceTypeDM = ""
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "isSkip" : isSkipDM,
                                         "password" : passwordDM,
                                         "deviceType" : deviceTypeDM]
        
        getData(url: ResetPassword_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let ResetPasswordJSON : JSON = JSON(respondse.result.value!)
                self.updateRegisterData(json: ResetPasswordJSON)
                
                if self.NewPasswordTextField.text != "" && self.ConfirmPasswordTextField.text != ""{
                    
                    if self.CreatePasswordDataModel.isSuccess == true{
                        self.performSegue(withIdentifier: "GoToMenu", sender: self)
                        self.MessageLabel.text = self.CreatePasswordDataModel.message
                    }
                    else{
                        self.MessageLabel.text = self.CreatePasswordDataModel.message
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
        
        CreatePasswordDataModel.userId = json["userId"].intValue
        CreatePasswordDataModel.isSkip = json["isSkip"].boolValue
        CreatePasswordDataModel.password = json["password"].stringValue
        CreatePasswordDataModel.deviceType = json["deviceType"].stringValue
        CreatePasswordDataModel.message = json["message"].stringValue
        CreatePasswordDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
    
}
