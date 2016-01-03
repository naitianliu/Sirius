//
//  MyServersMiddleViewController.swift
//  Sirius
//
//  Created by Liu, Naitian on 1/2/16.
//  Copyright © 2016 naitianliu. All rights reserved.
//

import Cocoa

class MSMiddleViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var serverTableView: NSTableView!
    
    let sampleData = [
        ["ip": "10.1.2.3", "hostname": "test1.knockfuture.com"],
        ["ip": "10.1.2.4", "hostname": "test2.knockfuture.com"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.view.wantsLayer = true
        let color: CGColorRef = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)
        self.view.layer?.backgroundColor = color
        
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return sampleData.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let rowDict: [String: String] = self.sampleData[row]
        let identifier:String = tableColumn!.identifier
        let value:String = rowDict[identifier]!
        return value
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let selectedIndex = notification.object!.selectedRow
        print(selectedIndex)
    }
    
}