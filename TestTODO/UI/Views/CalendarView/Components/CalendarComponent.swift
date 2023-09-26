//
//  CalendarComponent.swift
//  TestTODO
//
//  Created by Albert Kristian on 16.09.2023.
//

import SwiftUI

struct CalendarComponent: View {
    @Binding var selectedDate: Date
    @Binding var selectedMonthIndex: Int

    var selectedMonth: Date = Date()
    var dayItems: [DayItemModel]

    let updateMonth: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    Text(selectedMonth.yearString())
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(selectedMonth.monthString())
                        .font(.title.bold())
                }
                Spacer()
                Button {
                    withAnimation {
                        selectedMonthIndex -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2 )
                }
                Button {
                    withAnimation {
                        selectedMonthIndex += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)

            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            let columns = Array(repeating: GridItem(.flexible()), count: 7)

            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(dayItems) { dayItem in
                    let foregroundColor = selectedDate.isSameDay(with: dayItem.date) ? Color.white : Color.black

                    DayComponent(dayItem: dayItem, foregroundColor: foregroundColor)
                        .background(
                            Circle()
                                .fill(Color.blue)
                                .padding(.horizontal, 8)
                                .opacity(selectedDate.isSameDay(with: dayItem.date) ? 1 : 0)
                        )
                        .onTapGesture {
                            selectedDate = dayItem.date
                        }
                }
            }
        }
        .onChange(of: selectedMonthIndex) { _ in
            updateMonth()
        }
    }
}

struct CustomDatePicker_Previews: PreviewProvider {

    struct Wrapper: View {
        @State private var currentDate = Date()
        @State private var currentMonth = 0
        @State private var dayItems = [DayItemModel]()

        var body: some View {
            CalendarComponent(
                selectedDate: $currentDate,
                selectedMonthIndex: $currentMonth,
                dayItems: dayItems,
                updateMonth: {}
            )
        }
    }

    static var previews: some View {
        Wrapper()
    }
}
