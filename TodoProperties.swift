//
//  Todo+CoreDataProperties.swift
//  TestTODO
//
//  Created by Albert Kristian on 25.09.2023.
//
//

import Foundation
import CoreData

extension Todo: TodoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var id: String
    @NSManaged public var content: String
    @NSManaged public var isChecked: Bool
    @NSManaged public var dateTime: Date

}

extension Todo: Identifiable { }
