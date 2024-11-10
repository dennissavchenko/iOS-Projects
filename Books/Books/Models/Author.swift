//
//  Author.swift
//  Books
//
//  Created by dennis savchenko on 22/08/2024.
//

import Foundation

struct Author: Identifiable, Hashable, Codable, Comparable {
    
    static func < (lhs: Author, rhs: Author) -> Bool {
            if lhs.name == rhs.name {
                return lhs.surname < rhs.surname
            }
            return lhs.name < rhs.name
    }
    
    var id: Int
    var name: String
    var surname: String
    
    func getAuthor() -> String {
        return "\(name) \(surname)"
    }
    
}
