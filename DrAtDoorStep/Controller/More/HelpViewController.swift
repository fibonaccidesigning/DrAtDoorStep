//
//  HelpViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    let urlMy = URL(string: "http://dratdoorstep.com/livemob/help")
    
    @IBOutlet var HelpWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let request = URLRequest(url: urlMy!)
        HelpWebView.load(request)
    }
    
}
