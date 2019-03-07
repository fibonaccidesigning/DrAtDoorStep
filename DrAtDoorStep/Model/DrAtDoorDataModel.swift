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
    
    
    
}
