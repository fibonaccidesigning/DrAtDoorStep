//
//  AmbulanceViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class AmbulanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    // MARK: DataModel
    
    let doctorDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let CallAmbulance_URL = "http://dratdoorstep.com/livemob/callAmbulance"
    let Cities_URL = "http://dratdoorstep.com/livemob/cities"
    let Doctor_URL = "http://dratdoorstep.com/livemob/doctorTypes"
    let Time_URL = "http://dratdoorstep.com/livemob/timeSlotsTime"
    
    
    // MARK: - Arrays
    
    
    let TimeS = ["08:00:00","09:00:00","10:00:00","11:00:00","12:00:00","13:00:00","14:00:00","15:00:00","16:00:00","17:00:00","18:00:00","19:00:00","20:00:00"]
    let DoctorS = ["One Way","With Return (Within 1 hour)"]
    let GenderS = ["Male","Female"]
    
    
    var cityPickData : [Dictionary<String, String>] = []
    var timePickData : [Dictionary<String, String>] = []
    
    var selectedItem  = ""
    var selectedPatientId = ""
    
    var selectDrType = ""
    
    var selectTime = ""
    var selectI = ""
    
    
    // MARK: - ViewControllers
    
    @IBOutlet var ContactPersonTextField: UITextField!
    @IBOutlet var AgeTextField: UITextField!
    @IBOutlet var GenderTextField: UITextField!
    @IBOutlet var MobileTextField: UITextField!
    @IBOutlet var LandlineTextField: UITextField!
    @IBOutlet var AddressTextField: UITextField!
    @IBOutlet var SelectCityTextField: UITextField!
    @IBOutlet var DateTextField: UITextField!
    @IBOutlet var SelectTimeTextField: UITextField!
    @IBOutlet var ConditionTextField: UITextField!
    @IBOutlet var SelectTypeTextField: UITextField!
    @IBOutlet var FromTextField: UITextField!
    
    @IBOutlet var BookAppoinmentBtn: UIButton!
    @IBOutlet var AddToCartBtn: UIButton!
    
    @IBOutlet var UIViewVC: UIView!
    @IBOutlet var ToolBarVC: UIToolbar!
    
    @IBOutlet var GenderPicker: UIPickerView!
    @IBOutlet var CityPicker: UIPickerView!
    @IBOutlet var TimePicker: UIPickerView!
    @IBOutlet var TypePicker: UIPickerView!
    @IBOutlet var DatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeybord()
        
        // MARK: - Rounded Button
        
        BookAppoinmentBtn.layer.cornerRadius = 0.05 * BookAppoinmentBtn.bounds.size.width
        BookAppoinmentBtn.clipsToBounds = true
        
        AddToCartBtn.layer.cornerRadius = 0.05 * AddToCartBtn.bounds.size.width
        AddToCartBtn.clipsToBounds = true
        
        
        // MARK: - Hide Controller
        
        UIViewVC.isHidden = true
        ToolBarVC.isHidden = true
        
        GenderPicker.isHidden = true
        CityPicker.isHidden = true
        TimePicker.isHidden = true
        TypePicker.isHidden = true
        DatePicker.isHidden = true
       
        
        // MARK: - Current Location
        
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
            
        }
        
    }
    

    // MARK: - Select Gender
    
    @IBAction func SelectGender(_ sender: Any) {
        
        UIViewVC.isHidden = false
        ToolBarVC.isHidden = false
        
        GenderPicker.isHidden = false
        CityPicker.isHidden = true
        TimePicker.isHidden = true
        TypePicker.isHidden = true
        DatePicker.isHidden = true
        
    }
    
    // MARK: - Select City
    
    @IBAction func SelectCity(_ sender: Any) {
        
        UIViewVC.isHidden = false
        ToolBarVC.isHidden = false
        
        GenderPicker.isHidden = true
        CityPicker.isHidden = false
        TimePicker.isHidden = true
        TypePicker.isHidden = true
        DatePicker.isHidden = true
        
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
    
    // MARK: - Select Date
    
    @IBAction func Date(_ sender: Any) {
        
        UIViewVC.isHidden = false
        ToolBarVC.isHidden = false
        
        GenderPicker.isHidden = true
        CityPicker.isHidden = true
        TimePicker.isHidden = true
        TypePicker.isHidden = true
        DatePicker.isHidden = false
        
        DatePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/M/yyyy"
        let selectedDate = dateFormatter.string(from: DatePicker.date)
        1
        DateTextField.text = selectedDate
        
    }
    
    // MARK: - Select Time
    
    @IBAction func Time(_ sender: Any) {
        
        UIViewVC.isHidden = false
        ToolBarVC.isHidden = false
        
        GenderPicker.isHidden = true
        CityPicker.isHidden = true
        TimePicker.isHidden = false
        TypePicker.isHidden = true
        DatePicker.isHidden = true
        
    }
    
    // MARK: - Select Type
    
    @IBAction func SelectType(_ sender: Any) {
        
        UIViewVC.isHidden = false
        ToolBarVC.isHidden = false
        
        GenderPicker.isHidden = true
        CityPicker.isHidden = true
        TimePicker.isHidden = true
        TypePicker.isHidden = false
        DatePicker.isHidden = true
        
    }
    
    
    // MARK: - Done
    
    @IBAction func Done(_ sender: Any) {
        
        UIViewVC.isHidden = true
        ToolBarVC.isHidden = true
        
        GenderPicker.isHidden = true
        CityPicker.isHidden = true
        TimePicker.isHidden = true
        TypePicker.isHidden = true
        DatePicker.isHidden = true
        
    }
    
    
    // MARK: - PickerView Delegate Method
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == GenderPicker {
            return self.GenderS.count
        } else if pickerView == CityPicker{
            return cityPickData.count
        }else if pickerView == TimePicker{
            return TimeS.count
        }else if pickerView == TypePicker{
                return DoctorS.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == GenderPicker{
            return self.GenderS[row]
        } else if pickerView == CityPicker{
            return self.cityPickData[row]["cityName"]
        }else if pickerView == TimePicker{
            return TimeS[row]
        }else if pickerView == TypePicker{
            return DoctorS[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == GenderPicker{
            GenderTextField.text = GenderS[row]
            self.view.endEditing(false)
        }else if pickerView == CityPicker{
            SelectCityTextField.text = selectedItem
            self.view.endEditing(false)
        }else if pickerView == TimePicker{
            SelectTimeTextField.text = TimeS[row]
            self.view.endEditing(false)
            selectI = TimeS[row]
        }else if pickerView == TypePicker{
            SelectTypeTextField.text = DoctorS[row]
            self.view.endEditing(false)
        }
        
    }
    
    
    // MARK: - Book Appoinment
    
    @IBAction func BookAppoinment(_ sender: Any) {

        if ContactPersonTextField.text != "" && AgeTextField.text != "" && GenderTextField.text != "" && MobileTextField.text != "" && LandlineTextField.text != "" && AddressTextField.text != "" && SelectCityTextField.text != "" && DateTextField.text != "" && SelectTimeTextField.text != "" && ConditionTextField.text != "" && SelectTypeTextField.text != "" && FromTextField.text != ""{
            self.dataSend()
        }else{
            
            let alert = UIAlertController(title: "Oops!", message: "Required field missing", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil )
        }
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        
        if ContactPersonTextField.text != "" && AgeTextField.text != "" && GenderTextField.text != "" && MobileTextField.text != "" && LandlineTextField.text != "" && AddressTextField.text != "" && SelectCityTextField.text != "" && DateTextField.text != "" && SelectTimeTextField.text != "" && ConditionTextField.text != "" && SelectTypeTextField.text != "" && FromTextField.text != ""{
            self.dataSend()
        }else{
            
            let alert = UIAlertController(title: "Oops!", message: "Required field missing", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil )
        }
    }
    
    func dataSend() {
        
        if SelectTypeTextField.text == "One Way"{
            selectDrType = "1"
        }else if SelectTypeTextField.text == "With Return (Within 1 hour)"{
            selectDrType = "2"
        }
        
        let userIdDM = "5191"
        let contactPersonDM = ContactPersonTextField.text!
        let ageDM = AgeTextField.text!
        let genderDrDM = "M" //GenderTextField.text!
        let mobileNumberDM = MobileTextField.text!
        let landlineNumberDM = LandlineTextField.text!
        let addressPatientDM = AddressTextField.text!
        let cityIdDM = "163"
        let conditionDM = ConditionTextField.text!
        let typeDM = SelectTypeTextField.text!
        let dateDM = "1554316200" //DateTextField.text!
        let timeDM = SelectTimeTextField.text!
        let addressDM = AddressTextField.text!
        let isToEditDM = "false"
        let deviceTypeDM = "ios"
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "contactPerson" : contactPersonDM,
                                         "age" : ageDM,
                                         "gender" : genderDrDM,
                                         "mobileNumber" : mobileNumberDM,
                                         "landlineNumber" : landlineNumberDM,
                                         "addressPatient" : addressPatientDM,
                                         "cityId" : cityIdDM,
                                         "condition" : conditionDM,
                                         "type" : typeDM,
                                         "date" : dateDM,
                                         "time" : timeDM,
                                         "address" : addressDM,
                                         "deviceType" : deviceTypeDM,
                                         "isToEdit" : isToEditDM ]
        
        getData(url: CallAmbulance_URL, parameters: parms)
        
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
                    self.AgeTextField.text = ""
                    self.GenderTextField.text = ""
                    self.MobileTextField.text = ""
                    self.LandlineTextField.text = ""
                    self.AddressTextField.text = ""
                    self.SelectCityTextField.text = ""
                    self.DateTextField.text = ""
                    self.SelectTimeTextField.text = ""
                    self.ConditionTextField.text = ""
                    self.SelectTypeTextField.text = ""
                    self.FromTextField.text = ""
                        
                    
                }else{
                    
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
        doctorDataModel.complain = json["age"].stringValue
        doctorDataModel.typeId = json["type"].stringValue
        doctorDataModel.date = json["date"].stringValue
        doctorDataModel.timeSlot = json["landlineNumber"].stringValue
        doctorDataModel.address = json["addressPatient"].stringValue
        doctorDataModel.name = json["cityId"].stringValue
        doctorDataModel.timeSlot = json["condition"].stringValue
        doctorDataModel.address = json["addressPatient"].stringValue
        doctorDataModel.name = json["address"].stringValue
        doctorDataModel.isToEdit = json["isToEdit"].boolValue
        
        doctorDataModel.isSuccess = json["isSuccess"].boolValue
        doctorDataModel.message = json["message"].stringValue
        
        
    }
    
    
    // MARK: - AddPatient
    
    @IBAction func AddPatient(_ sender: Any) {
    }
    
    
    // MARK: - CurrentAddress
    
    @IBAction func CurrentAddress(_ sender: Any) {
    }
    
    
    // MARK: - Back
    
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - TermsCondition
    
    @IBAction func TermsCondition(_ sender: Any) {
    }
    
}
