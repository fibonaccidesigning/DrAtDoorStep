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
    var CartDataDictionary : [NotificationDataModel] = []
    
    //    var selectedProduct : PatientDataModel?
    
    
    // MARK: - URL
    
    let viewCart_URL = "http://dratdoorstep.com/livemob/cart"
    
    
    // MARK: - Variables
    
    var pickData : [Dictionary<String, String>] = []
    
    var selectedItem  = ""
    var selectedPatientId = ""
    
    var RetriveFechData = 0
    
    //MARK: - ViewController
    @IBOutlet var CartTable: UITableView!
    @IBOutlet var MakePayment: UIButton!
    @IBOutlet var AmountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MakePayment.layer.cornerRadius = 0.1 * MakePayment.bounds.size.width
        MakePayment.clipsToBounds = true
        
        CartTable.tableFooterView = UIView()
        
        RetriveFechData = UserDefaults.standard.integer(forKey: "userID")
        print(RetriveFechData)
        
        let userIdDM = "\(RetriveFechData)"
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
            
            CartDataDictionary.append(NotificationDataModel(json: (pro![i].dictionaryObject)!))
            
            self.CartTable.reloadData()
            
        }
        
        if let walletBalance = json["cart"].dictionaryObject!["totalAmount"] as? String
        {
            
            AmountLbl.text = "Total Amount : \(walletBalance)"
            
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
        
        let DateResult = CartDataDictionary[indexPath.item].appointmentDate!
        
        let Sdate = Date(timeIntervalSince1970: TimeInterval(DateResult))
        let SdateFormatter = DateFormatter()
        SdateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        SdateFormatter.locale = NSLocale.current
        SdateFormatter.dateFormat = "dd/mm/yyyy HH:MM aa" //Specify your format that you want
        let SstrDate = SdateFormatter.string(from: Sdate)
        
        print(SstrDate)
        
        cell.DateLbl.text = "\(SstrDate)"
        
        cell.AppoinmentForLbl.text = CartDataDictionary[indexPath.item].bookingtype
        cell.AppoinmentTypeLbl.text = CartDataDictionary[indexPath.item].particular
        
        return cell
    }
    
    
    @IBAction func Back(_ sender: Any) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let second = main.instantiateViewController(withIdentifier: "initController")
        self.present(second, animated: true, completion: nil)
        
        
    }
    
}
