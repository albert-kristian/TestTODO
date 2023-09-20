//
//  CalendarViewModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 19.09.2023.
//

import Foundation
import SwiftUI

@MainActor class CalendarViewModel: ObservableObject {
    @Published var dayModels = [DayItemModel]()
    @Published var todos = [any TodoModel]()
    @Published var selectedDate = Date()
    @Published var selectedMonth = Date()
    @Published var selectedMonthIndex: Int = 0
    
    init() {
        updateMonth()
    }
    
    func updateMonth() {
        selectedMonth = getCurrentMonth()
        dayModels = getDates()
    }

    private func getCurrentMonth() -> Date {
        let calendar = Calendar.current

        // Getting Current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.selectedMonthIndex, to: Date()) else {
            return Date()
        }

        return currentMonth
    }

    func getDates() -> [DayItemModel] {
        let calendar = Calendar.current

        var days = selectedMonth.getAllDates().compactMap { date -> DayItemModel in
            let day = calendar.component(.day, from: date)
            
            // FIXME: rework
            let exist = Bool.random()
            let badge: Badge?
            
            if exist {
                badge = Badge(
                    count: Int.random(in: 0...15),
                    color: Bool.random() ? Color.red : Color.green
                )
            } else {
                badge = nil
            }
            // FIXME: rework
            
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
