//
//  ContentView.swift
//  Books
//
//  Created by dennis savchenko on 22/08/2024.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @EnvironmentObject private var booksViewModel: BooksViewModel
    
    @State var selectedBook: Book? = nil
    @State var isLoaded: Bool = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 34)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 17)!]
    }
    
    var body: some View {
        NavigationStack {
            if(booksViewModel.books.isEmpty) {
                ProgressView()
                    .navigationTitle("Books")
            } else {
                List {
                    Section {
                        ForEach (booksViewModel.books) { book in
                            BookItemView(book: book, isLoaded: $isLoaded)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    withAnimation {
                                        booksViewModel.deleteBook(bookId: book.id)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                                NavigationLink {
                                    EditBookView(book: book)
                                        .environmentObject(AuthorsViewModel())
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    Image(systemName: "square.and.pencil")
                                }
                            }.tint(.black)
                            .padding(.trailing)
                            .padding(.vertical, 20)
                            .listRowInsets(EdgeInsets())
                            .onTapGesture {
                                selectedBook = book
                            }
                        }
                    }.listRowSeparator(.hidden)
                }
                .refreshable {
                    booksViewModel.fetchData()
                }
                .listStyle(.plain)
                .navigationTitle("Books")
                    .font(.system(size: 16, design: .serif))
                .toolbar {
                    NavigationLink (destination: EditBookView().environmentObject(AuthorsViewModel())
                        .navigationBarBackButtonHidden()) {
                            Image(systemName: "plus.circle.fill")
                                .fontWeight(.bold)
                        }.foregroundStyle(.black)
                    }
            }
        }
        .sheet(item: $selectedBook) { book in
            BookView(book: book)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(BooksViewModel())
}
