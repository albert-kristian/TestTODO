//
//  TodosListComponent.swift
//  TestTODO
//
//  Created by Albert Kristian on 25.09.2023.
//

import SwiftUI

struct TodosListComponent: View {
    let todos: [TodoModel]
    let onCheck: (String) -> Void
    let onDelete: (IndexSet) -> Void

    var body: some View {
        List {
            ForEach(todos, id: \.id) { item in
                TodoItem(todoModel: item)
                    .onTapGesture {
                        onCheck(item.id)
                    }
            }
            .onDelete(perform: { indexSet in
                onDelete(indexSet)
            })
        }
        .listStyle(.plain)
        .frame(maxWidth: .infinity)
    }
}

struct TodosListComponent_Previews: PreviewProvider {
    static var previews: some View {
        TodosListComponent(
            todos: [RealmTodoModel(content: "0"), RealmTodoModel(content: "1"), RealmTodoModel(content: "2")],
            onCheck: { _ in },
            onDelete: { _ in }
        )
    }
}
