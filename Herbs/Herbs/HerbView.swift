//
//  HerbView.swift
//  Herbs
//
//  Created by dennis savchenko on 10/11/2024.
//

import SwiftUI

struct HerbView: View {
    
    var herb: HerbItem
    @State var isLoaded: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            WebImage(imageURL: herb.imageURL, isLoaded: $isLoaded)
                .frame(width: UIScreen.main.bounds.width, height: 300)
            Text(herb.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            Text(herb.desc)
                .padding(.horizontal)
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                        .font(.footnote)
                        .padding(.horizontal, 20)
                        .background {
                            Circle()
                                .fill(.thinMaterial)
                                .frame(width: 32, height: 32)
                        }
                }
            }
        }
    }
}

#Preview {
    HerbView(herb: sage)
}
