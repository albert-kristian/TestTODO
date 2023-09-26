//
//  TodoViewModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 03.09.2023.
//

import Foundation

@MainActor class TodoViewModel: ObservableObject {

    private let dataProvider: DataProvider

    var todos: [TodoModel] {
        return dataProvider.todoItems.filter({ item in
            item.dateTime.isSameDay(with: Date())
        })
    }

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }

    func deleteAt(at indexSet: IndexSet) {
        guard let index = indexSet.first else {
            print("Invalid index")
            return
        }

        dataProvider.delete(todo: todos[index])
    }

    func check(id: String) {
        dataProvider.check(id: id)
    }
}
