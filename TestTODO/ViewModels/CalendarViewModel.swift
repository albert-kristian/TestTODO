//
//  CalendarViewModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 19.09.2023.
//

import Foundation
import SwiftUI

@MainActor class CalendarViewModel: ObservableObject {
    @Published private(set) var dayModels = [DayItemModel]()
    @Published private(set) var todos = [TodoModel]()

    var selectedDate: Date {
        didSet {
            getTodosForTheSelectedDay()
            objectWillChange.send()
        }
    }

    @Published var selectedMonth = Date()
    @Published var selectedMonthIndex: Int = 0

    private let dataProvider: DataProvider

    var data: [TodoModel] {
        dataProvider.todoItems
    }

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        self.selectedDate = SelectedDayHolder.instance.selectedDay

        updateMonth()
        getTodosForTheSelectedDay()
    }

    private func getTodosForTheSelectedDay() {
        todos = dataProvider.todoItems.filter({ todo in
            todo.dateTime.isSameDay(with: selectedDate)
        })
    }

    private func getCurrentMonth() -> Date {
        let calendar = Calendar.current

        // Getting Current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.selectedMonthIndex, to: Date()) else {
            return Date()
        }

        return currentMonth
    }

    func check(id: String) {
        dataProvider.check(id: id)
        getTodosForTheSelectedDay()
        dayModels = getDates()
    }

    func deleteAt(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            print("Invalid index")
            return
        }

        dataProvider.delete(todo: todos[index])
        getTodosForTheSelectedDay()
    }

    func updateMonth() {
        selectedMonth = getCurrentMonth()
        dayModels = getDates()
    }

    func getDates() -> [DayItemModel] {
        let calendar = Calendar.current

        var days = selectedMonth.getAllDates().compactMap { date -> DayItemModel in
            let day = calendar.component(.day, from: date)

            let badge: Badge?

            let tasks: [TodoModel] = data.filter({ task in task.dateTime.isSameDay(with: date) })
            if !tasks.isEmpty {
                badge = Badge(
                    count: tasks.count,
                    color: tasks.allSatisfy({ task in task.isChecked }) ? Color.green : Color.red
                )
            } else {
                badge = nil
            }

            let dateValue =  DayItemModel(
                day: day,
                date: date,
                badge: badge
            )
            return dateValue
        }

        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())

        for _ in 0..<firstWeekday - 1 {
            days.insert(DayItemModel(day: -1, date: Date()), at: 0)
        }

        return days
    }
}
