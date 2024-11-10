//
//  SearchAndFilterBar.swift
//  Airbnb
//
//  Created by dennis savchenko on 10/08/2024.
//

import SwiftUI
import HorizonCalendar
import UIKit

struct SearchAndFilterBar: View {
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .fontWeight(.semibold)
                .font(.title3)
                .padding(.horizontal, 5)
            VStack(alignment: .leading, spacing: 2) {
                Text("Where to?")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Text("Anywhere ⋅ Any week ⋅ Add guests")
                    .foregroundStyle(.noteGray)
                    .font(.footnote)
            }
            Spacer()
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 50)
                .fill(.bgWhite)
                .shadow(color: .textBlack.opacity(0.1), radius: 5)
        }
    }
                   
}

#Preview {
    SearchAndFilterBar()
}
