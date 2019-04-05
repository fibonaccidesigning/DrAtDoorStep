//
//  TermsConditionViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import WebKit

class TermsConditionViewController: UIViewController {

  
    @IBOutlet var tcWebView: WKWebView!
    
    let urlMy = URL(string: "http://dratdoorstep.com/livemob/termsConditions")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let request = URLRequest(url: urlMy!)
            tcWebView.load(request)
        
        }
        
}
