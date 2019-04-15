//
//  NotificationDataModel.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 07/03/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import Foundation

class NotificationDataModel{
    
    //MARK: - Notification
    
    var NotifiIdDM = "notificationId"
    var TitleDM = "title"
    var DescriptionDM = "description"
    var OrderDM = "orderNo"
    var DateDM = "date"
    var UserIdDM = "userId"
    var WalletBalanceDM = "walletBalance"
    var CanceledDM = "flagcancel"
    var InvoiceUrlDM = "invoiceUrl"
    var IdDM = "id"
    var orderNumberDM = "orderNumber"
    var AppointmentDateDM = "appointmentDate"
    var PatientNameDM = "patientName"
    var AmountDM = "amount"
    var BookingtypeDM = "bookingtype"
    var ParticularDM = "particular"
    var typeDM = "type"
    var totalAmountDM = "totalAmount"
    var confirmDM = "confirm"
    
    
    var type : String?
    var totalAmount : Int?
    var appointmentDate : Int?
       var patientName : String?
    var notificationId : Int?
     var amount : String?
    var title : String?
      var bookingtype : String?
    var description : String?
      var particular : String?
    var orderNo : String?
    var date : Int?
    var userId : Int?
    var walletBalance : String?
    var flagcancel : String?
    var invoiceUrl : String?
    var id : Int?
    var orderNumber : Int?
    var confirm : Int?
    
    
    init(json: [String : Any?]) {
        
        if let value = json[NotifiIdDM] as? Int {
            self.notificationId = value
        }
        if let value = json[confirmDM] as? Int {
            self.confirm = value
        }
        if let value = json[totalAmountDM] as? Int {
            self.totalAmount = value
        }
        if let value = json[typeDM] as? String {
            self.type = value
        }
        if let value = json[ParticularDM] as? String {
            self.particular = value
        }
        if let value = json[PatientNameDM] as? String {
            self.patientName = value
        }
        if let value = json[BookingtypeDM] as? String {
            self.bookingtype = value
        }
        if let value = json[AmountDM] as? String {
            self.amount = value
        }
        if let value = json[AppointmentDateDM] as? Int {
            self.appointmentDate = value
        }
        if let value = json[TitleDM] as? String {
            self.title = value
        }
        if let value = json[DescriptionDM] as? String {
            self.description = value
        }
        if let value = json[OrderDM] as? String {
            self.orderNo = value
        }
        if let value = json[DateDM] as? Int {
            self.date = value
        }
        if let value = json[UserIdDM] as? Int {
            self.userId = value
        }
        if let value = json[WalletBalanceDM] as? String {
            self.walletBalance = value
        }
        if let value = json[CanceledDM] as? String {
            self.flagcancel = value
        }
        if let value = json[InvoiceUrlDM] as? String {
            self.invoiceUrl = value
        }
        if let value = json[IdDM] as? Int {
            self.id = value
        }
        if let value = json[orderNumberDM] as? Int {
            self.orderNumber = value
        }
    }

}
