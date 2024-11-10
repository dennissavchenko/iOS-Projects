//
//  CustomStepper.swift
//  Airbnb
//
//  Created by dennis savchenko on 10/09/2024.
//

import SwiftUI

struct CustomStepper<T: AdditiveArithmetic & Comparable>: View {
    
    var text: LocalizedStringKey
    var hint: LocalizedStringKey?
    @Binding var value: T
    var step: T = 1 as! T
    var range: ClosedRange<T> = 0...10 as! ClosedRange<T>
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading) {
                Text(text)
                if let hint = hint {
                    Text(hint)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
            Button {
                if range.contains(value - step) {
                    value -= step
                }
            } label: {
                Image(systemName: "minus")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding()
                    .background {
                        Circle()
                            .stroke(lineWidth: 0.5)
                            .frame(width: 30, height: 30)
                    }
                    .opacity(value == range.lowerBound ? 0.4 : 1)
                    
            }
            .frame(width: 30, height: 30)
            .disabled(value == range.lowerBound)
            
            Text("\(value)")
                .frame(width: 24, height: 24)
            
            Button {
                if range.contains(value + step) {
                    value += step
                }
            } label: {
                Image(systemName: "plus")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding()
                    .background {
                        Circle()
                            .stroke(lineWidth: 0.5)
                            .frame(width: 30, height: 30)
                    }
                    .opacity(value == range.upperBound ? 0.4 : 1)
            }
            .frame(width: 30, height: 30)
            .disabled(value == range.upperBound)
        }
    }
}

#Preview {
    CustomStepper(text: "Adults", hint: "Ages 13 and above", value: .constant(0))
}
