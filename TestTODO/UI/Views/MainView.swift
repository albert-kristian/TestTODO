//
//  MainView.swift
//  TestTODO
//
//  Created by Albert Kristian on 11.09.2023.
//

import SwiftUI

enum CurrentTab {
    case today
    case calendar
}

struct MainView: View {

    @StateObject var dataProvider: DataProvider = DataProvider()
    var calendarViewModel: CalendarViewModel {
        return CalendarViewModel(dataProvider: dataProvider)
    }

    @State var navigationSelection: Int? = 0
    @State var currentTabSelection: CurrentTab = CurrentTab.today

    private var preSelectedDate: Date {
        if currentTabSelection == CurrentTab.today {
            return Date()
        } else {
            return calendarViewModel.selectedDate
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                NavigationLink(
                    destination: AddTodoView(
                        viewModel: AddTodoViewModel(
                            preSelectedDate: preSelectedDate,
                            dataProvider: dataProvider
                        )
                    ),
                    tag: 1,
                    selection: $navigationSelection
                ) {
                    EmptyView()
                }

                TabView(selection: $currentTabSelection) {
                    TodoView(
                        viewModel: TodoViewModel(dataProvider: dataProvider)
                    ).tabItem {
                        Label("Today", systemImage: "calendar.day.timeline.left")
                    }.tag(CurrentTab.today)
                    CalendarView(
                        viewModel: calendarViewModel
                    ).tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }.tag(CurrentTab.calendar)
                }
                AddItemButton(
                    onClick: {
                        navigationSelection = 1
                    }
                )
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
