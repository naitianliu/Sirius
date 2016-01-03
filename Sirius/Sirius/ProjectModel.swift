//
//  ProjectModel.swift
//  Sirius
//
//  Created by Liu, Naitian on 1/2/16.
//  Copyright © 2016 naitianliu. All rights reserved.
//

import RealmSwift

class ProjectModel: Object {
    
    dynamic var name = ""
    
}

class ProjectModelHelper {
    init() {
        
    }
    
    func addNewProject(name:String) -> Int {
        // if no error, status code = 0. 
        // else if duplicated project name, statusCode = 1, 
        // else if exception, status code = 2
        var statusCode: Int = 0
        let project = ProjectModel()
        project.name = name
        do {
            let realm = try Realm()
            let projects = realm.objects(ProjectModel).filter("name = '\(name)'")
            if projects.count == 0 {
                try realm.write({ () -> Void in
                    realm.add(project)
                    statusCode = 0
                })
            } else {
                statusCode = 1
            }
        } catch {
            print(error)
            statusCode = 2
        }
        return statusCode
    }
    
    func getProjectList() -> [[String:String]] {
        var projectList: [[String: String]] = []
        do {
            let realm = try Realm()
            let projects = realm.objects(ProjectModel)
            for project in projects {
                let projectDict = [
                    "name": project.name
                ]
                projectList.append(projectDict)
            }
        } catch {
            print(error)
        }
        return projectList
    }
}