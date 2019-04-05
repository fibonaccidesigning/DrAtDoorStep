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
    let Cities_URL = "http://dratdoorstep.com/livemob/cities"
    
    //MARK: - ViewController
    
    let GenderS = ["Male","Female"]
    
    var cityPickData : [Dictionary<String, String>] = []
    
    var selectedItem  = ""
    var selectedPatientId = ""
    
    var selectDrType = ""
    
    var selectTime = ""
    var selectI = ""
    
    
    //MARK: - ViewController
    
    @IBOutlet var NameTextField: UITextField!
    @IBOutlet var BuldingTextField: UITextField!
    @IBOutlet var AreaTextField: UITextField!
    @IBOutlet var CityTextField: UITextField!
    @IBOutlet var AgeTxtField: UITextField!
    @IBOutlet var GenderTextField: UITextField!
    @IBOutlet var ViewPetaint: UIButton!
    
    @IBOutlet var saveBtn: UIButton!
    
    @IBOutlet var ViewVC: UIView!
    @IBOutlet var TabBarVC: UIToolbar!
    
    @IBOutlet var PickerViewVC: UIPickerView!
    @IBOutlet var CityPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeybord()
        
        // MARK: - Rounded Button
        
        saveBtn.layer.cornerRadius = 0.02 * saveBtn.bounds.size.width
        saveBtn.clipsToBounds = true
        
        
        // MARK: - Hide Controller
        
        ViewVC.isHidden = true
        PickerViewVC.isHidden = true
        TabBarVC.isHidden = true
        
    }
    
    
    // MARK: - Select Gender
    
    @IBAction func SelectGender(_ sender: Any) {
        
        ViewVC.isHidden = false
        TabBarVC.isHidden = false
        
        PickerViewVC.isHidden = false
        CityPicker.isHidden = true
    }
    
    
     // MARK: - Select City
    
    @IBAction func City(_ sender: Any) {
        
        ViewVC.isHidden = false
        TabBarVC.isHidden = false
        
        PickerViewVC.isHidden = true
        CityPicker.isHidden = false
        
        CityLoadData()
    }
    
    func CityLoadData(){
        
        getCityData(url: Cities_URL)
        
    }
    
    func getCityData(url : String) {
        
        Alamofire.request(url, method: .get).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let CustomerJSON : JSON = JSON(respondse.result.value!)
                self.updateCityData(json: CustomerJSON)
                
            }
            else{
                print("Error")
            }
        }
    }
    
    func updateCityData(json : JSON)  {
        
        let countryyy = json["cities"].array
        
        let range = countryyy!.count
        
        for i in 0..<range{
            
            cityPickData.append(countryyy![i].dictionaryObject as! [String : String])
            
            selectedItem = cityPickData[i]["cityName"]!
            selectI = cityPickData[i]["cityId"]!
            
            print(selectedItem)
            
            self.CityPicker.reloadAllComponents()
            
        }
        
    }
    
    // MARK: - Done
    
    @IBAction func Done(_ sender: Any) {
        
        ViewVC.isHidden = true
        TabBarVC.isHidden = true
        
        PickerViewVC.isHidden = true
        CityPicker.isHidden = true
    }
    
    // MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == PickerViewVC {
            return self.GenderS.count
        } else if pickerView == CityPicker{
            return cityPickData.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == PickerViewVC{
            return self.GenderS[row]
        } else if pickerView == CityPicker{
            return self.cityPickData[row]["cityName"]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == PickerViewVC{
            GenderTextField.text = GenderS[row]
            self.view.endEditing(false)
        }else if pickerView == CityPicker{
            CityTextField.text = selectedItem
            self.view.endEditing(false)
        }
        
    }
    
    
    
    // MARK: - Save
    
    @IBAction func Save(_ sender: Any) {
        
        let userIdDM = "4"
        let nameDM = NameTextField.text!
        let buldingDM = BuldingTextField.text!
        let areaDM = AreaTextField.text!
        let cityDM = "139" // CityTextField.text!
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

}
