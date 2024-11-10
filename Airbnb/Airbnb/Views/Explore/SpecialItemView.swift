//
//  SpecialItemView.swift
//  Airbnb
//
//  Created by dennis savchenko on 10/08/2024.
//

import SwiftUI

struct SpecialItemView: View {
    var name: String
    @Binding var selectedSpecial: String?
    var body: some View {
        Text(name)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.top, 0)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            .foregroundStyle(name == selectedSpecial ? .textBlack : .noteGray)
            .overlay(alignment: .bottom) {
                if name == selectedSpecial {
                    Rectangle()
                        .clipShape(Capsule())
                        .padding(.horizontal, 20)
                        .frame(height: 2)
                        .foregroundStyle(.textBlack)
                        .scaleEffect(1)
                        .transition(.scale)
                        .animation(.easeInOut(duration: 0.3), value: selectedSpecial)

                }
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    selectedSpecial = name
                }
            }
    }
}

#Preview {
    SpecialItemView(name: "Lakefront", selectedSpecial: .constant("Lakefront"))
}
