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

class WalletViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - DataModel
    
    let walletDataModel = DrAtDoorDataModel()
     var WalletDataDictionary : [NotificationDataModel] = []
    
    // MARK: - URL
    
    let wallet_URL = "http://dratdoorstep.com/livemob/wallet"
    
    
    // MARK: - ViewController
    
    @IBOutlet var WalletTableView: UITableView!
    @IBOutlet var BalanceLbl: UILabel!
    @IBOutlet var Recharge: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Recharge.layer.cornerRadius = 0.1 * Recharge.bounds.size.width
        Recharge.clipsToBounds = true
        
        WalletTableView.tableFooterView = UIView()
        
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
                print(respondse)
                
                
   
            }
            else{
                print("Json Error")
                print(Error.self)
            }
        }
        
    }
    
    func updateWalletData(json : JSON)  {
        
        let pro = json["wallet"]["transactions"].array
        
        if pro != nil{
            
            let range = pro!.count
            
            for i in 0..<range{
                
                WalletDataDictionary.append(NotificationDataModel(json: (pro![i].dictionaryObject)!))
                
                self.WalletTableView.reloadData()
                
                
                
            }
        }else{
            
        }
 
    }
    
    // MARK: - Wallet Table

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WalletDataDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WalletTableViewCell
        
        
        cell.OrderNoLbl.text = WalletDataDictionary[indexPath.row].orderNo
        cell.BalanceLbl.text = WalletDataDictionary[indexPath.row].walletBalance
        cell.DateLbl.text = WalletDataDictionary[indexPath.row].date
        
        print(WalletDataDictionary[indexPath.row].walletBalance as Any)
        
        
        return cell
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
