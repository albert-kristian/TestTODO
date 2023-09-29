//
//  AddTodoView.swift
//  TestTODO
//
//  Created by Albert Kristian on 26.09.2023.
//

import SwiftUI

struct AddTodoView: View {
    @ObservedObject var viewModel: AddTodoViewModel

    private var dateComponent: DateComponents {
        var component = DateComponents()
        component.year = 5
        return component
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                VStack(alignment: .center, spacing: 24) {
                    Spacer()
                    DatePicker(
                        selection: $viewModel.selectedDate,
                        in: ...(Calendar.current.date(byAdding: dateComponent, to: Date()) ?? Date()),
                        displayedComponents: .date
                    ) {
                        Text("Select Date")
                    }
                    TextField("Name", text: $viewModel.todoContent)
                    HStack {
                        Text("Is checked")
                        Spacer()
                        CheckBoxComponent(isChecked: viewModel.isChecked)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        viewModel.check()
                    }
                    Spacer()
                    Button(
                        action: {
                            viewModel.save()
                        }, label: {
                            Text("Confirm")
                        }
                    )
                    .buttonStyle(.bordered)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(24)
            .navigationTitle("Add Todo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(
            viewModel: AddTodoViewModel(
                dataProvider: DataProvider(dataService: RealmService())
            )
        )
    }
}