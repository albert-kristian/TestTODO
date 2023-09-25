//
//  DateExtensions.swift
//  TestTODO
//
//  Created by Albert Kristian on 17.09.2023.
//

import Foundation

extension Date {
    
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        
        // geting start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)
        
        // getting date...
        return range!.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
        
    }
    
    func isSameDay(with secondDate: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: secondDate)
    }
    
    func yearString() -> String {
        return yearMonthString()[0]
    }
    
    func monthString() -> String {
        return yearMonthString()[1]
    }
    
    private func yearMonthString() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.yearMonthFormat()
        
        let date = formatter.string(from: self)
        
        return date.components(separatedBy: " ")
    }
    
    static func yearMonthFormat() -> String {
        return "YYYY MMMM"
    }
}
