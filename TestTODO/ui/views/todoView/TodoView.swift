//
//  TodoView.swift
//  TestTODO
//
//  Created by Albert Kristian on 30.08.2023.
//

import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel: TodoViewModel = TodoViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dummyData, id: \.id) { item in
                TodoItem(todoModel: item)
            }.onDelete(perform: { index in
                viewModel.delete(at: index)
            })
            .onTapGesture {
                
            }
        }.listStyle(.plain)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}

private struct TodoItemView: View {

    @State private var isCollapsed: Bool = true
    @State private var lineLimit: Int = 1
    
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(title)
            }.frame(maxWidth: .infinity)
            Divider()
            Text(content).onTapGesture {
                isCollapsed = !isCollapsed
                withAnimation {
                    if (isCollapsed) {
                        lineLimit = 1
                    } else {
                        lineLimit = Int.max
                    }
                }
            }.lineLimit(lineLimit).font(.system(size: 28))
        }.frame(maxWidth: .infinity, minHeight: 0)
            .padding(16)
            .background(Color.yellow)
    }
}
