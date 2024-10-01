//
//  EditDates.swift
//  Airbnb
//
//  Created by dennis savchenko on 12/09/2024.
//

import SwiftUI

struct EditDates: View {
    
    @Binding var editDates: Bool
    @Binding var lowerDate: Date
    @Binding var upperDate: Date
    @State var selectedDate: Date? = nil
    
    var numberofNights: Int {
        return Calendar.current.dateComponents([.day], from: lowerDate, to: upperDate).day ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                editDates.toggle()
            } label: {
                Image(systemName: "xmark")
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
            VStack(alignment: .leading) {
                Text("\(numberofNights == 1 ? "1 night" : numberofNights > 1 ? "\(numberofNights) nights" : "Select checkout date")")
                    .font(.title2)
                    .fontWeight(.medium)
                if lowerDate == upperDate {
                    Text("\(lowerDate.formatted(.dateTime.day().month(.abbreviated).year().weekday())) - ")
                        .font(.footnote)
                } else {
                    Text("\(lowerDate.formatted(.dateTime.day().month(.abbreviated).year().weekday())) - \(upperDate.formatted(.dateTime.day().month(.abbreviated).year().weekday()))")
                        .font(.footnote)
                }
                
            }
            .padding()
            .padding(.vertical)
            CustomCalendar(selectedDate: $selectedDate, lowerDate: $lowerDate, upperDate: $upperDate)
        }.ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    EditDates(editDates: .constant(true), lowerDate: .constant(Date.now), upperDate: .constant(Date.now))
}
