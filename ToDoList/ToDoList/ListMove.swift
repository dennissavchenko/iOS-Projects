//
//  ListMove.swift
//  ToDoList
//
//  Created by dennis savchenko on 18/08/2024.
//

import SwiftUI

struct Animal: Identifiable {
    var id = UUID()
    var name: String
}

struct ListMove: View {
    
    @State var animals = [Animal(name: "Dog"), Animal(name: "Cat"), Animal(name: "Cow"), Animal(name: "Goat"), Animal(name: "Chicken")]
    
    var body: some View {
        List {
            ForEach(animals) { animal in
                Text(animal.name)
            }
            .onMove(perform: move)
        }.listStyle(.plain)
    }
    
    func move(fromOffsets: IndexSet, toOffset: Int) {
        animals.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
}

#Preview {
    ListMove()
}
