//
//  MyServersConfigurationViewController.swift
//  Sirius
//
//  Created by Liu, Naitian on 1/3/16.
//  Copyright © 2016 naitianliu. All rights reserved.
//

import Cocoa

class MSConfigurationViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.view.wantsLayer = true
        let color: CGColorRef = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)
        self.view.layer?.backgroundColor = color
    }
    
}
