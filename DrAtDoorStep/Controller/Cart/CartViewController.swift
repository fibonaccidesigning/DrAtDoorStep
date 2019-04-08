//
//  CartViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    // MARK: - DataModel
    
    let cartDataModel = DrAtDoorDataModel()
    var CartDataDictionary : [CartDataModel] = []
    
    //    var selectedProduct : PatientDataModel?
    
    
    // MARK: - URL
    
    let viewCart_URL = "http://dratdoorstep.com/livemob/cart"
    
    
     // MARK: - Variables
    
    var pickData : [Dictionary<String, String>] = []
   
    var selectedItem  = ""
    var selectedPatientId = ""
    
    //MARK: - ViewController

    @IBOutlet var CartTable: UITableView!
    @IBOutlet var MakePayment: UIButton!
    @IBOutlet var AmountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MakePayment.layer.cornerRadius = 0.1 * MakePayment.bounds.size.width
        MakePayment.clipsToBounds = true
        
        CartTable.tableFooterView = UIView()
        
        let userIdDM = "6"
        let deviceTypeDM = "ios"
        
        let parms : [String : String] = ["userId" : userIdDM,
                                         "deviceType" : deviceTypeDM]
        
        getData(url: viewCart_URL, parameters: parms)
       
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let CartJSON : JSON = JSON(respondse.result.value!)
                self.updateLoginData(json: CartJSON)
                
                print(respondse)
            
            }
            else{
                print("Error")
            }
        }
        
    }
    func updateLoginData(json : JSON)  {
        
        let pro = json["cart"]["cartBookings"].array
        let range = pro!.count
        
        for i in 0..<range{
            
            CartDataDictionary.append(CartDataModel(json: (pro![i].dictionaryObject)!))
            
            self.CartTable.reloadData()
        
        }
 
    }
    
    
    // MARK: - Cart Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartDataDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTableViewCell
        
        cell.NameLbl.text = CartDataDictionary[indexPath.item].patientName
        cell.PriceLbl.text = CartDataDictionary[indexPath.item].amount
        cell.DateLbl.text = CartDataDictionary[indexPath.item].appointmentDate
        cell.AppoinmentForLbl.text = CartDataDictionary[indexPath.item].bookingtype
        cell.AppoinmentTypeLbl.text = CartDataDictionary[indexPath.item].particular
        
        print(CartDataDictionary[indexPath.item].appointmentDate)
    
        //AmountLbl.text = CartDataDictionary[indexPath.item].walletBalance

        
        return cell
    }
    


}
