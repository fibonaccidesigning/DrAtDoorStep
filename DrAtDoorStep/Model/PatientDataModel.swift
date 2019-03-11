//
//  PatientDataModel.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 08/03/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import Foundation

class PatientDataModel{
    
    //MARK: - Patient
    
    var NameDM = "name"
    var AddressDM = "address"
    var GenderDM = "gender"
    var AreaDM = "area"
    var AgeDM = "age"
    
    
    
    var name : String?
    var address : String?
    var gender : String?
    var area : String?
    var age : String?
    
    
    init(json: [String : Any?]) {
        
        if let value = json[NameDM] as? String {
            self.name = value
        }
        if let value = json[AddressDM] as? String {
            self.address = value
        }
        if let value = json[GenderDM] as? String {
            self.gender = value
        }
        if let value = json[AreaDM] as? String {
            self.area = value
        }
        if let value = json[AgeDM] as? String {
            self.age = value
        }
        
    }
    
}
