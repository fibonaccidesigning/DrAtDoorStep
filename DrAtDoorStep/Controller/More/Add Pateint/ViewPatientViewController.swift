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
    
    //    var selectedProduct : PatientDataModel?
    
    
    // MARK: URL
    
    let viewPatients_URL = "http://dratdoorstep.com/livemob/viewPatients"
    
    //MARK: - ViewController
    
    @IBOutlet var PatientTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PatientTableView.tableFooterView = UIView()
        
        let userIdDM = "5191"
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
        let range = pro!.count
        
        for i in 0..<range{
            
            PatientDataDictionary.append(PatientDataModel(json: (pro![i].dictionaryObject)!))
            
            self.PatientTableView.reloadData()
            
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
    
}
