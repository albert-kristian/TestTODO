//
//  MainView.swift
//  TestTODO
//
//  Created by Albert Kristian on 11.09.2023.
//

import SwiftUI

struct MainView: View {

    @StateObject var dataProvider: DataProvider = DataProvider()

    @State var selection: Int? = 0

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                NavigationLink(destination: EmptyView(), tag: 1, selection: $selection) {
                    EmptyView()
                }

                TabView {
                    TodoView(
                        viewModel: TodoViewModel(dataProvider: dataProvider)
                    ).tabItem {
                        Label("Today", systemImage: "calendar.day.timeline.left")
                    }
                    CalendarView(
                        viewModel: CalendarViewModel(dataProvider: dataProvider)
                    ).tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                }
                AddItemButton(
                    onClick: {
                        selection = 1
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
