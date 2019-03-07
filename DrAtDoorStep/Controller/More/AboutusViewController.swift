//
//  AboutusViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import  WebKit

class AboutusViewController: UIViewController {

    @IBOutlet var AboutWebView: WKWebView!
    
    let urlMy = URL(string: "http://dratdoorstep.com/livemob/about")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let request = URLRequest(url: urlMy!)
        AboutWebView.load(request)
   
    }
}


//UITextField.resignFirstResponder()
