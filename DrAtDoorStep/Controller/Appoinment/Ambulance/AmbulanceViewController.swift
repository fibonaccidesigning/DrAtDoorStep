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

class AmbulanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {

    
    // MARK: DataModel
    
    let doctorDataModel = DrAtDoorDataModel()
       var locationManager = CLLocationManager()
    
    
    // MARK: URL
    
    let CallAmbulance_URL = "http://dratdoorstep.com/livemob/callAmbulance"
    let Cities_URL = "http://dratdoorstep.com/livemob/cities"
    let Doctor_URL = "http://dratdoorstep.com/livemob/doctorTypes"
    let Time_URL = "http://dratdoorstep.com/livemob/timeSlotsTime"
    
    
    // MARK: - Arrays
    
    
    let TimeS = ["08:00:00","09:00:00","10:00:00","11:00:00","12:00:00","13:00:00","14:00:00","15:00:00","16:00:00","17:00:00","18:00:00","19:00:00","20:00:00"]
    
    let DoctorS = ["One Way","With Return (Within 1 hour)"]
    
    let GenderS = ["Male","Female"]
    
     let notification = UINotificationFeedbackGenerator()
    
    var cityPickData : [Dictionary<String, String>] = []
    var timePickData : [Dictionary<String, String>] = []
    
    var selectedItem  = ""
    var selectedPatientId = ""
    var selectGenderType = ""
    
    var selectDrType = ""
    
    var selectTime = ""
    var selectI = ""
    var selectCity = ""
    
    var RetriveFechData = 0
    
    var languAdd : Double = 0
    var latitAdd : Double = 0
    
    var flag = 0
    var appoinmetnFlag = 0
    
    var UNIXDate : Double = 0
    
    var isToEditFlag = ""
    var isForBookFlag = ""
    
    
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
        
        // MARK: - Hide Controller
        
        UIViewVC.isHidden = true
        ToolBarVC.isHidden = true
        
        GenderPicker.isHidden = true
        CityPicker.isHidden = true
        TimePicker.isHidden = true
        TypePicker.isHidden = true
        DatePicker.isHidden = true
       
        
        //MARK: - UserDefult
        
        RetriveFechData = UserDefaults.standard.integer(forKey: "userID")
        print(RetriveFechData)
        
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
            
             if flag == 0 {
                cityPickData.append(countryyy![i].dictionaryObject as! [String : String])
                
                selectedItem = cityPickData[i]["cityName"]!
                selectCity = cityPickData[i]["cityId"]!
                
                self.CityPicker.reloadAllComponents()
                
                print(selectI)
            }
        }
        flag = 1
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
        
        DateTextField.text = selectedDate
        
        // MARK: - Date to UNIXTime
        
        let dateString = dateFormatter.date(from: selectedDate)
        
        let dateTimeStamp  = dateString!.timeIntervalSince1970
        
        UNIXDate = dateTimeStamp
        
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
            appoinmetnFlag = 1
            isToEditFlag = "false"
            isForBookFlag = "true"
            self.dataSend()
        }else{
            
            let alert = UIAlertController(title: "Oops!", message: "Required field missing", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil )
            
            notification.notificationOccurred(.warning)
        }
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        
        if ContactPersonTextField.text != "" && AgeTextField.text != "" && GenderTextField.text != "" && MobileTextField.text != "" && LandlineTextField.text != "" && AddressTextField.text != "" && SelectCityTextField.text != "" && DateTextField.text != "" && SelectTimeTextField.text != "" && ConditionTextField.text != "" && SelectTypeTextField.text != "" && FromTextField.text != ""{
            isToEditFlag = "false"
            isForBookFlag = "false"
            self.dataSend()
        }else{
            
            let alert = UIAlertController(title: "Oops!", message: "Required field missing", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil )
            
              notification.notificationOccurred(.warning)
        }
    }
    
    // MARK: - SendData
    
    func dataSend() {
        
        if SelectTypeTextField.text == "One Way"{
            selectDrType = "1"
        }else if SelectTypeTextField.text == "With Return (Within 1 hour)"{
            selectDrType = "2"
        }
        
        if GenderTextField.text == "Male"{
            selectGenderType = "M"
        }else if GenderTextField.text == "Female"{
            selectGenderType = "F"
        }
        
        let userIdDM =  "\(RetriveFechData)"
        let contactPersonDM = ContactPersonTextField.text!
        let ageDM = AgeTextField.text!
        let genderDrDM = selectGenderType
        let mobileNumberDM = MobileTextField.text!
        let landlineNumberDM = LandlineTextField.text!
        let addressPatientDM = FromTextField.text!
        let cityIdDM = selectCity
        let conditionDM = ConditionTextField.text!
        let typeDM = SelectTypeTextField.text!
        let dateDM = "\(UNIXDate)"
        let timeDM = selectI
        let addressDM = AddressTextField.text!
        let deviceTypeDM = "ios"
        let isToEditDM = isToEditFlag
        let isForBookDM = isForBookFlag
        
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
                                         "isForBook" : isForBookDM,
                                         "deviceType" : deviceTypeDM,
                                         "isToEdit" : isToEditDM ]
        
        getData(url: CallAmbulance_URL, parameters: parms)
        
        print(parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let DoctorJSON : JSON = JSON(respondse.result.value!)
                self.updateDoctorData(json: DoctorJSON)
                
                if self.doctorDataModel.isSuccess == true{
                    
                     if self.appoinmetnFlag == 1{

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
                        
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let second = main.instantiateViewController(withIdentifier: "CartVC")
                        self.present(second, animated: true, completion: nil)
                        self.notification.notificationOccurred(.success)
                        
                     }else{
                        
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
                        
                        let alert = UIAlertController(title: "Add", message: "\(String(describing: self.doctorDataModel.message!))", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                        self.notification.notificationOccurred(.success)
                    }
                    
                }else{
                    
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
        doctorDataModel.complain = json["age"].stringValue
        doctorDataModel.typeId = json["type"].stringValue
       // doctorDataModel.date = json["date"].stringValue
        doctorDataModel.timeSlot = json["landlineNumber"].stringValue
        doctorDataModel.address = json["addressPatient"].stringValue
        doctorDataModel.name = json["cityId"].stringValue
        doctorDataModel.timeSlot = json["condition"].stringValue
        doctorDataModel.address = json["addressPatient"].stringValue
        doctorDataModel.name = json["address"].stringValue
        doctorDataModel.isToEdit = json["isToEdit"].stringValue
        
        doctorDataModel.isSuccess = json["isSuccess"].boolValue
        doctorDataModel.message = json["message"].stringValue
        
        
    }
    
    
    // MARK: - AddPatient
    
    @IBAction func AddPatient(_ sender: Any) {
    }
    
    
    // MARK: - CurrentAddress
    
    @IBAction func CurrentAddress(_ sender: Any) {
        notification.notificationOccurred(.success)
        //determineMyCurrentLocation()
    }
    
    
    // MARK: - Back
    
    @IBAction func BackBtn(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "initController")
        self.present(second, animated: true, completion: nil)
    }
    
    
    // MARK: - TermsCondition
    
    @IBAction func TermsCondition(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "TermsConditionVC")
        self.present(second, animated: true, completion: nil)

    }
    
}
