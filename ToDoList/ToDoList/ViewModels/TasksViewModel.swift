//
//  TasksViewModel.swift
//  ToDoList
//
//  Created by dennis savchenko on 19/08/2024.
//

import Foundation

class TasksViewModel: ObservableObject {
    
    @Published var items: [TaskItem] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([TaskItem].self, from: data)
        else { return }
        items = savedItems
    }
    
    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
        items.sort(by: { !$0.isCompleted && $1.isCompleted })
    }
    
    func delete(item: TaskItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
    
    func add(item: TaskItem) {
        items.insert(item, at: 0)
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
}
