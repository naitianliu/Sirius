//
//  MyServersLeftViewController.swift
//  Sirius
//
//  Created by Liu, Naitian on 1/1/16.
//  Copyright © 2016 naitianliu. All rights reserved.
//

import Cocoa

class MSLeftViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource, NSTextFieldDelegate {
    
    var category1 = MSSidebarCategory(name: "LIBRARY", icon: nil)
    var category2 = MSSidebarCategory(name: "PROJECTS", icon: nil)

    @IBOutlet weak var projOutlineView: NSOutlineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        let color: CGColorRef = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)
        self.view.layer?.backgroundColor = color
        
        let option11 = MSSidebarOption(name: "Inbox", icon: nil, isEditable: false)
        category1.options.append(option11)
        self.loadProjects()
        
        self.projOutlineView.expandItem(nil, expandChildren: true)
    }
    
    func loadProjects() {
        category2.clearAll()
        let projectModelHelper = ProjectModelHelper()
        let projects = projectModelHelper.getProjectList()
        for project in projects {
            let option = MSSidebarOption(name: project["name"]!, icon: nil, isEditable: false)
            category2.options.append(option)
        }
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
        let option = MSSidebarOption(name: "unname project", icon: nil, isEditable: true)
        category2.options.append(option)
        projOutlineView.reloadItem(nil, reloadChildren: true)
        
    }
    
    func addNewProfileOnSelected() {
        print("add new profile")
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        switch item {
        case let category as MSSidebarCategory:
            return (category.options.count > 0) ? true : true
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
                if option.isEditable {
                    textField.editable = true
                    textField.delegate = self
                }
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
    
    override func controlTextDidEndEditing(obj: NSNotification) {
        let textField: NSTextField = obj.object as! NSTextField
        let name = textField.stringValue
        let projectModelHelper = ProjectModelHelper()
        projectModelHelper.addNewProject(name)
        self.loadProjects()
        self.projOutlineView.reloadItem(nil, reloadChildren: true)
        
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
    
    func clearAll() {
        self.options = []
    }
}

class MSSidebarOption: NSObject {
    let name: String
    let icon: NSImage?
    let isEditable: Bool
    
    init(name:String, icon:NSImage?, isEditable:Bool) {
        self.name = name
        self.icon = icon
        self.isEditable = isEditable
    }
}