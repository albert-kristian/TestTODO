//
//  RealmModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 02.09.2023.
//

import Foundation

struct RealmTodoModel: TodoModel {
    var id: String = UUID().uuidString
    var content: String
    var isChecked: Bool = false
    var dateTime: Date = Date()
}
