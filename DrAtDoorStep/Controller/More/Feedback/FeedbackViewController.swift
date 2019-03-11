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

class FeedbackViewController: UIViewController {
    
    // MARK: DataModel
    
    let feedbackDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let Feedback_URL = "http://dratdoorstep.com/livemob/feedback"
    
    
    //MARK: - ViewController
    
    @IBOutlet var OptionTextField: UITextField!
    @IBOutlet var ServiceTextField: UITextField!
    @IBOutlet var FeedbackTextField: UITextView!
    @IBOutlet var SubmitBtn: UIButton!
    @IBOutlet var MessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
        SubmitBtn.layer.cornerRadius = 0.02 * SubmitBtn.bounds.size.width
        SubmitBtn.clipsToBounds = true
        MessageLabel.text = ""
    }
    
    @IBAction func Submit(_ sender: Any) {
        
       
        
        let optionIdDM = OptionTextField.text!
        let serviceIdDM = ServiceTextField.text!
        let feedbackDM = FeedbackTextField.text!
        let userIdDM = "5191"
        
        
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
                        self.MessageLabel.text = self.feedbackDataModel.message
                        
                        let alert = UIAlertController(title: "Sent", message: "Feedback Posted Successfully.", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                    }
                    else{
                        self.MessageLabel.text = self.feedbackDataModel.message
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
        
        feedbackDataModel.optionId = json["optionId"].stringValue
        feedbackDataModel.serviceId = json["serviceId"].stringValue
        feedbackDataModel.feedback = json["feedback"].stringValue
        feedbackDataModel.message = json["message"].stringValue
        feedbackDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
}
