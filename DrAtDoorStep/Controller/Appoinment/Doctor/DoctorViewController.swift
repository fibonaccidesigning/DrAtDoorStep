//
//  DoctorViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DoctorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    // MARK: DataModel
    
    let loginDataModel = DrAtDoorDataModel()
    
    
    // MARK: URL
    
    let Login_URL = "http://dratdoorstep.com/livemob/login"
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let currencySignArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    
    
    //MARK: - ViewController
    
    @IBOutlet var clodse: UIBarButtonItem!
    @IBOutlet var SelectPatientTextField: UITextField!
    @IBOutlet var ComplainTextField: UITextField!
    @IBOutlet var DateTextField: UITextField!
    @IBOutlet var TimeTextField: UITextField!
    @IBOutlet var SelectDecotorTextField: UITextField!
    @IBOutlet var AddressTextField: UITextField!
    @IBOutlet var BookAppoinmentBtn: UIButton!
    @IBOutlet var AddToCartBtn: UIButton!
    @IBOutlet var PickerViewController: UIPickerView!
    @IBOutlet var DONE: UIBarButtonItem!
    @IBOutlet var ViewVC: UIToolbar!
    @IBOutlet var UIViewVC: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewVC.isHidden = true
        PickerViewController.isHidden = true
        UIViewVC.isHidden = true
        
        self.HideKeybord()

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapButton) )
   
        let adButton = UIBarButtonItem(barButtonSystemItem: .action , target: self, action: #selector(tapButton) )
        self.navigationItem.rightBarButtonItems = [addButton,adButton]
        
    
        // MARK: - Rounded Button
        
        BookAppoinmentBtn.layer.cornerRadius = 0.02 * BookAppoinmentBtn.bounds.size.width
        BookAppoinmentBtn.clipsToBounds = true
        
        AddToCartBtn.layer.cornerRadius = 0.02 * AddToCartBtn.bounds.size.width
        AddToCartBtn.clipsToBounds = true
    }

    @objc func tapButton() {
        self.performSegue(withIdentifier: "goToChat", sender: self)
    }

    @IBAction func BookAppoinment(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        
    }
   
    
    @IBAction func AddToCart(_ sender: Any) {
        
        
        
    }
    
    
    //MARK: - PickerView Delegate Method
    
    @IBAction func clos(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return currencySignArray.count
        }else if component == 1{
            return currencyArray.count
        }else{
             return currencyArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return currencySignArray[row]
        }else if component == 1{
            return currencyArray[row]
        }else{
              return currencyArray[row]
        }
    }
    
    
    
}
