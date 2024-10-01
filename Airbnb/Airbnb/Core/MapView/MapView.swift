//
//  Map.swift
//  Airbnb
//
//  Created by dennis savchenko on 11/09/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        Map() {
            ForEach(listings) { listing in
                Annotation(listing.place, coordinate: listing.getCoordinates()) {
                    NavigationLink {
                        ListingView(listing: listing)
                    } label: {
                        Text("$\(listing.price.formatted(.number.precision(.fractionLength(0))))")
                            .font(.footnote)
                            .foregroundStyle(.textBlack)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(8)
                            .background {
                                Capsule()
                                    .fill(.bgWhite)
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            }
                    }
                }
            }
        }
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.noteGray)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 30)
                    .background {
                        Circle()
                            .fill(.thinMaterial)
                            .frame(width: 32, height: 32)
                    }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MapView()
}
