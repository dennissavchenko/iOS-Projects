//
//  CustomCalendar.swift
//  Airbnb
//
//  Created by dennis savchenko on 12/08/2024.
//

import SwiftUI
import UIKit
import HorizonCalendar

struct CustomCalendar: View {
    
    let startDate = Date.now
    let endDate = Date.distantFuture
    
    @Binding var selectedDate: Date?
    @State private var rangeSelected: Bool = true
     
    @Binding var lowerDate: Date
    @Binding var upperDate: Date
    
    var body: some View {
        CalendarViewRepresentable(
          calendar: Calendar.current,
          visibleDateRange: startDate...endDate,
          monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()),
          dataDependency: nil)
        .days { day in
            let date = Calendar.current.date(from: day.components)!
            Text("\(day.day)")
                .foregroundColor(date < Calendar.current.date(byAdding: .day, value: -1, to: Date.now)! ? .pale : date.formatted(.dateTime.day().month().year()) == lowerDate.formatted(.dateTime.day().month().year()) || date.formatted(.dateTime.day().month().year()) == upperDate.formatted(.dateTime.day().month().year()) ? .bgWhite : .textBlack)
              .fontWeight(.semibold)
              .strikethrough(date < Calendar.current.date(byAdding: .day, value: -1, to: Date.now)!)
              .font(.footnote)
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background {
                RoundedRectangle(cornerRadius: 50)
                      .fill(date.formatted(.dateTime.day().month().year()) == lowerDate.formatted(.dateTime.day().month().year()) || date.formatted(.dateTime.day().month().year()) == upperDate.formatted(.dateTime.day().month().year()) ? .textBlack : .textBlack.opacity(0))
              }
          }
        .onDaySelection { day in
            selectedDate = Calendar.current.date(from: day.components)
            if selectedDate! >= Calendar.current.date(byAdding: .day, value: -1, to: Date.now)! {
                if rangeSelected {
                    lowerDate = selectedDate!
                    upperDate = selectedDate!
                    rangeSelected.toggle()
                }
                else if selectedDate! <= lowerDate {
                    lowerDate = selectedDate!
                    upperDate = selectedDate!
                } else {
                    upperDate = selectedDate!
                    rangeSelected.toggle()
                }
            }
          }
        .dayRanges(for: [lowerDate...upperDate]) { dayRangeLayoutContext in
            DayRangeIndicatorViewRepresentable(
                framesOfDaysToHighlight: dayRangeLayoutContext.daysAndFrames.map { $0.frame })
        }
        .interMonthSpacing(30)
        .verticalDayMargin(8)
        .horizontalDayMargin(8)
        .backgroundColor(.bgWhite)
        .padding([.horizontal, .top])
        .background(.bgWhite)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    
    CustomCalendar(selectedDate: .constant(nil), lowerDate: .constant(Date.now), upperDate: .constant(Calendar.current.date(byAdding: .day, value: 4, to: Date.now)!))
    
}
