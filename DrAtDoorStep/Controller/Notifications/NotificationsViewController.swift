//
//  NotificationsViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 07/03/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    // MARK: DataModel
    
    let notificationDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let Notification_URL = "http://dratdoorstep.com/livemob/notifications"
    let NotificationClearAll_URL = "http://dratdoorstep.com/livemob/deleteNotificationAll"
    
    
    //MARK: Variable
    
    var selectedProduct : NotificationDataModel?
    var NotificationDataDictionary : [NotificationDataModel] = []
    
    
    //MARK: - ViewController
    
    @IBOutlet var NotificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userIdDM = "100"
        
        let parms : [String : String] = ["userId" : userIdDM ]
        
        getNotificationData(url: Notification_URL, parameters: parms)

    }
    
    func getNotificationData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let CustomerJSON : JSON = JSON(respondse.result.value!)
                self.updateNotificationData(json: CustomerJSON)
                
                print(respondse)
            }
            else{
                print("Json Error")
                print(Error.self)
            }
        }
        
    }
    
    func updateNotificationData(json : JSON)  {
        
        let pro = json["notifications"].array
        let range = pro!.count
        
        for i in 0..<range{
            
            NotificationDataDictionary.append(NotificationDataModel(json: (pro![i].dictionaryObject)!))
            
            self.NotificationTableView.reloadData()
            
        }
        
    }
    
    
    // MARK: - Notification Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationDataDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationTableViewCell
        
        
        cell.DateTextField.text = NotificationDataDictionary[indexPath.item].date
        cell.TitleTextField.text = NotificationDataDictionary[indexPath.item].title
        cell.DescriptionTextField.text = NotificationDataDictionary[indexPath.item].description
        
        return cell
    }
    
    
    // MARK: - Clear All Notification
    
    @IBAction func ClearAll(_ sender: Any) {
        
        let emailDM = "99"
        let passwordDM = ""
        
        let parms : [String : String] = ["userId" : emailDM,
                                         "deviceType" : passwordDM]
        
        getData(url: NotificationClearAll_URL, parameters: parms)
        
    }
    
    func getData(url : String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .post, parameters : parameters).responseJSON {
            respondse in
            if respondse.result.isSuccess {
                
                let LoginJSON : JSON = JSON(respondse.result.value!)
                self.updateLoginData(json: LoginJSON)
                self.NotificationTableView.reloadData()
                print(respondse)
            }
            else{
                print("Error")
            }
        }
        
    }
    
    func updateLoginData(json : JSON)  {
        
        notificationDataModel.message = json["message"].stringValue
        notificationDataModel.isSuccess = json["isSuccess"].boolValue
        
    }
    @IBAction func Back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
