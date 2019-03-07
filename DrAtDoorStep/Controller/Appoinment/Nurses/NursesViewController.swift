//
//  NursesViewController.swift
//  DrAtDoorStep
//
//  Created by Parth Mandaviya on 27/02/19.
//  Copyright © 2019 Parth Mandaviya. All rights reserved.
//

import UIKit

class NursesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeybord()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapButton) )
        
        let adButton = UIBarButtonItem(barButtonSystemItem: .action , target: self, action: #selector(tapButton) )
        self.navigationItem.rightBarButtonItems = [addButton,adButton]
    }
    
    @objc func tapButton() {
        
    }


}
