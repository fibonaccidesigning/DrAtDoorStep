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
    
    
    
    var notificationId : Int?
    var title : String?
    var description : String?
    var orderNo : String?
    var date : String?
    var userId : Int?
    
    
    init(json: [String : Any?]) {
        
        if let value = json[NotifiIdDM] as? Int {
            self.notificationId = value
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
        if let value = json[DateDM] as? String {
            self.date = value
        }
        if let value = json[UserIdDM] as? Int {
            self.userId = value
        }
        
    }

}
