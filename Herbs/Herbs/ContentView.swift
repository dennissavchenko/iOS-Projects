//
//  ContentView.swift
//  Herbs
//
//  Created by dennis savchenko on 10/11/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var herbs: [HerbItem]
    
    @State private var isPresented: Bool = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(herbs) { herb in
                    NavigationLink {
                        HerbView(herb: herb)
                    } label: {
                        HerbItemView(herb: herb)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .sheet(isPresented: $isPresented) {
                AddHerbView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(herbs[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: HerbItem.self, inMemory: true)
}
