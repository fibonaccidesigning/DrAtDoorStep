//
//  CartDataModel.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 05/04/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import Foundation

class CartDataModel{
    
    //MARK: - Patient
    
    
    var TypeDM = "type"
    
    
    var TimeDM = "time"
   
   
    //var PatientIdDM = "patientId"
    var WalletBalanceDM = "walletBalance"
    
    
    
    
    var type : String?
 
   
    var time : String?
  
  
  //  var patientId : Int?
    var walletBalance : Float?
    
    
    init(json: [String : Any?]) {
        
        
        if let value = json[TypeDM] as? String {
            self.type = value
        }
       
       
        if let value = json[TimeDM] as? String {
            self.time = value
        }
       
       
//        if let value = json[PatientIdDM] as? Int {
//            self.patientId = value
//        }
        if let value = json[WalletBalanceDM] as? Float {
            self.walletBalance = value
        }
        
    }
    
}
