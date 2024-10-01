//
//  CustomDatePicker.swift
//  BetterSleep
//
//  Created by dennis savchenko on 29/08/2024.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var selectedDate: Date
    @State private var isPickerVisible = false

    var body: some View {
        if isPickerVisible {
            HStack {
                Spacer()
                DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .onTapGesture {
                        withAnimation {
                            isPickerVisible.toggle()
                        }
                    }
                Spacer()
            }
        } else {
            Button {
                withAnimation {
                    isPickerVisible.toggle()
                }
            } label: {
                HStack {
                    Text("\(selectedDate, style: .time)")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "clock")
                        .foregroundColor(.white)
                }
                .padding()
                .background(LinearGradient(colors: [.indigo, .orange], startPoint: .topLeading, endPoint: .bottomTrailing).opacity(isPickerVisible ? 0 : 1))
                .cornerRadius(8)
            }
        }
    }
}


#Preview {
    CustomDatePicker(selectedDate: .constant(Date()))
}
