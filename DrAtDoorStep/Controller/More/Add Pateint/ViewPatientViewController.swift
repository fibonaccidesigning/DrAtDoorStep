//
//  ViewPatientViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewPatientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    // MARK: DataModel
    
    let loginDataModel = DrAtDoorDataModel()
    var PatientDataDictionary : [PatientDataModel] = []
    
    var RetriveFechData = 0
    
    let notification = UINotificationFeedbackGenerator()
    
    
    // MARK: URL
    
    let viewPatients_URL = "http://dratdoorstep.com/livemob/viewPatients"
    
    //MARK: - ViewController
    
    @IBOutlet var PatientTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PatientTableView.tableFooterView = UIView()
        
        
        //MARK: - UserDefult
        
        RetriveFechData = UserDefaults.standard.integer(forKey: "userID")
        print(RetriveFechData)
        
        let userIdDM = "\(RetriveFechData)"
        let deviceTypeDM = "ios"
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "deviceType" : deviceTypeDM]
        
        getData(url: viewPatients_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                let LoginJSON : JSON = JSON(respondse.result.value!)
                self.updateLoginData(json: LoginJSON)
            
            }
            else{
                print("Error")
            }
        }
        
    }
    
    func updateLoginData(json : JSON)  {
    
        let pro = json["patients"].array
        
        if pro == nil{
            
            let alert = UIAlertController(title: "Error", message: "No Data Found", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Done", style: .default, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil )
            
            self.notification.notificationOccurred(.warning)
            
        }else{
            
            let range = pro!.count
            
            for i in 0..<range{
                
                PatientDataDictionary.append(PatientDataModel(json: (pro![i].dictionaryObject)!))
                
                self.PatientTableView.reloadData()
                
            }

        }

    }
    
    
    // MARK: - Patient Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PatientDataDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewPatientTableViewCell
        
        cell.NameLbl.text = PatientDataDictionary[indexPath.item].name
        //cell.GenderLbl.text = PatientDataDictionary[indexPath.item].gender
        
        if PatientDataDictionary[indexPath.row].gender == "M"{
            cell.GenderLbl.text = "Male"
        }else{
            cell.GenderLbl.text = "Female"
        }
        
        cell.AgeLbl.text = PatientDataDictionary[indexPath.item].age
      
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            PatientDataDictionary.remove(at: indexPath.row)
            //            NotificationTableView.deleteRows(at: [indexPath], with: .fade)
            PatientTableView.reloadData()
            
            //            print("-------\(t)")
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
