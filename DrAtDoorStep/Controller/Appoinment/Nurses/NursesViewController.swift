//
//  NursesViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class NursesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {
    

    // MARK: DataModel
    
    let doctorDataModel = DrAtDoorDataModel()
     var locationManager = CLLocationManager()
    
    
    // MARK: URL
    
    let Appoinment_URL = "http://dratdoorstep.com/livemob/appointment"
    let Patient_URL = "http://dratdoorstep.com/livemob/viewPatients"
    let Time_URL = "http://dratdoorstep.com/livemob/timeSlotsTime"
    
    
    // MARK: - Arrays
    
    let TimeS = ["08:00:00","09:00:00","10:00:00","11:00:00","12:00:00","13:00:00","14:00:00","15:00:00","16:00:00","17:00:00","18:00:00","19:00:00","20:00:00"]
    
    let DoctorS = ["Intermediate","Daily", "Procedure"]
    
    let notification = UINotificationFeedbackGenerator()
    
    
    var pickData : [Dictionary<String, String>] = []
    var timePickData : [Dictionary<String, String>] = []
    
    var selectedItem  = ""
    var selectedPatientId = ""
    
    var selectDrType = ""
    
    var selectTime = ""
    var selectI = ""
    
    var RetriveFechData = 0
    
    var languAdd : Double = 0
    var latitAdd : Double = 0
    
    var flag = 0
    var appoinmetnFlag = 0
    
    var UNIXDate : Double = 0
    
    var isToEditFlag = ""
    var isForBookFlag = ""
    
    
    // MARK: - ViewController
    
    @IBOutlet var SelectPatientTextField: UITextField!
    @IBOutlet var ComplainTextField: UITextField!
    @IBOutlet var DateTextField: UITextField!
    @IBOutlet var TimeTextField: UITextField!
    @IBOutlet var SelectDecotorTextField: UITextField!
    @IBOutlet var DaysTextField: UITextField!
    @IBOutlet var AddressTextField: UITextField!
    
    @IBOutlet var BookAppoinmentBtn: UIButton!
    @IBOutlet var AddToCartBtn: UIButton!
    
    @IBOutlet var PickerViewController: UIPickerView!
    @IBOutlet var PickerView1: UIPickerView!
    @IBOutlet var PickerView2: UIPickerView!
    @IBOutlet var DatePic: UIDatePicker!
    @IBOutlet var UIViewVC: UIView!
    
    @IBOutlet var DONE: UIBarButtonItem!
    @IBOutlet var ViewVC: UIToolbar!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeybord()
        
        // MARK: - Hide Controller
        
        ViewVC.isHidden = true
        UIViewVC.isHidden = true
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = true
        PickerView2.isHidden = true
        DatePic.isHidden = true
        
        DaysTextField.isEnabled = false
        
        RetriveFechData = UserDefaults.standard.integer(forKey: "userID")
        print(RetriveFechData)

    }
    
     // MARK: - Select Patient
    
    @IBAction func SelectPatient(_ sender: Any) {
        
        ViewVC.isHidden = false
        UIViewVC.isHidden = false
        
        PickerViewController.isHidden = false
        PickerView1.isHidden = true
        PickerView2.isHidden = true
        DatePic.isHidden = true
        
        PatientloadData()
    }
    
    func PatientloadData(){
        
        let userIdDM = "\(RetriveFechData)"
        let parms : [String : String] = ["userId" : userIdDM]
        getPatientData(url: Patient_URL, parameters: parms)
        
    }
    
    func getPatientData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let PatientJSON : JSON = JSON(respondse.result.value!)
                self.updatePatientData(json: PatientJSON)
                
            }
            else{
                print("Error")
            }
        }
    }
    
    func updatePatientData(json : JSON)  {
        
        let countryyy = json["patients"].array
        
        let range = countryyy!.count
        
        for i in 0..<range{
            
            if flag == 0 {
                pickData.append(countryyy![i].dictionaryObject as! [String : String])
                
                selectedItem = pickData[i]["name"]!
                selectedPatientId = pickData[i]["patientId"]!
                
                self.PickerViewController.reloadAllComponents()
                
            }
        }
        
        flag = 1
       
    }
    
    
    // MARK: - Select Doctor Type
    
    @IBAction func SelectDoctorPic(_ sender: Any) {
        
        ViewVC.isHidden = false
        UIViewVC.isHidden = false
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = false
        PickerView2.isHidden = true
        DatePic.isHidden = true
        
        if SelectDecotorTextField.text == "Intermediate" || SelectDecotorTextField.text == "Daily"{
            DaysTextField.isEnabled = true
        }else{
            DaysTextField.isEnabled = false
        }
        
    }
    
    
     // MARK: - Select Date
    
    @IBAction func SelectDatePic(_ sender: Any) {
        
        ViewVC.isHidden = false
        UIViewVC.isHidden = false
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = true
        PickerView2.isHidden = true
        DatePic.isHidden = false
        
        DatePic.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/M/yyyy"
        let selectedDate = dateFormatter.string(from: DatePic.date)
        
        DateTextField.text = selectedDate
        
        
        // MARK: - Date to UNIXTime
        
        let dateString = dateFormatter.date(from: selectedDate)
        
        let dateTimeStamp  = dateString!.timeIntervalSince1970
        
        UNIXDate = dateTimeStamp
        
    }
    
    
    
     // MARK: - Select Time
    
    @IBAction func SelectTimePic(_ sender: Any) {
        
        ViewVC.isHidden = false
        UIViewVC.isHidden = false
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = true
        PickerView2.isHidden = false
        DatePic.isHidden = true
    }
    
    
    // MARK: - Done Button
    
    @IBAction func Done(_ sender: Any) {
        
        ViewVC.isHidden = true
        UIViewVC.isHidden = true
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = true
        PickerView2.isHidden = true
        DatePic.isHidden = true
        
        if SelectDecotorTextField.text == "Intermediate" || SelectDecotorTextField.text == "Daily"{
            DaysTextField.isEnabled = true
        }else{
            DaysTextField.isEnabled = false
        }
    }
    
    
    // MARK: - PickerView Delegate Method
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == PickerViewController {
            return self.pickData.count
        } else if pickerView == PickerView1{
            return DoctorS.count
        }else if pickerView == PickerView2{
            return TimeS.count
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == PickerViewController{
            return self.pickData[row]["name"]
        } else if pickerView == PickerView1{
            return DoctorS[row]
        }else if pickerView == PickerView2{
            return TimeS[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == PickerViewController{
            SelectPatientTextField.text = selectedItem
            self.view.endEditing(false)
        }else if pickerView == PickerView1{
            SelectDecotorTextField.text = DoctorS[row]
            selectDrType = DoctorS[row]
            self.view.endEditing(false)
        }else if pickerView == PickerView2{
            TimeTextField.text = TimeS[row]
            self.view.endEditing(false)
            selectI = TimeS[row]
        }
        
    }

    
    // MARK: - BookAppoinment
    
    @IBAction func BookAppoinment(_ sender: Any) {
        
        if SelectPatientTextField.text != "" && ComplainTextField.text != "" && SelectDecotorTextField.text != "" && DateTextField.text != "" && TimeTextField.text != "" && AddressTextField.text != ""{
            isToEditFlag = "false"
            isForBookFlag = "true"
            appoinmetnFlag = 1
            self.dataSend()
        }else{
            
            let alert = UIAlertController(title: "Oops!", message: "Required field missing", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil )
            
            notification.notificationOccurred(.warning)
        }
    }
    
    
    // MARK: - Add To Cart
    
    @IBAction func AddToCart(_ sender: Any) {
        
        if SelectPatientTextField.text != "" && ComplainTextField.text != "" && SelectDecotorTextField.text != "" && DateTextField.text != "" && TimeTextField.text != "" && AddressTextField.text != ""{
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
        
        if SelectDecotorTextField.text == "Intermediate"{
            selectDrType = "2"
        }else if SelectDecotorTextField.text == "Daily"{
            selectDrType = "3"
        }else if SelectDecotorTextField.text == "Procedure"{
            selectDrType = "6"
        }
        
        
        let userIdDM = "\(RetriveFechData)"
        let appointmentTypeDM = "nurse"
        let patientDM = "1845"//selectedPatientId
        let complainDM = ComplainTextField.text!
        let selectDrDM = selectDrType
        let daysDM = DaysTextField.text!
        let dateDM = "\(UNIXDate)"
        let timeDM = selectI
        let addressDM = AddressTextField.text!
        let isToEditDM = isToEditFlag
        let isForBookDM = isForBookFlag
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "patientId" : patientDM,
                                         "complain" : complainDM,
                                         "typeId" : selectDrDM,
                                         "days" : daysDM,
                                         "date" : dateDM,
                                         "time" : timeDM,
                                         "isToEdit" : isToEditDM,
                                         "isForBook" : isForBookDM,
                                         "appointmentType" : appointmentTypeDM,
                                         "address" : addressDM]
        
        getData(url: Appoinment_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let DoctorJSON : JSON = JSON(respondse.result.value!)
                self.updateDoctorData(json: DoctorJSON)
                
                if self.doctorDataModel.isSuccess == true{
                    
                    if self.appoinmetnFlag == 1{
                        
                        self.SelectPatientTextField.text = ""
                        self.ComplainTextField.text = ""
                        self.SelectDecotorTextField.text = ""
                        self.DateTextField.text = ""
                        self.TimeTextField.text = ""
                        self.AddressTextField.text = ""
                        
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let second = main.instantiateViewController(withIdentifier: "CartVC")
                        self.present(second, animated: true, completion: nil)
                        self.notification.notificationOccurred(.success)
                        
                    }else{
                        
                        let alert = UIAlertController(title: "Successfully Add", message: "\(self.doctorDataModel.message!)", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil )
                        
                        self.SelectPatientTextField.text = ""
                        self.ComplainTextField.text = ""
                        self.SelectDecotorTextField.text = ""
                        self.DateTextField.text = ""
                        self.TimeTextField.text = ""
                        self.AddressTextField.text = ""
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
        doctorDataModel.address = json["address"].stringValue
        doctorDataModel.complain = json["complain"].stringValue
        doctorDataModel.typeId = json["typeId"].stringValue
        doctorDataModel.days = json["days"].stringValue
        doctorDataModel.date = json["date"].stringValue
        doctorDataModel.timeSlot = json["timeSlot"].stringValue
        doctorDataModel.address = json["address"].stringValue
        doctorDataModel.name = json["name"].stringValue
        
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
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        languAdd = userLocation.coordinate.longitude
        latitAdd = userLocation.coordinate.latitude
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
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
