//
//  FeedbackViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FeedbackViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    // MARK: DataModel
    
    let feedbackDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let Feedback_URL = "http://dratdoorstep.com/livemob/feedback"
    
    
    // MARK: - Arrays
    
    let OptionS = ["Feedback","Complain"]
    
    let ServiceS = ["Website Related","Doctor Related", "Support Related","Application Related", "Other"]
    
    let notification = UINotificationFeedbackGenerator()
    
    var pickData : [Dictionary<String, String>] = []
    
    var selectedItem  = ""
    var selectedPatientId = ""
    
    var selectOption = ""
    var selectService = ""
    
    var RetriveFechData = 0
    
    var languAdd : Double = 0
    var latitAdd : Double = 0
    
    var flag = 0
    var appoinmetnFlag = 0
    
    var isToEditFlag = ""
    var isForBookFlag = ""
    
    
    //MARK: - IBOutlets
    
    @IBOutlet var OptionTextField: UITextField!
    @IBOutlet var ServiceTextField: UITextField!
    @IBOutlet var FeedbackTextField: UITextView!
    
    @IBOutlet var SubmitBtn: UIButton!
    
    @IBOutlet var OprionPickerVC: UIPickerView!
    @IBOutlet var ServicePickerVC: UIPickerView!
    
    @IBOutlet var UIViewVC: UIView!
    @IBOutlet var BarVC: UIToolbar!
    @IBOutlet var BatLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeybord()
        
        OprionPickerVC.isHidden = true
        ServicePickerVC.isHidden = true
        
        UIViewVC.isHidden = true
        BarVC.isHidden = true
        
        
        //MARK: - UserDefult
        
        RetriveFechData = UserDefaults.standard.integer(forKey: "userID")
        print(RetriveFechData)
        
    }
    
    
    //MARK: - Select Option
    
    @IBAction func SelectOption(_ sender: Any) {
        
        OprionPickerVC.isHidden = false
        ServicePickerVC.isHidden = true
        
        UIViewVC.isHidden = false
        BarVC.isHidden = false
        
        BatLabel.text = "Select Option"
        
        self.view.endEditing(true)
    }
    
    
    //MARK: - Select Service
    
    @IBAction func SelectService(_ sender: Any) {
        
        OprionPickerVC.isHidden = true
        ServicePickerVC.isHidden = false
        
        UIViewVC.isHidden = false
        BarVC.isHidden = false
        
        BatLabel.text = "Select Services"
        
        self.view.endEditing(true)
        
    }
    
    
    // MARK: - PickerView Delegate Method
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == OprionPickerVC {
            return OptionS.count
        }else if pickerView == ServicePickerVC{
            return ServiceS.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       if pickerView == OprionPickerVC{
            return OptionS[row]
        }else if pickerView == ServicePickerVC{
            return ServiceS[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == OprionPickerVC{
            OptionTextField.text = OptionS[row]
            selectOption = OptionS[row]
            self.view.endEditing(false)
        }else if pickerView == ServicePickerVC{
            ServiceTextField.text = ServiceS[row]
            self.view.endEditing(false)
            selectService = ServiceS[row]
        }
        
    }
    

    
    @IBAction func Submit(_ sender: Any) {
        
        if selectService == "Website Related"{
            selectService = "1"
        }else if selectService == "Doctor Related"{
            selectService = "2"
        }else if selectService == "Support Related"{
            selectService = "3"
        }else if selectService == "Application Related"{
            selectService = "4"
        }else if selectService == "Other"{
            selectService = "5"
        }
        
        if selectOption == "Feedback"{
            selectOption = "1"
        }else if selectOption == "Complain"{
            selectOption = "2"
        }
        
        let userIdDM = "\(RetriveFechData)"
        let optionIdDM = selectOption
        let serviceIdDM = selectService
        let feedbackDM = FeedbackTextField.text!
        
        
        
        let parms : [String : String] = ["optionId" : optionIdDM,
                                         "serviceId" : serviceIdDM,
                                         "feedback" : feedbackDM,
                                         "userId" : userIdDM]
        
        getData(url: Feedback_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let ChangePasswordJSON : JSON = JSON(respondse.result.value!)
                self.updateRegisterData(json: ChangePasswordJSON)
                
                if self.OptionTextField.text != "" && self.ServiceTextField.text != "" && self.FeedbackTextField.text != ""  {
                    
                    if self.feedbackDataModel.isSuccess == true{
                       
                        
                        let alert = UIAlertController(title: "Sent", message: "\(self.feedbackDataModel.message!)", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                        self.OptionTextField.text = ""
                        self.ServiceTextField.text = ""
                        self.FeedbackTextField.text = ""
                        
                        self.notification.notificationOccurred(.success)
                        
                        
                    }
                    else{
                        let alert = UIAlertController(title: "Error", message: "\(self.feedbackDataModel.message!)", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                        self.notification.notificationOccurred(.warning)
                        
                    }
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "\(self.feedbackDataModel.message!)", preferredStyle: .alert)
                    
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
    
    func updateRegisterData(json : JSON)  {
        
        feedbackDataModel.optionId = json["optionId"].stringValue
        feedbackDataModel.serviceId = json["serviceId"].stringValue
        feedbackDataModel.feedback = json["feedback"].stringValue
        feedbackDataModel.message = json["message"].stringValue
        feedbackDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
    
    @IBAction func Done(_ sender: Any) {
        
        OprionPickerVC.isHidden = true
        ServicePickerVC.isHidden = true
        
        UIViewVC.isHidden = true
        BarVC.isHidden = true
        
    }
}
