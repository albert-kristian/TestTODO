//
//  DayComponent.swift
//  TestTODO
//
//  Created by Albert Kristian on 20.09.2023.
//

import SwiftUI

struct DayComponent: View {
    let dayItem: DayItemModel
    let foregroundColor: Color

    var body: some View {
        VStack {
            if dayItem.day != -1 {
                ZStack(alignment: .topTrailing) {
                    Text("\(dayItem.day)")
                        .font(.title3.bold())
                        .foregroundColor(foregroundColor)
                        .frame(maxWidth: .infinity)
                    if dayItem.badge != nil {
                        ZStack(alignment: .center) {
                            Circle().fill(dayItem.badge!.color)
                            Text("\(dayItem.badge!.count)")
                                .foregroundColor(Color.white)
                                .font(.caption)
                        }
                        .offset(x: 2, y: -12)
                        .frame(width: 20, height: 20)
                    }
                }
            }
        }
        .padding(.vertical, 9)
        .frame(alignment: .top)
    }
}

struct DayComponent_Previews: PreviewProvider {
    static var previews: some View {
        DayComponent(
            dayItem: DayItemModel(day: 1, date: Date()), foregroundColor: Color.white
        )
    }
}
