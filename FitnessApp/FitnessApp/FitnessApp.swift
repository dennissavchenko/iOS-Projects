//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by dennis savchenko on 14/09/2024.
//

import SwiftUI

@main
struct FitnessApp: App {
    
    @StateObject var healthManager = HealthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(healthManager)
        }
    }
    
}
