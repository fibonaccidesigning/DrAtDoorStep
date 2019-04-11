//
//  WalletViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WalletViewController: UIViewController{

    // MARK: - DataModel
    
    let walletDataModel = DrAtDoorDataModel()
    var WalletDataDictionary : [NotificationDataModel] = []
    
    // MARK: - URL
    
    let wallet_URL = "http://dratdoorstep.com/livemob/wallet"
    
    let notification = UINotificationFeedbackGenerator()
    
    var RetriveFechData = 0
    
    
    
    // MARK: - ViewController
    
    @IBOutlet var BalanceLbl: UILabel!
    @IBOutlet var Recharge: UIButton!
    @IBOutlet var OrderNumber: UILabel!
    @IBOutlet var AmountLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Recharge.layer.cornerRadius = 0.1 * Recharge.bounds.size.width
        Recharge.clipsToBounds = true
        
        
        RetriveFechData = UserDefaults.standard.integer(forKey: "userID")
        print(RetriveFechData)
        
        //let userIdDM = "\(RetriveFechData)"
        
        let userIdDM = "6"
        let deviceTypeDM = "ios"
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "deviceType" : deviceTypeDM  ]
        
        getWalletData(url: wallet_URL, parameters: parms)
        
    }
    
    func getWalletData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let WalletJSON : JSON = JSON(respondse.result.value!)
                self.updateWalletData(json: WalletJSON)
//                self.uiUpdate(json: WalletJSON)
                print(respondse)
       
            }
            else{
                print("Json Error")
                print(Error.self)
            }
        }
        
    }
    
    func updateWalletData(json : JSON)  {
        
        
        let pro = json["wallet"].array
        
        if pro != nil{
            
            let range = pro!.count
            
            for i in 0..<range{
                
                WalletDataDictionary.append(NotificationDataModel(json:(pro![i].dictionaryObject)!))
            
                
            }
            
        }
        
        walletDataModel.orderNumber = json["wallet"]["transactions"][0]["orderNumber"].intValue
        walletDataModel.amount = json["wallet"]["transactions"][0]["amount"].intValue
        walletDataModel.date = json["wallet"]["transactions"][0]["date"].intValue

        OrderNumber.text = "ORDER NO. : \(walletDataModel.orderNumber!)"
        AmountLabel.text = "AMOUNT : \(walletDataModel.amount!)"
        DateLabel.text = ""

        if let walletBalance = json["wallet"].dictionaryObject!["walletBalance"] as? String
        {
            print(walletBalance)
            BalanceLbl.text = walletBalance
      
        }
        
        
        
        var DateResult = "\(walletDataModel.date!)"
            
        
        
        let Sdate = Date(timeIntervalSince1970: TimeInterval(DateResult) as! TimeInterval)
        let SdateFormatter = DateFormatter()
        SdateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        SdateFormatter.locale = NSLocale.current
        SdateFormatter.dateFormat = "dd/mm/yyyy HH:MM aa" //Specify your format that you want
        let SstrDate = SdateFormatter.string(from: Sdate)
        
        print(SstrDate)
        
        
        DateLabel.text = "\(SstrDate)"

        
       
    }
    
    
    // MARK: - Recharge Wallet
    
    @IBAction func RechargeWallet(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Recharge", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Submit", style: .default){
            (action) in
            
            let newItem = textfield.text!
            print(newItem)
            
        }
        let action1 = UIAlertAction(title: "Cancel", style: .default){
            (action1) in
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Amount"
            textfield = alertTextField
     
        }
        
        alert.addAction(action)
        alert.addAction(action1)
        present(alert, animated: true, completion: nil)
        
    }
    
}

