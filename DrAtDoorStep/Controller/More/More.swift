//
//  More.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import Foundation
import UIKit

class More: UITableViewController {
    
    
    
    @IBOutlet var NotificationBtn: UISwitch!
    @IBOutlet var NotificationSoundBtn: UISwitch!
    @IBOutlet var SettingTbl: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        if NotificationBtn.isOn != true{
            NotificationSoundBtn.isOn = false
            
        }
 
    }
    

    @IBAction func NotificationBtnAction(_ sender: Any) {
        
        if NotificationBtn.isOn != true{
            NotificationSoundBtn.isOn = false
            NotificationSoundBtn.isEnabled = false
     
        }else{
             NotificationSoundBtn.isOn = true
            NotificationSoundBtn.isEnabled = true
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        func signOut()  {
////
////            if [indexPath.section][indexPath.item] == 4{
////                let main = UIStoryboard(name: "Main", bundle: nil)
////                let second = main.instantiateViewController(withIdentifier: "LoginVC")
////                self.present(second, animated: true, completion: nil)
////            }
////            else{
////
////            }
//        }
//
//       do {
//        signOut()
//       } catch  {
//            print("------Error")
//        }
//
//
//
//    }
    
}
}

