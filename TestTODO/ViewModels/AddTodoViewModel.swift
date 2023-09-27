//
//  AddTodoViewModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 26.09.2023.
//

import Foundation

class AddTodoViewModel: ObservableObject {
    @Published var selectedDate: Date
    @Published var todoContent: String = String()
    @Published var isChecked: Bool = false

    private let dataProvider: DataProvider

    init(preSelectedDate: Date, dataProvider: DataProvider) {
        selectedDate = preSelectedDate
        self.dataProvider = dataProvider
    }

    func save() {
        // Creating RealmTodoModel type, because it doesn't really matter what's the type
        // passed to DataProvider, as it will cast it if it's needed
        if (todoContent.isEmpty) {
            return
        }
        let todo = RealmTodoModel(content: todoContent, isChecked: isChecked, dateTime: selectedDate)
        dataProvider.add(todo: todo)
    }
}
