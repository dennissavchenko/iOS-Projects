//
//  CustomStepper.swift
//  BetterSleep
//
//  Created by dennis savchenko on 29/08/2024.
//

import SwiftUI

struct CustomStepper<T: AdditiveArithmetic & Comparable>: View {
    
    var text: LocalizedStringKey
    @Binding var value: T
    var step: T = 1 as! T
    var range: ClosedRange<T> = 0...10 as! ClosedRange<T>
    var systemImage: String?
    
    var body: some View {
        HStack(spacing: 0) {
            Text(text)
            Spacer()
            Button {
                if range.contains(value - step) {
                    value -= step
                }
            } label: {
                 Image(systemName: "minus")
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                    .padding()
                    .background {
                        Circle()
                            .fill(.thickMaterial)
                            .frame(width: 30, height: 30)
                    }
            }
            if let systemName = systemImage {
                Image(systemName: systemName)
                    .font(.title2)
                    .foregroundStyle(LinearGradient(colors: [.indigo, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 30, height: 30)
                    .symbolEffect(.bounce, options: .speed(2), value: value)
            }
            Button {
                if range.contains(value + step) {
                    value += step
                }
            } label: {
                 Image(systemName: "plus")
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                    .padding()
                    .background {
                        Circle()
                            .fill(.thickMaterial)
                            .frame(width: 30, height: 30)
                    }
            }
        }
    }
}

#Preview {
    CustomStepper(text: "cup", value: .constant(1), systemImage: "hourglass")
}
