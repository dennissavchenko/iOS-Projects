//
//  Activity.swift
//  FitnessApp
//
//  Created by dennis savchenko on 14/09/2024.
//

import Foundation
import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let image: String
    let amount: String
    let imageColor: Color
}
