//
//  BetterSleepApp.swift
//  BetterSleep
//
//  Created by dennis savchenko on 29/08/2024.
//

import SwiftUI

@main
struct BetterSleepApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase) { 
                    if scenePhase == .active {
                        NotificationManager.shared.setBadgeCount(0)
                    }
                }
        }
    }
}
