//
//  BookView.swift
//  Books
//
//  Created by dennis savchenko on 22/08/2024.
//

import SwiftUI

struct BookView: View {
    
    var book: Book
    @State var isLoaded: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    func getYear(releaseDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: releaseDate)
        return String(Calendar.current.component(.year, from: date!))
    }
    
    func getDate(releaseDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: releaseDate)
        dateFormatter.dateFormat = "MMMM"
        return "\(String(Calendar.current.component(.day, from: date!))) \(dateFormatter.string(from: date!))"
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    WebImage(imageURL: book.imageURL, isLoaded: $isLoaded)
                        .padding()
                        .shadow(radius: 30)
                    Text(book.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .fontDesign(.serif)
                    Text(book.description)
                        .multilineTextAlignment(.center)
                        .frame(height: 70)
                        .fontWeight(.semibold)
                        .fontDesign(.serif)
                    NavigationLink(destination: AuthorBooksView(author: book.author)){
                        HStack {
                            Text("\(book.author.name) \(book.author.surname)")
                                .foregroundStyle(.black)
                            Image(systemName: "chevron.right")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.systemGray))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    HStack(spacing: 16) {
                        Spacer()
                        Image(systemName: "app.gift.fill")
                            .font(.title)
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.title)
                    }.padding(.vertical)
                    Button {
                        // buy
                    } label: {
                        Text("BUY | \(String(format: "£%.2f", book.price))")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(14)
                            .background {
                                Capsule()
                            }
                    }
                    .buttonStyle(PlainButtonStyle())
                    HStack {
                        Button {
                            // ADD
                        } label: {
                            Label("WANT TO READ", systemImage: "plus.circle.fill")
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                                .padding(14)
                                .background {
                                    Capsule()
                                        .stroke(.black, lineWidth: 2)
                                }
                        }
                        Button {
                            // READ
                        } label: {
                            Label("SAMPLE", systemImage: "book.pages.fill")
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                                .padding(12)
                                .padding(.horizontal, 6)
                                .background {
                                    Capsule()
                                        .stroke(.black, lineWidth: 2)
                                }
                        }
                    }
                    Divider().padding(.vertical, 20)
                    VStack(alignment: .leading) {
                        Text("Publisher Description")
                            .fontWeight(.semibold)
                            .fontDesign(.serif)
                        Text(book.description)
                            .padding(.vertical)
                    }
                    Divider().padding(.vertical, 20)
                    HStack {
                        VStack {
                            Text("RELEASED")
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                                .font(.footnote)
                            Text(getYear(releaseDate: book.releaseDate))
                                .fontDesign(.serif)
                                .fontWeight(.bold)
                                .font(.title2)
                            Text(getDate(releaseDate: book.releaseDate))
                                .font(.footnote)
                        }
                    }
                }
                .padding(30)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .bold()
                            .foregroundStyle(.gray.opacity(0.7))
                    }
                }
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBook = Book(
            id: 1,
            name: "The Help",
            description: "The Help by Kathryn Stockett is set in 1960s Mississippi and follows a young white journalist and two Black maids who secretly write a book exposing the racism faced by Black domestic workers. Their alliance challenges societal norms, revealing the power of courage, friendship, and change.",
            releaseDate: "2009-02-10",
            price: 7.99,
            numPages: 451,
            inStock: 11,
            imageURL: "https://m.media-amazon.com/images/I/71CX5LhK9UL._AC_UF1000,1000_QL80_.jpg",
            author: Author(id: 1, name: "Kathryn", surname: "Stockett"),
            genres: []
        )
        
        // Provide the sample data to BookView
        BookView(book: sampleBook)
    }
}
