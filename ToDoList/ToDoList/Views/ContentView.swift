import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var tasksViewModel: TasksViewModel
    
    @State private var showAddItem: Bool = false
    @State private var isAdding: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach($tasksViewModel.items) { $item in
                        NavigationLink(destination: EditItem(item: $item)) {
                            ItemView(item: $item, items: $tasksViewModel.items)
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        withAnimation{
                                            tasksViewModel.delete(item: item)
                                        }
                                    } label: {
                                        Text("delete")
                                    }
                                    NavigationLink {
                                        EditItem(item: $item)
                                            .navigationBarBackButtonHidden()
                                    } label: {
                                        Text("edit")
                                    }
                                }.tint(.black)
                        }
                        .foregroundStyle(.white)
                    }
                    .onMove(perform: tasksViewModel.move)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    Spacer()
                }.listSectionSeparator(.hidden)
            }
            .listStyle(.plain)
            .padding(.top, 5)
            .overlay(alignment: .bottom) {
                Button {
                    showAddItem.toggle()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .fontWeight(.light)
                        Text("Add")
                            .fontWeight(.light)
                    }
                    .foregroundStyle(.black)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundStyle(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.gray)
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .fullScreenCover(isPresented: $showAddItem, content: {
            AddItem()
        })
    }
}

#Preview {
    ContentView()
        .environmentObject(TasksViewModel())
}
