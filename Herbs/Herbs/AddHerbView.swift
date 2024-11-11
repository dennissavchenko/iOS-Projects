//
//  AddHerbView.swift
//  Herbs
//
//  Created by dennis savchenko on 11/11/2024.
//

import SwiftUI

struct AddHerbView: View {
    
    @State var herbItem = HerbItem(name: "", desc: "", imageURL: "")
    @State var isLoaded: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    TextField("Name", text: $herbItem.name)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray6))
                        }
                    TextField("Description", text: $herbItem.desc, axis: .vertical)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray6))
                        }
                    TextField("Image URL", text: $herbItem.imageURL, axis: .vertical)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray6))
                        }
                    WebImage(imageURL: herbItem.imageURL, isLoaded: $isLoaded)
                    Button {
                        if !herbItem.name.isEmptyOrWhitespace() || !herbItem.desc.isEmptyOrWhitespace() || isLoaded {
                            modelContext.insert(herbItem)
                            dismiss()
                        }
                    } label: {
                        Text("Add")
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                    }
                }
                .padding()
            }
            .navigationTitle("New Herb")
        }
    }
}

extension String {
    func isEmptyOrWhitespace() -> Bool {
        return self.isEmpty || self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

#Preview {
    AddHerbView()
        .modelContainer(for: HerbItem.self, inMemory: true)
}
