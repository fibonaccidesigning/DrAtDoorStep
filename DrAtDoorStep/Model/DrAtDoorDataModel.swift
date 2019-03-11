//
//  DrAtDoorDataModel.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 07/03/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import Foundation
import UIKit

class DrAtDoorDataModel{
    
    
    // MARK: Login
    
    var emailMobile : String?
    var password : String?
    var socialId : String?
    var socialType : String?
    var deviceType : String?
    var message : String?
    var isSuccess : Bool?
    var mobile : String?
    var email : String?
    
    
    //MARK: - Registration
    
    var mobileNumber : Int?
    var referalCode : String?
    var emailAddress : String?
    
    
    //MARK: - Reset Password
    
    var isSkip : Bool?
    var userId : Int?
    
    
    //MARK: - Change Password
    
    var currentPassword : String?
    var newPassword : String?
    
    //MARK: - Add Patient
    
    var isToEdit : Bool?
    var name : String?
    var address : String?
    var area : String?
    var cityId : Int?
    var age : Int?
    var gender : String?

    
    //MARK: - Feedback
    
    var optionId : String?
    var serviceId : String?
    var feedback : String?

}
