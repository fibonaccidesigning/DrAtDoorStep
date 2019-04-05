//
//  BlogViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import  WebKit

class BlogViewController: UIViewController {

    @IBOutlet var BlogWeb: WKWebView!
    
    let urlMy = URL(string: "http://dratdoorstep.com/livemob/blogs")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = URLRequest(url: urlMy!)
        BlogWeb.load(request)
    }
    


}
