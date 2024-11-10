//
//  Features.swift
//  Airbnb
//
//  Created by dennis savchenko on 11/08/2024.
//

import Foundation

struct Feature: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var icon: String
    var description: String
}
