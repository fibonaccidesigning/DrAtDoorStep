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
    
    var AppointmentDateDM = "appointmentDate"
    var TypeDM = "type"
    var PatientNameDM = "patientName"
    var AmountDM = "amount"
    var TimeDM = "time"
    var BookingtypeDM = "bookingtype"
    var ParticularDM = "particular"
    var PatientIdDM = "patientId"
    var WalletBalanceDM = "walletBalance"
    
    
    
    var appointmentDate : String?
    var type : String?
    var patientName : String?
    var amount : String?
    var time : String?
    var bookingtype : String?
    var particular : String?
    var patientId : String?
    var walletBalance : String?
    
    
    init(json: [String : Any?]) {
        
        if let value = json[AppointmentDateDM] as? String {
            self.appointmentDate = value
        }
        if let value = json[TypeDM] as? String {
            self.type = value
        }
        if let value = json[PatientNameDM] as? String {
            self.patientName = value
        }
        if let value = json[AmountDM] as? String {
            self.amount = value
        }
        if let value = json[TimeDM] as? String {
            self.time = value
        }
        if let value = json[BookingtypeDM] as? String {
            self.bookingtype = value
        }
        if let value = json[ParticularDM] as? String {
            self.particular = value
        }
        if let value = json[PatientIdDM] as? String {
            self.patientId = value
        }
        if let value = json[WalletBalanceDM] as? String {
            self.walletBalance = value
        }
        
    }
    
}
