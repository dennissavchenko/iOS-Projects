//
//  Special.swift
//  Airbnb
//
//  Created by dennis savchenko on 10/08/2024.
//

import Foundation

struct Special: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}
