//
//  ServerModel.swift
//  Sirius
//
//  Created by Liu, Naitian on 1/3/16.
//  Copyright © 2016 naitianliu. All rights reserved.
//

import RealmSwift

class ServerModel: Object {
    
    dynamic var uuid = ""
    dynamic var projectUUID = ""
    dynamic var ip = ""
    dynamic var hostname = ""
    dynamic var tag = ""
    dynamic var note = ""
    dynamic var sshProfileUUID = ""
    dynamic var sudoProfileUUID = ""
    
    override static func primaryKey() -> String {
        return "uuid"
    }
    
}

class ServerModelHelper {
    
    let acceptedKeyPathList = ["projectUUID", "ip", "hostname", "tag", "note", "sshProfileUUID", "sudoProfileUUID"]
    
    init() {
        
    }
    
    func addNewServer(projectUUID:String) {
        // initiate a new server object with empty parameters except projectUUID
        let uuid = NSUUID().UUIDString
        let server = ServerModel()
        server.projectUUID = projectUUID
        server.uuid = uuid
        do {
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(server)
            })
        } catch {
            print(error)
        }
    }
    
    func updateServer(uuid:String, keyPath:String, value:String) -> Int {
        var statusCode: Int = 0
        if !acceptedKeyPathList.contains(keyPath) {
            statusCode = 1
        } else {
            do {
                let realm = try Realm()
                let server = realm.objectForPrimaryKey(ServerModel.self, key: uuid)
                try realm.write({ () -> Void in
                    server?.setValue(value, forKeyPath: keyPath)
                })
            } catch {
                print(error)
                statusCode = 2
            }
        }
        return statusCode
    }
    
    func getServersByProject(projctUUID:String) -> [[String:String]] {
        var servers: [[String:String]] = []
        
        return servers
    }
    
    func getServerDetailedInfoByUUID(uuid:String) -> [String: AnyObject] {
        var detailedInfo = Dictionary<String, AnyObject>()
        
        return detailedInfo
    }
    
}