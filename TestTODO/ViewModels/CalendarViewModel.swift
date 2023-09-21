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
    
    @Published var selectedDate = Date()
    @Published var selectedMonth = Date()
    @Published var selectedMonthIndex: Int = 0
    
    let dataProvider: DataProvider
    
    var data: [TodoModel] {
        dataProvider.todoItems
    }
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        
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
