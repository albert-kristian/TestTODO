//
//  CalendarView.swift
//  TestTODO
//
//  Created by Albert Kristian on 16.09.2023.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel

    var body: some View {
        NavigationView {
            VStack {
                CalendarComponent(
                    selectedDate: $viewModel.selectedDate,
                    selectedMonthIndex: $viewModel.selectedMonthIndex,
                    selectedMonth: viewModel.selectedMonth,
                    dayItems: viewModel.dayModels,
                    updateMonth: {
                        viewModel.updateMonth()
                    }
                )
                Divider()
                TodosListComponent(
                    todos: viewModel.todos,
                    onCheck: { id in
                        viewModel.check(id: id)
                    },
                    onDelete: { indexSet in
                        viewModel.deleteAt(indexSet: indexSet)
                    }
                )
            }
            .padding()
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(
            viewModel: CalendarViewModel(dataProvider: DataProvider())
        )
    }
}
