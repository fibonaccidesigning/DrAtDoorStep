//
//  BookingHistoryViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BookingHistoryViewController: UIViewController {

    
    // MARK: DataModel
    
    let bookingHistoryDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let BookingHistory_URL = "http://dratdoorstep.com/livemob/bookingHistory"
 
    
    //MARK: Variable
    
    var selectedProduct : NotificationDataModel?
    var BookingHistoryDataDictionary : [NotificationDataModel] = []
    
    
    //MARK: - ViewController
    
    @IBOutlet var BookingHistoryTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userIdDM = "5191"
        
        let parms : [String : String] = ["userId" : userIdDM ]
        
        getBookingHistoryData(url: BookingHistory_URL, parameters: parms)

    }
    
    func getBookingHistoryData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let BookingJSON : JSON = JSON(respondse.result.value!)
                self.updateBookingHistoryData(json: BookingJSON)
                
                print(respondse)
            }
            else{
                print("Json Error")
                print(Error.self)
            }
        }
        
    }
    
    func updateBookingHistoryData(json : JSON)  {
        
        let pro = json["bookingHistory"].array
        let range = pro!.count
        
        for i in 0..<range{
            
            BookingHistoryDataDictionary.append(NotificationDataModel(json:(pro![i].dictionaryObject)!))
            
            self.BookingHistoryTableView.reloadData()
            
        }
        
    }
    
    
    // MARK: - BookingHistory Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookingHistoryDataDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookingHistoryTableViewCell
        
        
        cell.OrderLbl.text = BookingHistoryDataDictionary[indexPath.item].orderNo
        cell.TitleLbl.text = BookingHistoryDataDictionary[indexPath.item].title
        cell.DateLbl.text = BookingHistoryDataDictionary[indexPath.item].date
        
        return cell
    }
    

}

