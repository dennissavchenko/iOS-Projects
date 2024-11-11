//
//  HerbItemView.swift
//  Herbs
//
//  Created by dennis savchenko on 11/11/2024.
//

import SwiftUI

struct HerbItemView: View {
    
    var herb: HerbItem
    
    @State var isLoaded: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            WebImage(imageURL: herb.imageURL, isLoaded: $isLoaded)
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Text(herb.name)
        }
    }
}

#Preview {
    HerbItemView(herb: sage)
}
