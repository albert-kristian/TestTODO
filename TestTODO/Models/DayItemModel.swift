//
//  DayItemModel.swift
//  TestTODO
//
//  Created by Albert Kristian on 17.09.2023.
//

import Foundation
import SwiftUI

struct DayItemModel: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
    var badge: Badge?
}

struct Badge {
    let count: Int
    let color: Color
}
