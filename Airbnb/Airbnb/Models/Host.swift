//
//  File.swift
//  Airbnb
//
//  Created by dennis savchenko on 11/08/2024.
//

import Foundation

struct Host: Hashable {
    var name: String
    var picture: String?
    var yearsOfHosting: Int
    var isSuperhost: Bool
}
