//
//  HerbsApp.swift
//  Herbs
//
//  Created by dennis savchenko on 10/11/2024.
//

import SwiftUI
import SwiftData

@main
struct HerbsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: HerbItem.self)
    }
}
