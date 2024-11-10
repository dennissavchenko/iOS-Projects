//
//  Search.swift
//  Airbnb
//
//  Created by dennis savchenko on 10/09/2024.
//

import Foundation

struct Search {
    var whereTo: String = ""
    var lowerDate: Date = Date.now
    var upperDate: Date = Date.now
    var guests: Guests = Guests()
}
