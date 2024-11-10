//
//  EditItem.swift
//  ToDoList
//
//  Created by dennis savchenko on 19/08/2024.
//

import SwiftUI

struct EditItem: View {
    
    @Binding var item: TaskItem
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("I want to ...", text: $item.task)
            Divider()
            TextField("Add note", text: Binding(
                get: { item.note ?? "" },
                set: { item.note = $0 }
            ))
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .fontWeight(.light)
        .padding()
        .background(
            Rectangle()
                .fill(.white)
                .onTapGesture {
                    if item.task.count > 0 {
                        dismiss()
                    }
                }
        )
    }
}

#Preview {
    EditItem(item: .constant(TaskItem(task: "content", note: "note")))
}
