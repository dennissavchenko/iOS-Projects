//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by dennis savchenko on 13/08/2024.
//

import SwiftUI

@main
struct ToDoListApp: App {
    
    @StateObject var tasksViewModel: TasksViewModel = TasksViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasksViewModel)
        }
    }
}
