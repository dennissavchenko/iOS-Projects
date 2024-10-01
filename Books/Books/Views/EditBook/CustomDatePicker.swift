//
//  CustomDatePicker.swift
//  Books
//
//  Created by dennis savchenko on 31/08/2024.
//

import SwiftUI

struct CustomDatePicker: View {
    
    var title: String
    var hint: String = ""
    @Binding var releaseDate: Date
    @State var isSelected: Bool = false
    @State var dateChanged: Bool = false
    
    private var releaseDateFormatted: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: releaseDate)
    }
    
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    isSelected.toggle()
                }
            } label: {
                VStack(alignment: .leading) {
                    Text(title)
                        .fontDesign(.serif)
                        .fontWeight(isSelected ? .semibold : .regular)
                    Text(releaseDateFormatted)
                        .onChange(of: releaseDate) {
                            dateChanged = true
                        }
                        .padding()
                        .foregroundColor(dateChanged ? .black : Color(.systemGray2))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .stroke(isSelected ? .black : Color(.systemGray2), lineWidth: isSelected ? 2 : 1)
                        }
                    if hint.count != 0 {
                        Text(hint)
                            .font(.caption)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            if isSelected {
                DatePicker("Release Date", selection: $releaseDate, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.graphical)
            }
        }
    }
}

#Preview {
    CustomDatePicker(title: "Release Date", releaseDate: .constant(Date.now))
}
