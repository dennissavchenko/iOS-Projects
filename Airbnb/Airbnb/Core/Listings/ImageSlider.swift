//
//  ImageSlider.swift
//  Airbnb
//
//  Created by dennis savchenko on 11/08/2024.
//

import SwiftUI

struct ImageSlider: View {
    
    var images: [String]
    var currentIndex: Int = 0
    @Environment (\.dismiss) private var dismiss
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .textBlack
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.textBlack.withAlphaComponent(0.2)
      }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.bgWhite
            TabView {
                ForEach(images.indices, id: \.self) { index in
                    VStack {
                        Image(images[index])
                            .resizable()
                            .scaledToFit()
                    }
                }
                
            }
            .onAppear {
                setupAppearance()
            }
            .tabViewStyle(.page)
            .padding(.bottom, 40)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.noteGray)
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
    ImageSlider(images: ["1_1", "1_2", "1_3", "1_4"])
}
