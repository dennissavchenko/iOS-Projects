//
//  Book.swift
//  Books
//
//  Created by dennis savchenko on 22/08/2024.
//

import Foundation

struct Book: Identifiable, Hashable, Codable {
    
    var id: Int
    var name: String
    var description: String
    var releaseDate: String
    var price: Double
    var numPages: Int
    var inStock: Int
    var imageURL: String
    var author: Author
    var genres: [Genre]
    
    private func isValidDate() -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let _ = dateFormatter.date(from: releaseDate) {
            return true
        } else {
            return false
        }
        
    }
    
    func checkBook(isLoaded: Bool) -> String? {
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please enter a name for the book."
        } else if description.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please provide a description for the book."
        } else if releaseDate.trimmingCharacters(in: .whitespaces).isEmpty || !isValidDate() {
            return "Please enter a valid release date."
        } else if price <= 0 {
            return "Please enter a valid price greater than zero."
        } else if numPages <= 0 {
            return "Please enter a valid number of pages."
        } else if inStock <= 0 {
            return "Please enter a valid stock quantity."
        } else if !isLoaded {
            return "The image could not be found or loaded. Please try again."
        } else if author.id == 0 {
            return "Please select an author from the list."
        } else if genres.isEmpty {
            return "Please select at least one genre for the book."
        }
        return nil
    }
    
}
