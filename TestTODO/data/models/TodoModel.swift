//
//  TodoModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 02.09.2023.
//

import Foundation

protocol TodoModel: Identifiable {
    var id: String { get set }
    var content: String { get set }
    var isChecked: Bool { get set }
    var dateTime: Date { get set }
}
