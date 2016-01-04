//
//  MyServersMiddleViewController.swift
//  Sirius
//
//  Created by Liu, Naitian on 1/2/16.
//  Copyright © 2016 naitianliu. All rights reserved.
//

import Cocoa

class MSMiddleViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, MSLeftViewControllerDelegate {

    @IBOutlet weak var serverTableView: NSTableView!
    
    var currentProjectUUID = ""
    
    var serverList: [[String: String]] = []
    
    let serverModelHelper = ServerModelHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    override func viewWillAppear() {
        self.view.wantsLayer = true
        let color: CGColorRef = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)
        self.view.layer?.backgroundColor = color
    }
    
    @IBAction func addButtonOnClick(sender: AnyObject) {
        let uuid = serverModelHelper.addNewServer(currentProjectUUID)
        let newServerDict = ["uuid": uuid, "ip": "", "hostname": ""]
        serverList.insert(newServerDict, atIndex: 0)
        serverTableView.reloadData()
        serverTableView.editColumn(0, row: 0, withEvent: nil, select: true)
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return serverList.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let rowDict: [String: String] = serverList[row]
        let identifier:String = tableColumn!.identifier
        let value:String = rowDict[identifier]!
        return value
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let selectedIndex = notification.object!.selectedRow
        print(selectedIndex)
    }
    
    func tableView(tableView: NSTableView, setObjectValue object: AnyObject?, forTableColumn tableColumn: NSTableColumn?, row: Int) {
        var selectedServerDict = serverList[row] 
        let identifier:String = tableColumn!.identifier
        let value = (object as! String)
        serverModelHelper.updateServer(selectedServerDict["uuid"]!, keyPath: identifier, value: value)
        selectedServerDict[identifier] = value
        serverList[row] = selectedServerDict
    }
    
    func projectSelected(projectUUID: String) {
        print(projectUUID)
        currentProjectUUID = projectUUID
        serverList = serverModelHelper.getServersByProject(projectUUID)
        serverTableView.reloadData()
    }
}