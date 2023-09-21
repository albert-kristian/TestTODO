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
            List {
                ForEach(viewModel.data, id: \.id) { item in
                    TodoItem(todoModel: item)
                        .onTapGesture {
                            viewModel.check(id: item.id)
                        }
                }.onDelete(perform: { index in
                    viewModel.deleteAt(at: index)
                })
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity)
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(viewModel: TodoViewModel(dataProvider: DataProviderImpl()))
    }
}
