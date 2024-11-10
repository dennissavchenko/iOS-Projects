//
//  AddBookNew.swift
//  Books
//
//  Created by dennis savchenko on 31/08/2024.
//

import SwiftUI

struct EditBookView: View {
    
    @EnvironmentObject private var booksViewModel: BooksViewModel
    @EnvironmentObject private var authorsViewModel: AuthorsViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State var book: Book
    
    @State var searchText: String = ""
    @State var authorIndex: Int = 0
    @State var genres: [Genre] = []
    
    @State var isLoaded: Bool = false
    
    @State var releaseDate: Date = Date.now
    
    @State private var errorMessage = ""
    @State var showAlert: Bool = false
    
    private var releaseDateFormatted: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: releaseDate)
    }
    
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
    
    @State var price: String = ""
    @State var numPages: String = ""
    @State var inStock: String = ""
    
    @State var updating: Bool = false
    
    init(book: Book? = nil) {
        
        if let book = book {
            _updating = State(initialValue: true)
            _book = State(initialValue: book)
            _searchText = State(initialValue: "\(book.author.name) \(book.author.surname)")
            _genres = State(initialValue: book.genres)
            _price = State(initialValue: String(book.price).replacingOccurrences(of: ".", with: ","))
            _numPages = State(initialValue: String(book.numPages))
            _inStock = State(initialValue: String(book.inStock))
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
                VStack(alignment: .leading, spacing: 16) {
                    CustomTextField(title: "Name", text: $book.name, example: "The Help")
                        .onChange(of: book.name) {
                            if book.name.count > 100 {
                                book.name = String(book.name.prefix(100))
                            }
                        }
                    CustomTextField(title: "Description", text: $book.description, example: "The Help by Kathryn Stockett is set in...", axis: .vertical)
                        .onChange(of: book.description) {
                            if book.description.count > 300 {
                                book.description = String(book.description.prefix(300))
                            }
                        }
                    CustomDatePicker(title: "Release Date", releaseDate: $releaseDate, dateChanged: updating)
                        .disabled(updating)
                    CustomTextField(title: "Price", text: $price, example: "11,99", keybordType: .decimalPad)
                    CustomTextField(title: "Number of Pages", text: $numPages, example: "451", keybordType: .numberPad, disabled: updating)
                        .disabled(updating)
                    CustomTextField(title: "Number in Stock", text: $inStock, example: "11", keybordType: .numberPad)
                    CustomTextField(title: "Image URL", text: $book.imageURL, example: "https://image.png", axis: .vertical)
                        .onChange(of: book.imageURL) {
                            if book.imageURL.count > 300 {
                                book.imageURL = String(book.imageURL.prefix(300))
                            }
                        }
                    if book.imageURL.count > 0 {
                        HStack {
                            Spacer()
                            WebImage(imageURL: book.imageURL, isLoaded: $isLoaded)
                                .padding()
                            Spacer()
                        }
                    }
                    CustomTextField(title: "Author", text: $searchText, example: "Kathryn Stockett", disabled: updating)
                        .disabled(updating)
                    if filteredAuthors.count > 0 && searchText != filteredAuthors[0].getAuthor() {
                        VStack(alignment: .leading) {
                            ForEach(filteredAuthors.sorted(by: <).prefix(4)) { author in
                                Text("\(author.name) \(author.surname)")
                                    .padding()
                                    .onTapGesture {
                                        searchText = "\(author.name) \(author.surname)"
                                        authorIndex = author.id
                                    }
                                Divider()
                            }
                        }
                    }
                    Text("Genres")
                        .fontDesign(.serif)
                    GenresView(genres: $genres)
                        .environmentObject(GenresViewModel())
                    Button {
                        book.releaseDate = releaseDateFormatted
                        if let price = Double(price.replacingOccurrences(of: ",", with: ".")) {
                            book.price = price
                        }
                        if let numPages = Int(numPages) {
                            book.numPages = numPages
                        }
                        if let inStock = Int(inStock) {
                            book.inStock = inStock
                        }
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
                    .buttonStyle(PlainButtonStyle())
                }.tint(.gray)
                    .padding()
            }
            .refreshable {
                authorsViewModel.fetchData()
                booksViewModel.fetchData()
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
    EditBookView()
        .environmentObject(BooksViewModel())
        .environmentObject(AuthorsViewModel())
}
