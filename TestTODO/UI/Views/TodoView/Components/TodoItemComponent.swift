//
//  TodoItem.swift
//  TestTODO
//
//  Created by Albert Kristian on 11.09.2023.
//

import SwiftUI

struct TodoItem: View {
    let todoModel: TodoModel

    var body: some View {
        HStack {
            Text(todoModel.content)
            Spacer()
            CheckBoxComponent(isChecked: todoModel.isChecked)
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 24)
    }
}

struct TodoItem_Previews: PreviewProvider {
    struct TodoPreviewHolder: View {
        @State var todoModel = RealmTodoModel(value: "Test")

        var body: some View {
            TodoItem(todoModel: todoModel)
        }
    }

    static var previews: some View {
        TodoPreviewHolder()
    }
}
