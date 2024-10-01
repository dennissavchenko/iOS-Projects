//
//  ListingItemView.swift
//  Airbnb
//
//  Created by dennis savchenko on 10/08/2024.
//

import SwiftUI

struct ListingItemView: View {
    
    var listing : Listing
    
    var body: some View {
        VStack(spacing: 8) {
            TabView {
                ForEach(listing.images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .tabViewStyle(.page)
            HStack(alignment: .top, spacing: 2) {
                VStack(alignment: .leading){
                    Text("\(listing.placeType.rawValue) in \(listing.place)")
                        .fontWeight(.bold)
                    Text(listing.title)
                        .foregroundStyle(.noteGray)
                    Text("\(listing.bedsNum) \(listing.bedsNum == 1 ? "bed" : "beds")")
                        .foregroundStyle(.noteGray)
                    Text("Hosted by \(listing.host.name)")
                        .foregroundStyle(.noteGray)
                    HStack(spacing: 4) {
                        Text("$\(listing.price.formatted(.number.precision(.fractionLength(0))))")
                            .fontWeight(.bold)
                        Text("night")
                    }
                }
                Spacer()
                Image(systemName: "star.fill")
                    .font(.caption)
                Text("\(listing.rating.formatted())")
                    .fontWeight(.regular)
            }.font(.footnote)
        }
        .padding()
        .foregroundStyle(.textBlack)
    }
}

#Preview {
    ListingItemView(listing: listings[0])
}
