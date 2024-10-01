//
//  EditGuests.swift
//  Airbnb
//
//  Created by dennis savchenko on 12/09/2024.
//

import SwiftUI

struct EditGuests: View {
    
    @Binding var guests: Guests
    @Binding var editGuests: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            HStack {
                Button {
                    editGuests.toggle()
                } label: {
                    Image(systemName: "xmark")
                }.buttonStyle(PlainButtonStyle())
                Spacer()
                Text("Guests")
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "xmark")
                    .opacity(0)
            }
            .padding([.horizontal, .top])
            .padding(.top)
            Divider()
            VStack(spacing: 24) {
                CustomStepper(text: "Adults", hint: "Ages 13 or above", value: $guests.adults, range: 0...10)
                CustomStepper(text: "Children", hint: "Ages 2-12", value: $guests.children, range: 0...10)
                CustomStepper(text: "Infants", hint: "Under 2", value: $guests.infants, range: 0...10)
                CustomStepper(text: "Pets", value: $guests.pets, range: 0...10)
            }.padding()
            Divider()
            HStack {
                Button {
                    editGuests.toggle()
                } label: {
                    Text("Cancel")
                        .underline()
                        .fontWeight(.medium)
                        .foregroundStyle(.noteGray)
                }
                Spacer()
            }
            .padding()
            .padding(.bottom)
        }
    }
}

#Preview {
    EditGuests(guests: .constant(Guests(adults: 1)), editGuests: .constant(true))
}
