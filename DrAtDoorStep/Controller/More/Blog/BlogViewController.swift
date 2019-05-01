//
//  BlogViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit
import WebKit
import Foundation

class BlogViewController: UIViewController {

    @IBOutlet var BlogWeb: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlMy = URL(string: "http://www.google.com")

        let request = URLRequest(url: urlMy!)

        BlogWeb.load(request)

    }
    


}
