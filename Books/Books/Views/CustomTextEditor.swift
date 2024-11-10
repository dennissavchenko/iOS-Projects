//
//  CustomTextEditor.swift
//  Books
//
//  Created by dennis savchenko on 31/08/2024.
//

import SwiftUI

struct CustomTextEditor: View {
    
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontDesign(.serif)
            TextField("The Help...", text: $text, axis: .horizontal)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .stroke(Color(.systemGray2), lineWidth: 1)
                }
        }
    }
}

#Preview {
    CustomTextEditor(title: "Description", text: .constant("Hello;fiovher;giojergio;bjhfoibjstoi;jfg'bjs;gbjsfgibhjsr;ibjst;hbhjrgbkjg;hlkbjfgb;kjjfgb;klfgjblkfghb"))
}
