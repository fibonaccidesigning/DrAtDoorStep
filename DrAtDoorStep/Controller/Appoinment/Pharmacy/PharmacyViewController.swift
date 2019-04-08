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

class PharmacyViewController: UIViewController {

    
    // MARK: DataModel
    
    let doctorDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let ePharmacy_URL = "http://dratdoorstep.com/livemob/ePharmacy"

    
    //MARK: - ViewControllers
    
    @IBOutlet var ContactPersonTextField: UITextField!
    @IBOutlet var ContactNumberTextField: UITextField!
    @IBOutlet var LandlineTextField: UITextField!
    @IBOutlet var DeliveryAddressTextField: UITextField!
    @IBOutlet var BackBtn: UIButton!
    
    @IBOutlet var OrderB: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeybord()
 
        
    }

    // MARK: - Order
    
    @IBAction func OrderBtn(_ sender: Any) {
        
        if ContactPersonTextField.text != "" && ContactNumberTextField.text != "" && LandlineTextField.text != "" && DeliveryAddressTextField.text != "" {
            
            self.dataSend()
            
            
        }else{
            
            let impact = UIImpactFeedbackGenerator()
            impact.impactOccurred()
            
            let alert = UIAlertController(title: "Oops!", message: "Required field missing", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil )
            
        }
        
    }
    
    func dataSend() {
        
        let userIdDM = "5191"
        let contactPersonDM = ContactPersonTextField.text!
        let contactNumberDM = ContactNumberTextField.text!
        let addressDM = DeliveryAddressTextField.text!
        let landlineNumberDM = LandlineTextField.text!
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "contactPerson" : contactPersonDM,
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
                        
                    
                }else{
                    
                    let impact = UIImpactFeedbackGenerator()
                    impact.impactOccurred()
                    
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: self.doctorDataModel.message!))", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                }
            }
            
        }
    }
    
    func updateDoctorData(json : JSON)  {
        
        doctorDataModel.patientId = json["patientId"].stringValue
        doctorDataModel.address = json["contactPerson"].stringValue
        doctorDataModel.complain = json["contactNumber"].stringValue
        doctorDataModel.typeId = json["address"].stringValue
        doctorDataModel.date = json["landlineNumber"].stringValue
    
        doctorDataModel.isSuccess = json["isSuccess"].boolValue
        doctorDataModel.message = json["message"].stringValue
        
    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
