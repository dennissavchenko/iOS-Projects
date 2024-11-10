//
//  BookItemView.swift
//  Books
//
//  Created by dennis savchenko on 29/08/2024.
//

import SwiftUI

struct BookItemView: View {
    
    var book: Book
    @Binding var isLoaded: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            WebImage(imageURL: book.imageURL, isLoaded: $isLoaded)
                .shadow(radius: 5)
                .frame(width: 120, height: 150)
                .padding(.horizontal)
            VStack(alignment: .leading) {
                Text(book.name)
                    .fontWeight(.semibold)
                Text("\(book.author.name) \(book.author.surname)")
                    .font(.footnote)
                    .italic()
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text(String(format: "£%.2f", book.price))
                .fontWeight(.heavy)
                .font(.footnote)
                .foregroundStyle(.white)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.brown)
                }
        }
    }
}

#Preview {
    BookItemView(book: Book(id: 1, name: "The Help", description: "The Help", releaseDate: "2005-04-06", price: 11.99, numPages: 450, inStock: 11, imageURL: "https://m.media-amazon.com/images/I/71CX5LhK9UL._AC_UF1000,1000_QL80_.jpg", author: Author(id: 1, name: "Katrin", surname: "Stockett"), genres: [Genre(id: 1, name: "Novel")]), isLoaded: .constant(true))
}
