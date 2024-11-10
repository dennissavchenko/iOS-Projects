//
//  AddItem.swift
//  ToDoList
//
//  Created by dennis savchenko on 19/08/2024.
//

import SwiftUI

struct AddItem: View {
    
    @EnvironmentObject var tasksViewModel: TasksViewModel

    @Environment(\.dismiss) private var dismiss
    @State private var task: String = ""
    @State private var note: String = ""
    
    var body: some View {
        VStack {
            TextField("I want to ...", text: $task)
            Divider()
            TextField("Add note", text: $note)
            Spacer()
        }.tint(.gray)
        .navigationBarBackButtonHidden()
        .fontWeight(.light)
        .padding()
        .background(
            Rectangle()
                .fill(.white)
                .onTapGesture {
                    if task.count > 0 {
                        tasksViewModel.add(item: TaskItem(task: task, note: note.count > 0 ? note : nil))
                    }
                    dismiss()
                }
        )
    }
    
}

#Preview {
    AddItem()
        .environmentObject(TasksViewModel())
}
