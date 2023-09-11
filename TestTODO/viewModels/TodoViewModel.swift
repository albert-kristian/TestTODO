//
//  TodoViewModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 03.09.2023.
//

import Foundation

extension TodoView {
    @MainActor class TodoViewModel: ObservableObject {
        @Published var dummyData: [any TodoModel] = Array()
        
        init() {
            for i in 0...15 {
                dummyData.append(RealmTodoModel(content: "Item number: \(i)"))
            }
        }
        
        func delete(at offsets: IndexSet) {
            dummyData.remove(atOffsets: offsets)
        }
    }
}
