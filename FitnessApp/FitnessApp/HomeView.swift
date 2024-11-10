//
//  HomeView.swift
//  FitnessApp
//
//  Created by dennis savchenko on 14/09/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var healthManager: HealthManager
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2), spacing: 20) {
            ForEach(healthManager.activities) { activity in
                ActivityCard(activity: activity)
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
        .environmentObject(HealthManager())
}
