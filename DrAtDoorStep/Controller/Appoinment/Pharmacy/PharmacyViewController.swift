//
//  PharmacyViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class PharmacyViewController: UIViewController {

    
    // MARK: DataModel
    
    let doctorDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let ePharmacy_URL = "http://dratdoorstep.com/livemob/ePharmacy"

    
    //MARK: - IBOutles
    
    @IBOutlet var ContactPersonTextField: UITextField!
    @IBOutlet var ContactNumberTextField: UITextField!
    @IBOutlet var LandlineTextField: UITextField!
    @IBOutlet var DeliveryAddressTextField: UITextField!
    @IBOutlet var BackBtn: UIButton!
    
    @IBOutlet var OrderB: UIButton!
    
    
    //MARK: - Variables
    
    let notification = UINotificationFeedbackGenerator()
    
    var RetriveFechData = 0
    
  
    var isToEditFlag = ""
    var isForBookFlag = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeybord()
 
        //MARK: - UserDefult
        
        RetriveFechData = UserDefaults.standard.integer(forKey: "userID")
        print(RetriveFechData)
        
    }
    
    @IBAction func ContactPerson(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func Contact(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func Landline(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func Address(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    // MARK: - Order
    
    @IBAction func OrderBtn(_ sender: Any) {
        
        if ContactPersonTextField.text != "" && ContactNumberTextField.text != "" && LandlineTextField.text != "" && DeliveryAddressTextField.text != "" {
            
            isToEditFlag = "false"
            isForBookFlag = "true"
            
            self.dataSend()
            
        }else{
            
            let impact = UIImpactFeedbackGenerator()
            impact.impactOccurred()
            
            let alert = UIAlertController(title: "Oops!", message: "Required field missing", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil )
            
            notification.notificationOccurred(.warning)
        }
        
    }
    
    func dataSend() {
        
        let userIdDM = "\(RetriveFechData)"
        let contactPersonDM = ContactPersonTextField.text!
        let contactNumberDM = ContactNumberTextField.text!
        let addressDM = DeliveryAddressTextField.text!
        let landlineNumberDM = LandlineTextField.text!
        let isToEditDM = isToEditFlag
        let isForBookDM = isForBookFlag
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "contactPerson" : contactPersonDM,
                                         "isToEdit" : isToEditDM,
                                         "isForBook" : isForBookDM,
                                         "contactNumber" : contactNumberDM,
                                         "address" : addressDM,
                                         "landlineNumber" : landlineNumberDM]
        
        getData(url: ePharmacy_URL, parameters: parms)
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let DoctorJSON : JSON = JSON(respondse.result.value!)
                self.updateDoctorData(json: DoctorJSON)
                
                if self.doctorDataModel.isSuccess == true{
                    
                    let alert = UIAlertController(title: "Successfully Add", message: "\(self.doctorDataModel.message!)", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                    
                    self.ContactPersonTextField.text = ""
                    self.ContactNumberTextField.text = ""
                    self.LandlineTextField.text = ""
                    self.DeliveryAddressTextField.text = ""
                    
                    self.notification.notificationOccurred(.success)
                    
                }else{
                    
                    let impact = UIImpactFeedbackGenerator()
                    impact.impactOccurred()
                    
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: self.doctorDataModel.message!))", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                    
                    self.notification.notificationOccurred(.warning)
                }
            }
            
        }
    }
    
    func updateDoctorData(json : JSON)  {
        
        doctorDataModel.patientId = json["patientId"].intValue
        doctorDataModel.address = json["contactPerson"].stringValue
        doctorDataModel.complain = json["contactNumber"].stringValue
        doctorDataModel.typeId = json["address"].stringValue
       // doctorDataModel.date = json["landlineNumber"].stringValue
    
        doctorDataModel.isSuccess = json["isSuccess"].boolValue
        doctorDataModel.message = json["message"].stringValue
        
    }
    
    @IBAction func Back(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "initController")
        self.present(second, animated: true, completion: nil)
    }
}
