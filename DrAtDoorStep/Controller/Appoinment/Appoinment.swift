//
//  Appoinment.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 29/03/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Appoinment: UIViewController {

    
    // MARK: - DataModel
    
    let apoinmentDataModel = DrAtDoorDataModel()
    
    
    // MARK: - URL
    
    let View_Patient_URL = "http://dratdoorstep.com/livemob/viewPatients"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        let RetriveFechData = UserDefaults.standard.integer(forKey: "userId")
     
        let userIdDM = "\(RetriveFechData)"
        let parms : [String : String] = ["userId" : userIdDM]
        getPatientData(url: View_Patient_URL, parameters: parms)
                                        
    }
    
    
    func getPatientData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let LoginJSON : JSON = JSON(respondse.result.value!)
                self.updateLoginData(json: LoginJSON)
                
                print(respondse)
                
            }
            else{
                print("Error")
            }
        }
        
    }
   
    
    func updateLoginData(json : JSON)  {
        
        apoinmentDataModel.patientId = json["patients"][0]["patientId"].intValue
        
        apoinmentDataModel.message = json["message"].stringValue
        apoinmentDataModel.isSuccess = json["isSuccess"].boolValue
        
        updateUIData()
    
    }
    
    func updateUIData() {
        
        
        let dataPatientId = "\(apoinmentDataModel.patientId!)"
        
        let y =  UserDefaults.standard.set(dataPatientId, forKey: "patientId")
        
        print("----\(y)")
 
        }
        
}

