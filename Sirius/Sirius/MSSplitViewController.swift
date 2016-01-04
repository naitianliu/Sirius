//
//  MyServersSplitViewController.swift
//  Sirius
//
//  Created by Liu, Naitian on 1/1/16.
//  Copyright © 2016 naitianliu. All rights reserved.
//

import Cocoa

class MSSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    override func viewWillAppear() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let msLeftVC = storyboard.instantiateControllerWithIdentifier("MSLeftViewController") as! MSLeftViewController
        let msMiddleVC = storyboard.instantiateControllerWithIdentifier("MSMiddleViewController") as! MSMiddleViewController
        let msRightTabVC = storyboard.instantiateControllerWithIdentifier("MSRightTabViewController") as! MSRightTabViewController
        msLeftVC.delegate = msMiddleVC
        self.childViewControllers = [msLeftVC, msMiddleVC, msRightTabVC]
    }
    
}
