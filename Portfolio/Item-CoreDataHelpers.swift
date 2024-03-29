//
//  Item-CoreDataHelpers.swift
//  Portfolio
//
//  Created by Rob Copping on 06/01/2021.
//

import Foundation

extension Item {
    enum SortOrder {
        case optimised, title, creationDate
    }

    var itemTitle: String {
        title ?? NSLocalizedString("New Item", comment: "Create a new item")
    }

    var itemDetail: String {
        detail ?? ""
    }

    var itemCreationDate: Date {
        creationDate ?? Date()
    }

    static var example: Item {
        let controller = DataController(inMemory: true)

        let viewContext = controller.container.viewContext
        let item = Item(context: viewContext)
        item.title = "Example Title"
        item.detail = "This is an example item"
        item.priority = 3
        item.creationDate = Date()
        return item
    }
}
