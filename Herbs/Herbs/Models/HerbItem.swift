//
//  Item.swift
//  Herbs
//
//  Created by dennis savchenko on 10/11/2024.
//

import Foundation
import SwiftData

@Model
class HerbItem: Identifiable {
    
    var id = UUID()
    var name: String
    var desc: String
    var imageURL: String
    
    init(name: String, desc: String, imageURL: String) {
        self.name = name
        self.desc = desc
        self.imageURL = imageURL
    }
    
}
