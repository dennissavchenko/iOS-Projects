//
//  FieldView.swift
//  Books
//
//  Created by dennis savchenko on 31/08/2024.
//

import SwiftUI

struct CustomTextField: View {
    
    var title: String
    @Binding var text: String
    var hint: String = ""
    var example: String
    var keybordType: UIKeyboardType = .default
    var axis: Axis = .horizontal
    var disabled: Bool = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundStyle(disabled ? Color(.systemGray) : .black)
                .fontDesign(.serif)
                .fontWeight(isFocused ? .semibold : .regular)
            TextField(example, text: $text, axis: axis)
                .focused($isFocused)
                .foregroundStyle(disabled ? Color(.systemGray) : .black)
                .keyboardType(keybordType)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isFocused ? .black : Color(.systemGray2), lineWidth: isFocused ? 2 : 1)
                }
            if hint.count != 0 {
                Text(hint)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    CustomTextField(title: "Name", text: .constant("Hello"), example: "The Help")
}
