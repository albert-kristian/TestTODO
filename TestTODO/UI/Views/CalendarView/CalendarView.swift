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
            Spacer() // Fixme: remove
            // TODO: Show the list of todos for the selected day
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(
            viewModel: CalendarViewModel(dataProvider: DataProviderImpl())
        )
    }
}
