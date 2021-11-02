//
//  Project-CoreDataHelpers.swift
//  Portfolio
//
//  Created by Rob Copping on 06/01/2021.
//

import Foundation

extension Project{
    var projectTitle: String{
        title ?? "New Project"
    }
    
    var projectDetail: String{
        detail ?? ""
    }
    
    var projectColor: String{
        color ?? "Light Blue"
    }
    
    var projectItems: [Item] {
        items?.allObjects as? [Item] ?? []
    }
    
    var projectItemsDefaultSorted: [Item] {
        
        projectItems.sorted { first, second in
            if first.completed == false {
                if second.completed == true{
                    return true
                } else if first.completed == false {
                    if second.completed == true {
                        return false
                    }
                }
                
                if first.priority > second.priority {
                    return true
                } else if first.priority < second.priority {
                    return false
                }
            
            }
            return first.itemCreationDate < second.itemCreationDate
        }
    }
    
    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }
        
        let completedItems = originalItems.filter(\.completed)
        return Double(completedItems.count) / Double(originalItems.count)
    }
    
    static var example: Project {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let project = Project(context: viewContext)
        project.title = "Example Project"
        project.detail = "This is an example project"
        project.creationDate = Date()
        project.closed = true
        
        return project
    }
    
    static let colors = ["Pink", "Purple", "Red", "Orange", "Gold", "Green", "Teal", "Light Blue", "Dark Blue", "Midnight", "Dark Gray", "Gray"]
}
