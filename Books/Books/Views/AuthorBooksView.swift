//
//  AuthorBooksView.swift
//  Books
//
//  Created by dennis savchenko on 31/08/2024.
//

import SwiftUI

struct AuthorBooksView: View {
    
    @EnvironmentObject private var booksViewModel: BooksViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var author: Author
    @State var books: [Book] = []
    
    @State var selectedBook: Book? = nil
    @State var isLoaded: Bool = false
    
    init(author: Author) {
        self.author = author
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 34)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 17)!]
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach (books) { book in
                        BookItemView(book: book, isLoaded: $isLoaded)
                        .padding(.trailing)
                        .padding(.vertical, 20)
                        .listRowInsets(EdgeInsets())
                        .onTapGesture {
                            selectedBook = book
                        }
                    }
                }.listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("\(author.name) \(author.surname)")
                .font(.system(size: 16, design: .serif))
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            booksViewModel.getAuthorBooks(authorId: author.id) { response in books = response
                
            }
        }
        .sheet(item: $selectedBook) { book in
            BookView(book: book)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                }
        }
    }
}

#Preview {
    AuthorBooksView(author: Author(id: 5, name: "Eckhart", surname: "Tolle"))
        .environmentObject(BooksViewModel())
}
