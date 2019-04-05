//
//  CaretakerViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CaretakerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    // MARK: DataModel
    
    let doctorDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let Appoinment_URL = "http://dratdoorstep.com/livemob/appointment"
    let Patient_URL = "http://dratdoorstep.com/livemob/viewPatients"
    let Doctor_URL = "http://dratdoorstep.com/livemob/doctorTypes"
    
    // MARK: - Arrays
    
    let TimeS = ["08:00:00","09:00:00","10:00:00","11:00:00","12:00:00","13:00:00","14:00:00","15:00:00","16:00:00","17:00:00","18:00:00","19:00:00","20:00:00"]
    
    let DoctorS = ["HomeCare Attendant","Nursing Care"]
    
    let TimeSlotS = ["Two Hour","Full Day"]
    
    var pickData : [Dictionary<String, String>] = []
    var timePickData : [Dictionary<String, String>] = []
    
    var selectedItem  = ""
    var selectedPatientId = ""
    
    var selectDrType = ""
    
    var selectTime = ""
    var selectI = ""
    
    
    //MARK: - ViewController
    
    @IBOutlet var SelectPatientTextField: UITextField!
    @IBOutlet var ComplainTextField: UITextField!
    @IBOutlet var DateTextField: UITextField!
    @IBOutlet var DaysTextField: UITextField!
    @IBOutlet var SelectType: UITextField!
    @IBOutlet var TimeSlotTextField: UITextField!
    @IBOutlet var TimeTextField: UITextField!
    @IBOutlet var AddressTextField: UITextField!
    
    @IBOutlet var BookAppoinmentBtn: UIButton!
    @IBOutlet var AddToCartBtn: UIButton!
    
    @IBOutlet var PickerViewController: UIPickerView!
    @IBOutlet var PickerView1: UIPickerView!
    @IBOutlet var DatePic: UIDatePicker!
    @IBOutlet var TimeSloatPickVC: UIPickerView!
    @IBOutlet var TimePickVC: UIPickerView!
    
    @IBOutlet var DONE: UIBarButtonItem!
    @IBOutlet var ViewVC: UIToolbar!
    @IBOutlet var UIViewVC: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeybord()
        
        // MARK: - Rounded Button
        
        BookAppoinmentBtn.layer.cornerRadius = 0.02 * BookAppoinmentBtn.bounds.size.width
        BookAppoinmentBtn.clipsToBounds = true
        
        AddToCartBtn.layer.cornerRadius = 0.02 * AddToCartBtn.bounds.size.width
        AddToCartBtn.clipsToBounds = true

        
        // MARK: - Hide Controller
        
        ViewVC.isHidden = true
        UIViewVC.isHidden = true
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = true
        TimeSloatPickVC.isHidden = true
        TimePickVC.isHidden = true
        
    }
    
  
     // MARK: - Select Patient
    
    @IBAction func SelectPatient(_ sender: Any) {
        
        ViewVC.isHidden = false
        UIViewVC.isHidden = false
        
        PickerViewController.isHidden = false
        PickerView1.isHidden = true
        DatePic.isHidden = true
        TimeSloatPickVC.isHidden = true
        TimePickVC.isHidden = true
        
        PatientloadData()
    }
    
    func PatientloadData(){
        
        let userIdDM = "5191"
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
            
            pickData.append(countryyy![i].dictionaryObject as! [String : String])
            
            selectedItem = pickData[i]["name"]!
            selectedPatientId = pickData[i]["patientId"]!

            self.PickerViewController.reloadAllComponents()
            
        }
        
    }
    
    
    // MARK: - Select Doctor Type
    
    @IBAction func SelectType(_ sender: Any) {
        
        ViewVC.isHidden = false
        UIViewVC.isHidden = false
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = false
        DatePic.isHidden = true
        TimeSloatPickVC.isHidden = true
        TimePickVC.isHidden = true
    }
    
    // MARK: - Select Date
    
    @IBAction func DatePic(_ sender: Any) {
        
        UIViewVC.isHidden = false
        ViewVC.isHidden = false
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = true
        DatePic.isHidden = false
        TimeSloatPickVC.isHidden = true
        TimePickVC.isHidden = true
    
        
        DatePic.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/M/yyyy"
        let selectedDate = dateFormatter.string(from: DatePic.date)
        
        DateTextField.text = selectedDate
    }
    
    
    // MARK: - Select TimeSlot
    
    @IBAction func TimeSlotPic(_ sender: Any) {
        
        ViewVC.isHidden = false
        UIViewVC.isHidden = false
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = true
        DatePic.isHidden = true
        TimeSloatPickVC.isHidden = false
        TimePickVC.isHidden = true
    }
    
    
    // MARK: - Select TimeSlot
    
    @IBAction func TimePic(_ sender: Any) {
        
        ViewVC.isHidden = false
        UIViewVC.isHidden = false
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = true
        DatePic.isHidden = true
        TimeSloatPickVC.isHidden = true
        TimePickVC.isHidden = false
    }
    
    
    // MARK: - Done Button
    
    @IBAction func Done(_ sender: Any) {
        
        ViewVC.isHidden = true
        UIViewVC.isHidden = true
        
        PickerViewController.isHidden = true
        PickerView1.isHidden = true
        DatePic.isHidden = true
        TimeSloatPickVC.isHidden = true
        TimePickVC.isHidden = false
    }
    
    
    // MARK: - PickerView Delegate Method
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == PickerViewController {
            return self.pickData.count
        }else if pickerView == PickerView1{
            return DoctorS.count
        }else if pickerView == TimeSloatPickVC{
            return TimeSlotS.count
        }else if pickerView == TimePickVC{
            return TimeS.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == PickerViewController{
            return self.pickData[row]["name"]
        }else if pickerView == PickerView1{
            return DoctorS[row]
        }else if pickerView == TimeSloatPickVC{
            return TimeSlotS[row]
        }else if pickerView == TimePickVC{
            return TimeS[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == PickerViewController{
            SelectPatientTextField.text = selectedItem
            self.view.endEditing(false)
        }else if pickerView == PickerView1{
            SelectType.text = DoctorS[row]
            self.view.endEditing(false)
        }else if pickerView == TimeSloatPickVC{
            TimeSlotTextField.text = TimeSlotS[row]
            self.view.endEditing(false)
        }else if pickerView == TimePickVC{
            TimeTextField.text = TimeS[row]
            self.view.endEditing(false)
            selectI = TimeS[row]
        }
        
    }
    
 
    // MARK: - BookAppoinment
    
    @IBAction func BookAppoinment(_ sender: Any) {
        
        if SelectPatientTextField.text != "" && ComplainTextField.text != "" && SelectType.text != "" && DateTextField.text != "" && DaysTextField.text != "" && AddressTextField.text != ""{
            self.dataSend()
        }else{
            
            let alert = UIAlertController(title: "Oops!", message: "Required field missing", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil )
            
        }
        
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        
        if SelectPatientTextField.text != "" && ComplainTextField.text != "" && SelectType.text != "" && DateTextField.text != "" && DaysTextField.text != "" && AddressTextField.text != ""{
            self.dataSend()
        }else{
            
            let alert = UIAlertController(title: "Oops!", message: "Required field missing", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil )
            
        }

    }
    
    
    // MARK: - SendData
    
    func dataSend() {
        
        if SelectType.text == "HomeCare Attendant"{
            selectDrType = "1"
        }else if SelectType.text == "Nursing Care"{
            selectDrType = "2"
        }
        
        let userIdDM = "5191"
        let appointmentTypeDM = "homecare"
        let patientDM = "1845"//selectedPatientId
        let complainDM = ComplainTextField.text!
        let selectDrDM = selectDrType
        let dateDM = DateTextField.text!
        let addressDM = AddressTextField.text!
        let daysDM = DaysTextField.text!
        let timeSlotDM = TimeSlotTextField.text!
        let timeDM = TimeTextField.text!
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "patientId" : patientDM,
                                         "complain" : complainDM,
                                         "typeId" : selectDrDM,
                                         "date" : dateDM,
                                         "days" : daysDM,
                                         "appointmentType" : appointmentTypeDM,
                                         "address" : addressDM,
                                         "timeSlot" : timeSlotDM,
                                         "time" : timeDM,]
        
        getData(url: Appoinment_URL, parameters: parms)
        
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
                    
                    self.SelectPatientTextField.text = ""
                    self.ComplainTextField.text = ""
                    self.DateTextField.text = ""
                    self.DaysTextField.text = ""
                    self.SelectType.text = ""
                    self.AddressTextField.text = ""
                    self.TimeSlotTextField.text = ""
                    self.TimeTextField.text = ""
                    
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
        doctorDataModel.address = json["address"].stringValue
        doctorDataModel.complain = json["complain"].stringValue
        doctorDataModel.typeId = json["typeId"].stringValue
        doctorDataModel.date = json["date"].stringValue
        doctorDataModel.timeSlot = json["timeSlot"].stringValue
        doctorDataModel.address = json["address"].stringValue
        doctorDataModel.name = json["name"].stringValue
        doctorDataModel.days = json["days"].stringValue
        
        doctorDataModel.isSuccess = json["isSuccess"].boolValue
        doctorDataModel.message = json["message"].stringValue
        
    }
    
}
