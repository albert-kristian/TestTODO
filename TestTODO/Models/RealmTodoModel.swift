//
//  RealmModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 02.09.2023.
//

import Foundation
import RealmSwift

class RealmTodoModel: Object, TodoModel {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var content: String
    @Persisted var isChecked: Bool
    @Persisted var dateTime: Date

    convenience init(
        id: String = UUID().uuidString,
        content: String,
        isChecked: Bool = false,
        dateTime: Date = Date()
    ) {
        self.init()
        self.id = id
        self.content = content
        self.isChecked = isChecked
        self.dateTime = dateTime
    }
}
