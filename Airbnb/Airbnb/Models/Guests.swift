//
//  Guests.swift
//  Airbnb
//
//  Created by dennis savchenko on 12/09/2024.
//

import Foundation

struct Guests {
    
    var adults: Int = 0
    var children: Int = 0
    var infants: Int = 0
    var pets: Int = 0
    
    func getString() -> String {
        let guests_ = "\(adults + children == 1 ? "1 guest" : "\(adults + children) guests")"
        let infants_ = "\(infants == 1 ? "1 infant" : infants > 1 ? "\(infants) infants" : "")"
        let pets_ = "\(pets == 1 ? "1 pet" : pets > 1 ? "\(pets) pets" : "")"
        return "\(guests_)\(!infants_.isEmpty ? ", " + infants_ : "")\(!pets_.isEmpty ? ", " + pets_ : "")"
    }
    
}
