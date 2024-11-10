//
//  TaskItem.swift
//  ToDoList
//
//  Created by dennis savchenko on 13/08/2024.
//

import Foundation

struct TaskItem: Identifiable, Equatable, Hashable, Codable {
    var id = UUID()
    var task: String
    var note: String?
    var isCompleted: Bool = false
}
