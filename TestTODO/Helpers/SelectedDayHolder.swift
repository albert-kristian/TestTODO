//
//  SelectedDayHolder.swift
//  TestTODO
//
//  Created by Albert Kristian on 30.09.2023.
//

import Foundation

class SelectedDayHolder {
    static let instance = SelectedDayHolder()

    private(set) var selectedDay: Date = Date()

    func updateSelectedDay(to newDate: Date) {
        selectedDay = newDate
    }
}
