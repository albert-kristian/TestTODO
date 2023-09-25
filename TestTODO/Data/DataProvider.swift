//
//  DataProvider.swift
//  TestTODO
//
//  Created by Albert Kristian on 20.09.2023.
//

import Foundation

// Base class
class DataProvider: ObservableObject {
    @Published var todoItems: [any TodoModel] = [any TodoModel]()
    
    func check(id: String) {}
    
    func deleteAt(at offsets: IndexSet) {}
}
