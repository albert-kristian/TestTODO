//
//  TodoModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 02.09.2023.
//

import Foundation

protocol TodoModel {
    var id: String { get set }
    var content: String { get set }
    var isChecked: Bool { get set }
    var dateTime: Date { get set }
}

extension TodoModel {
    mutating func modify(
        content: String? = nil,
        isChecked: Bool? = nil,
        dateTime: Date? = nil
    ) {
        self.content = content ?? self.content
        self.isChecked = isChecked ?? self.isChecked
        self.dateTime = dateTime ?? self.dateTime
    }
}
