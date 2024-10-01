//
//  FieldView.swift
//  Books
//
//  Created by dennis savchenko on 31/08/2024.
//

import SwiftUI

struct CustomValueField<T>: View {
    
    var title: String
    @Binding var value: T
    var hint: String = ""
    var example: String
    var keybordType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
            TextField(example, value: $value, format: .number)
                .keyboardType(keybordType)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray2), lineWidth: 1)
                }
            if hint.count != 0 {
                Text(hint)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    CustomValueField(title: "Name", value: .constant(11.99), example: "The Help")
}
