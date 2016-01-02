//
//  MyServersLeftViewController.swift
//  Sirius
//
//  Created by Liu, Naitian on 1/1/16.
//  Copyright © 2016 naitianliu. All rights reserved.
//

import Cocoa

class MyServersLeftViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource {
    
    let dataExample = ["Proj1", "Proj2", "Proj3"]
    
    var category1 = MSSidebarCategory(name: "LIBRARY", icon: nil)
    var category2 = MSSidebarCategory(name: "PROJECTS", icon: nil)

    @IBOutlet weak var projOutlineView: NSOutlineView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        let color: CGColorRef = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)
        self.view.layer?.backgroundColor = color
        
        let option11 = MSSidebarOption(name: "Inbox", icon: nil)
        let option21 = MSSidebarOption(name: "Proj1", icon: nil)
        let option22 = MSSidebarOption(name: "Proj2", icon: nil)
        let option23 = MSSidebarOption(name: "Proj3", icon: nil)
        
        category1.options.append(option11)
        category2.options.append(option21)
        category2.options.append(option22)
        category2.options.append(option23)
        
        self.projOutlineView.expandItem(nil, expandChildren: true)
    }
    
    @IBAction func addButtonOnClick(sender: AnyObject) {
        let menu: NSMenu = NSMenu()
        let menuItemAddProject = NSMenuItem(title: "Add New Project", action: Selector("addNewProjectOnSelected"), keyEquivalent: "")
        let menuItemAddProfile = NSMenuItem(title: "Add New Profile", action: Selector("addNewProfileOnSelected"), keyEquivalent: "")
        menu.addItem(menuItemAddProject)
        menu.addItem(menuItemAddProfile)
        let button: NSButton = sender as! NSButton
        // NSMenu.popUpContextMenu(menu, withEvent: NSEvent(), forView: button)
        let buttonRect: NSRect = (self.view.window?.convertRectToScreen(button.frame))!
        let location: NSPoint = NSPoint(x: buttonRect.origin.x, y: buttonRect.origin.y - 5)
        menu.popUpMenuPositioningItem(nil, atLocation: location, inView: nil)
    }
    
    func addNewProjectOnSelected() {
        print("add new project")
    }
    
    func addNewProfileOnSelected() {
        print("add new profile")
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        switch item {
        case let category as MSSidebarCategory:
            return (category.options.count > 0) ? true : false
        default:
            return false
        }
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if let item: AnyObject = item {
            switch item {
            case let category as MSSidebarCategory:
                return category.options[index]
            default:
                return self
            }
        } else {
            switch index {
            case 0:
                return category1
            default:
                return category2
            }
        }
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if let item: AnyObject = item {
            switch item {
            case let category as MSSidebarCategory:
                return category.options.count
            default:
                return 0
            }
        } else {
            return 2
        }
    }
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        switch item {
        case let category as MSSidebarCategory:
            let view = outlineView.makeViewWithIdentifier("HeaderCell", owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = category.name
            }
            return view
        case let option as MSSidebarOption:
            let view = outlineView.makeViewWithIdentifier("DataCell", owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = option.name
            }
            return view
        default:
            return nil
        }
    }
    
    func outlineView(outlineView: NSOutlineView, isGroupItem item: AnyObject) -> Bool {
        switch item {
        case _ as MSSidebarCategory:
            return true
        default:
            return false
        }
    }
    
    func outlineView(outlineView: NSOutlineView, shouldSelectItem item: AnyObject) -> Bool {
        switch item {
        case _ as MSSidebarCategory:
            return false
        default:
            return true
        }
    }
    
    func outlineViewSelectionDidChange(notification: NSNotification) {
        let selectedIndex = notification.object?.selectedRow
        let object:AnyObject? = notification.object?.itemAtRow(selectedIndex!)
        if object is MSSidebarOption {
            
        }
    }
    
}

class MSSidebarCategory: NSObject {
    let name: String
    var options: [MSSidebarOption] = []
    let icon: NSImage?
    
    init(name:String, icon: NSImage?) {
        self.name = name
        self.icon = icon
    }
}

class MSSidebarOption: NSObject {
    let name: String
    let icon: NSImage?
    
    init(name:String, icon:NSImage?) {
        self.name = name
        self.icon = icon
    }
}