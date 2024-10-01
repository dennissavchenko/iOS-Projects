//
//  ContentView.swift
//  FitnessApp
//
//  Created by dennis savchenko on 14/09/2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var healthManager: HealthManager
    @State var selectedTab = "Home"
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .environmentObject(healthManager)
            MeView()
                .tag("Me")
                .tabItem {
                    Label("Me", systemImage: "person.fill")
                }
        }.tint(.black)
    }
}

#Preview {
    ContentView()
        .environmentObject(HealthManager())
}
