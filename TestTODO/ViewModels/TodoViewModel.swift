//
//  TodoViewModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 03.09.2023.
//

import Foundation

@MainActor class TodoViewModel: ObservableObject {
    @Published var dummyData = [any TodoModel]()

    init() {
        for num in 0...15 {
            dummyData.append(RealmTodoModel(content: "Item number: \(num)"))
        }
    }

    func deleteAt(at offsets: IndexSet) {
        dummyData.remove(atOffsets: offsets)
    }
    func check(id: String) {
        let index = dummyData.firstIndex(where: { $0.id == id })
        dummyData[index!].modify(isChecked: !dummyData[index!].isChecked)
    }

}
