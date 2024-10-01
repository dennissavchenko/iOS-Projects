//
//  AddBook.swift
//  Books
//
//  Created by dennis savchenko on 22/08/2024.
//

import SwiftUI

struct AddBook: View {
    
    @EnvironmentObject private var booksViewModel: BooksViewModel
    @EnvironmentObject private var authorsViewModel: AuthorsViewModel
    
    @Environment (\.dismiss) private var dismiss
    
    @State var book: Book
    
    @State var searchText: String = ""
    @State var authorIndex: Int = 0
    @State var genres: [Genre] = []
    
    @State var isLoaded: Bool = false
    
    @State private var errorMessage = ""
    @State var showAlert: Bool = false
    
    @State var price: Double?
    @State var numPages: Int?
    @State var inStock: Int?
    
    @State var updating: Bool = false
    
    var filteredAuthors: [Author] {
        var filtered: [Author]
        if searchText.isEmpty {
            return []
        } else {
            filtered = authorsViewModel.authors.filter { author in
                "\(author.name) \(author.surname)"
                    .lowercased()
                    .starts(with: searchText.lowercased())
            }
            if filtered.isEmpty {
            return authorsViewModel.authors.filter { author in
                        "\(author.name) \(author.surname)"
                            .lowercased()
                            .contains(searchText.lowercased())
                    }
                }
            else { return filtered }
            }
    }
    
    init(book: Book? = nil) {
        
        if let book = book {
            _updating = State(initialValue: true)
            _book = State(initialValue: book)
            _searchText = State(initialValue: "\(book.author.name) \(book.author.surname)")
            _genres = State(initialValue: book.genres)
            _price = State(initialValue: book.price)
            _numPages = State(initialValue: book.numPages)
            _inStock = State(initialValue: book.inStock)
            _authorIndex = State(initialValue: book.author.id)
        } else {
            _book = State(initialValue: Book(id: 0, name: "", description: "", releaseDate: "", price: 0, numPages: 0, inStock: 0, imageURL: "", author: Author(id: 0, name: "", surname: ""), genres: []))
        }
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Georgia-Bold", size: 34)!]
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Georgia-Bold", size: 17)!]
            
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    TextField("Name", text: $book.name)
                        .onChange(of: book.name) {
                            if book.name.count > 100 {
                                book.name = String(book.name.prefix(100))
                            }
                        }
                        .padding()
                    Divider()
                    TextEditor(text: $book.description)
                        .onChange(of: book.name) {
                            if book.name.count > 300 {
                                book.name = String(book.name.prefix(300))
                            }
                        }
                        .frame(height: 100)
                        .padding(.horizontal, 11)
                        .overlay(alignment: .topLeading) {
                            if book.description.count == 0 {
                                Text("Description")
                                    .padding(.horizontal, 15)
                                    .padding(.top, 8)
                                    .foregroundColor(Color(.systemGray3))
                            }
                        }
                    Divider()
                    TextField("Release date (2004-12-24)", text: $book.releaseDate)
                        .padding()
                        .disabled(updating)
                    Divider()
                    TextField("Price", value: $price, format: .number)
                        .padding()
                        .keyboardType(.decimalPad)
                    Divider()
                    TextField("Number of Pages", value: $numPages, format: .number)
                        .padding()
                        .keyboardType(.numberPad)
                        .disabled(updating)
                    Divider()
                    TextField("Number in Stock", value: $inStock, format: .number)
                        .padding()
                        .keyboardType(.numberPad)
                    Divider()
                    TextField("Image URL", text: $book.imageURL)
                        .padding()
                    if book.imageURL.count > 0 {
                        Divider()
                        HStack {
                            Spacer()
                            WebImage(imageURL: book.imageURL, isLoaded: $isLoaded)
                                .padding()
                            Spacer()
                        }
                    }
                    Divider()
                    TextField("Author", text: $searchText)
                        .padding()
                        .disabled(updating)
                    if filteredAuthors.count > 0 && searchText != filteredAuthors[0].getAuthor() {
                        Divider()
                        VStack(alignment: .leading) {
                            ForEach(filteredAuthors.sorted(by: <).prefix(4)) { author in
                                Text("\(author.name) \(author.surname)")
                                    .padding()
                                    .onTapGesture {
                                        searchText = "\(author.name) \(author.surname)"
                                        authorIndex = author.id
                                    }
                            }
                        }
                    }
                    Divider()
                    GenresView(genres: $genres)
                        .environmentObject(GenresViewModel())
                        .padding()
                    Button {
                        book.price = price ?? 0.0
                        book.numPages = numPages ?? 0
                        book.inStock = inStock ?? 0
                        book.genres = genres
                        book.author = authorsViewModel.authors.first { $0.id == authorIndex } ?? Author(id: 0, name: "", surname: "")
                        if let error = book.checkBook(isLoaded: isLoaded) {
                            errorMessage = error
                            showAlert.toggle()
                        } else {
                            print(book)
                            if updating {
                                booksViewModel.updateBook(book)
                            } else {
                                booksViewModel.addBook(book)
                            }
                            dismiss()
                        }
                    } label: {
                        Text(updating ? "UPDATE BOOK" : "ADD BOOK")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(14)
                            .background {
                                Capsule()
                            }
                    }
                    .padding(.horizontal)
                    .buttonStyle(PlainButtonStyle())
                }.tint(.gray)
            }
            .alert(errorMessage, isPresented: $showAlert) {
                Button("Got it!") { }
                    .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle(updating ? "Edit Book" : "New Book")
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
    
}

#Preview {
    AddBook()
        .environmentObject(BooksViewModel())
        .environmentObject(AuthorsViewModel())
}
