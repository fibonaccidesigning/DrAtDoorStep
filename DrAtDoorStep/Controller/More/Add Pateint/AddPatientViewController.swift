//
//  AddPatientViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddPatientViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    // MARK: DataModel
    
    let addPatientDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let AddPatient_URL = "http://dratdoorstep.com/livemob/addEditPatient"
    
    
    //MARK: - ViewController
    
    let gender = ["Male","Female"]
    
    
    //MARK: - ViewController
    
    @IBOutlet var NameTextField: UITextField!
    @IBOutlet var BuldingTextField: UITextField!
    @IBOutlet var AreaTextField: UITextField!
    @IBOutlet var CityTextField: UITextField!
    @IBOutlet var AgeTxtField: UITextField!
    @IBOutlet var GenderTextField: UITextField!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var ViewVC: UIView!
    @IBOutlet var PickerViewVC: UIPickerView!
    @IBOutlet var TabBarVC: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeybord()
        
        saveBtn.layer.cornerRadius = 0.02 * saveBtn.bounds.size.width
        saveBtn.clipsToBounds = true
        
        ViewVC.isHidden = true
        PickerViewVC.isHidden = true
        TabBarVC.isHidden = true
        
    }
    
    //MARK: - Save
    
    @IBAction func Save(_ sender: Any) {
        
        let userIdDM = "4"
        let nameDM = NameTextField.text!
        let buldingDM = BuldingTextField.text!
        let areaDM = AreaTextField.text!
        let cityDM = CityTextField.text!
        let ageDM = AgeTxtField.text!
        let genderDM = GenderTextField.text!
        let isToEditDM = "true"
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "name" : nameDM,
                                         "address" : buldingDM,
                                         "area" : areaDM,
                                         "cityId" : cityDM,
                                         "age" : ageDM,
                                         "gender" : genderDM,
                                         "isToEdit" : isToEditDM]
        
        getData(url: AddPatient_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let LoginJSON : JSON = JSON(respondse.result.value!)
                self.updateLoginData(json: LoginJSON)
                
                if self.addPatientDataModel.isSuccess == true{
                   
                    let alert = UIAlertController(title: "Add", message: "\(self.addPatientDataModel.message!)", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                    
                }else{
                    
                    let alert = UIAlertController(title: "Error", message: "\(String(describing: self.addPatientDataModel.message!))", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil )
                }
            }
        
        }
    }
    
    func updateLoginData(json : JSON)  {
        
        addPatientDataModel.name = json["name"].stringValue
        addPatientDataModel.address = json["address"].stringValue
        addPatientDataModel.area = json["area"].stringValue
        addPatientDataModel.cityId = json["cityId"].intValue
        addPatientDataModel.age = json["age"].intValue
        addPatientDataModel.gender = json["gender"].stringValue
        addPatientDataModel.isToEdit = json["isToEdit"].boolValue
        
        addPatientDataModel.isSuccess = json["isSuccess"].boolValue
        addPatientDataModel.message = json["message"].stringValue
        
    }
    
    
    // MARK: - Select Gender
    
    @IBAction func SelectGender(_ sender: Any) {
        ViewVC.isHidden = false
        PickerViewVC.isHidden = false
        TabBarVC.isHidden = false
    }

    
    // MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        GenderTextField.text = gender[row]
    }

    // MARK: - Done
    
    @IBAction func Done(_ sender: Any) {
        ViewVC.isHidden = true
        PickerViewVC.isHidden = true
        TabBarVC.isHidden = true
    }
    

}
