//
//  Project-CoreDataHelpers.swift
//  Portfolio
//
//  Created by Rob Copping on 06/01/2021.
//

import Foundation
import SwiftUI

extension Project {
    enum SortOrder {
        case optimised, title, creationDate
    }

    var projectTitle: String {
        title ?? NSLocalizedString("New Project", comment: "Create a new project")
    }

    var projectDetail: String {
        detail ?? ""
    }

    var projectColor: String {
        color ?? "Light Blue"
    }

    var projectItems: [Item] {
        items?.allObjects as? [Item] ?? []
    }

    var projectItemsDefaultSorted: [Item] {
        projectItems.sorted { first, second in
            if first.completed == false {
                if second.completed == true {
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

    var label: LocalizedStringKey {
        // swiftlint:disable:next line_length
        LocalizedStringKey("\(projectTitle), \(projectItems.count) items, \(completionAmount * 100, specifier: "%g")% complete.")
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

    static let colors = ["Pink",
                         "Purple",
                         "Red",
                         "Orange",
                         "Gold",
                         "Green",
                         "Teal",
                         "Light Blue",
                         "Dark Blue",
                         "Midnight",
                         "Dark Gray",
                         "Gray"]

    func projectItems(using sortOrder: Item.SortOrder) -> [Item] {
        switch sortOrder {
        case .title:
            return projectItems.sorted(by: \Item.itemTitle)
        case .creationDate:
            return projectItems.sorted(by: \Item.itemCreationDate)
        case .optimised:
            return projectItemsDefaultSorted
        }
    }
}
