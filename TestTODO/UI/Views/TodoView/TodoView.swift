//
//  TodoView.swift
//  TestTODO
//
//  Created by Albert Kristian on 30.08.2023.
//

import SwiftUI

struct TodoView: View {
    @ObservedObject var viewModel: TodoViewModel

    var body: some View {
        NavigationView {
            TodosListComponent(
                todos: viewModel.todos,
                onCheck: { id in
                    viewModel.check(id: id)
                },
                onDelete: { indexSet in
                    viewModel.deleteAt(at: indexSet)
                }
            )
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(viewModel: TodoViewModel(dataProvider: DataProvider()))
    }
}
