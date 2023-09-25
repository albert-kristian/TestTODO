//
//  TodoViewModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 03.09.2023.
//

import Foundation

@MainActor class TodoViewModel: ObservableObject {
    
    private var dataProvider: DataProvider
    
    var data: [TodoModel] {
        return dataProvider.todoItems
    }
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func deleteAt(at offsets: IndexSet) {
        dataProvider.deleteAt(at: offsets)
    }
    
    func check(id: String) {
        dataProvider.check(id: id)
    }
    
}
