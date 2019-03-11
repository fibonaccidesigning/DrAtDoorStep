//
//  FeedbackDataModel.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 11/03/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import Foundation

class FeedbackDataModel{
    
    //MARK: - Patient
    
    var optionIdDM = "optionId"
    var serviceIdDM = "serviceId"
    var feedbackDM = "feedback"

    
    
    
    var optionId : String?
    var serviceId : String?
    var feedback : String?
  
    
    
    init(json: [String : Any?]) {
        
        if let value = json[optionIdDM] as? String {
            self.optionId = value
        }
        if let value = json[serviceIdDM] as? String {
            self.serviceId = value
        }
        if let value = json[feedbackDM] as? String {
            self.feedback = value
        }
        
    }
    
}
