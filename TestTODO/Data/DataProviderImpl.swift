//
//  DataProviderImpl.swift
//  TestTODO
//
//  Created by Albert Kristian on 20.09.2023.
//

import Foundation

class DataProviderImpl: DataProvider {
    
    override init() {
        super.init()
        
        for ind in 1...10 {
            guard let newDate: Date = Calendar.current.date(byAdding: .day, value: ind, to: Date()) else {
                print("Something went wrong")
                return
            }
            
            todoItems.append(RealmTodoModel(content: "\(ind)", dateTime: newDate))
        }
    }
    
    override func check(id: String) {
        guard let index = todoItems.firstIndex(where: { $0.id == id }) else {
            print("Item does not exist")
            return
        }
        todoItems[index].modify(isChecked: !todoItems[index].isChecked)
    }
    
    override func deleteAt(at offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
    }
}
