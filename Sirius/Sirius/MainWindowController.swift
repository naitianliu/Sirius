//
//  MainWindowController.swift
//  Sirius
//
//  Created by Liu, Naitian on 1/4/16.
//  Copyright © 2016 naitianliu. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    let profilesStoryboard = NSStoryboard(name: "Profiles", bundle: nil)
    var msSplitViewController: MSSplitViewController!
    var profilesTabViewController: ProfilesTabViewController!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        profilesTabViewController = profilesStoryboard.instantiateControllerWithIdentifier("ProfilesTabViewController") as! ProfilesTabViewController
        msSplitViewController = self.storyboard?.instantiateControllerWithIdentifier("MSSplitViewController") as! MSSplitViewController
        
    }
    
    @IBAction func MyServersToolbarItemOnClick(sender: AnyObject) {
        self.window?.contentViewController = msSplitViewController
    }
    
    @IBAction func ScriptHubToolbarItemOnClick(sender: AnyObject) {
        
    }

    @IBAction func profilesToolbarItemOnClick(sender: AnyObject) {
        self.window?.contentViewController = profilesTabViewController
    }
}
