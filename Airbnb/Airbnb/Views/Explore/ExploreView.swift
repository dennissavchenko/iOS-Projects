//
//  ExploreView.swift
//  Airbnb
//
//  Created by dennis savchenko on 10/08/2024.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var selectedSpecial: String? = nil
    @State private var searchModeOn: Bool = false
    
    var filteredListings: [Listing] {
        var filtered: [Listing]
        if selectedSpecial == nil {
            filtered = listings
        }
        else {
            filtered = listings.filter { listing in
                listing.placeType.rawValue == selectedSpecial
            }
        }
        return filtered
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    withAnimation {
                        searchModeOn = true
                    }
                } label: {
                    SearchAndFilterBar()
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(PlaceType.allCases.map { $0.rawValue }, id: \.self) { special in
                            SpecialItemView(name: special, selectedSpecial: $selectedSpecial)
                        }
                    }.fixedSize()
                }
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(filteredListings, id: \.self) { listing in
                            NavigationLink(value: listing) {
                                ListingItemView(listing: listing)
                            }
                        }
                    }
                }
                .navigationDestination(for: Listing.self) { listing in
                    ListingView(listing: listing)
                }
                .overlay(alignment: .top, content: {
                    Rectangle()
                        .frame(height: 10)
                        .foregroundStyle(Gradient(colors: [.textBlack.opacity(0.05), .textBlack.opacity(0)]))
                })
            }
            .overlay(alignment: .bottom) {
                NavigationLink {
                    MapView()
                } label: {
                    Label("Map", systemImage: "map")
                        .padding()
                        .fontWeight(.semibold)
                        .foregroundStyle(.bgWhite)
                        .background {
                            Capsule()
                                .fill(.textBlack)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                }
            }
            .background(.bgWhite)
        }.fullScreenCover(isPresented: $searchModeOn) {
            SearchModeView()
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ExploreView()
}
