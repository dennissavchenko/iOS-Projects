//
//  ActivityCard.swift
//  FitnessApp
//
//  Created by dennis savchenko on 14/09/2024.
//

import SwiftUI

struct ActivityCard: View {
    
    @State var activity: Activity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(activity.title)
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: activity.image)
                    .foregroundStyle(activity.imageColor)
            }
            Text(activity.subtitle)
                .font(.footnote)
                .foregroundStyle(.gray)
            Text(activity.amount)
                .padding(.top)
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
        }
        .padding()
        .background(.black.opacity(0.03))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ActivityCard(activity: Activity(title: "Daily steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: "4,675", imageColor: .blue))
}
