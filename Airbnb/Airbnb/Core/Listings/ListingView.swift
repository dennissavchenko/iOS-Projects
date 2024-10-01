//
//  ListingView.swift
//  Airbnb
//
//  Created by dennis savchenko on 11/08/2024.
//

import SwiftUI

struct ListingView: View {
    
    var listing: Listing
    @State var showMore: Bool = false
    @State var imagesView: Bool = false
    @State var images: [String] = []
    @Environment (\.dismiss) private var dismiss

    var body: some View {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading) {
                        NavigationLink {
                            ImageSlider(images: listing.images)
                        } label: {
                            TabView {
                                ForEach(listing.images, id: \.self) {
                                    image in
                                    Image(image)
                                        .resizable()
                                        .scaledToFill()
                                        .onTapGesture {
                                            images = listing.images
                                            imagesView.toggle()
                                        }
                                }
                            }
                            .tabViewStyle(.page)
                            .frame(height: 300)
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text(listing.title)
                                .font(.title)
                                .fontWeight(.medium)
                                .padding(.bottom, 10)
                            Text("\(listing.placeType.rawValue) in \(listing.place)")
                                .fontWeight(.medium)
                            Text("\(listing.capacity) guests ⋅ \(listing.placeType.rawValue) ⋅ \(listing.bedsNum) \(listing.bedsNum == 1 ? "bed" : "beds") ⋅ \(listing.bathroomNum) \(listing.bathroomNum == 1 ? "bathroom" : "bathrooms")")
                                .font(.footnote)
                                .fontWeight(.light)
                            HStack(spacing: 2) {
                                Image(systemName: "star.fill")
                                    .font(.footnote)
                                Text("\(listing.rating.formatted())")
                                
                            }
                            .fontWeight(.medium)
                            .font(.caption)
                            Divider().padding(.vertical, 10)
                            HStack {
                                if listing.host.picture == nil {
                                    Image(systemName: "person")
                                        .frame(width: 40, height: 30)
                                        .font(.title3)
                                } else {
                                    Image(listing.host.picture!)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        .frame(height: 50)
                                }
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Hosted by \(listing.host.name)")
                                        .fontWeight(.medium)
                                    Text("\(listing.host.yearsOfHosting) \(listing.host.yearsOfHosting == 1 ? "year" : "years") of hosting")
                                        .font(.footnote)
                                        .fontWeight(.light)
                                }.padding(.horizontal, 6)
                            }
                            Divider().padding(.vertical, 10)
                            VStack(alignment: .leading) {
                                ForEach(listing.features, id: \.self) { feature in
                                    HStack {
                                        Image(systemName: feature.icon)
                                            .frame(width: 40, height: 30)
                                            .font(.title3)
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(feature.title)
                                                .fontWeight(.medium)
                                            Text(feature.description)
                                                .font(.footnote)
                                                .fontWeight(.light)
                                                .foregroundStyle(.noteGray)
                                                .padding(.trailing, 20)
                                        }
                                    }
                                }
                            }
                            Divider().padding(.vertical, 10)
                            Text(listing.description)
                                .fontWeight(.light)
                                .frame(height: showMore || listing.description.count < 500 ? nil : 200)
                            if listing.description.count >= 500 {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        showMore.toggle()
                                    }
                                }, label: {
                                    Text(showMore ? "Show less" : "Show more")
                                        .underline()
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                })
                            }
                            Divider().padding(.vertical, 10)
                            Text("What this place offers?")
                                .font(.title)
                                .fontWeight(.medium)
                                .padding(.bottom, 10)
                            VStack(alignment: .leading) {
                                ForEach(listing.offers, id: \.self) { offer in
                                    HStack {
                                        Image(systemName: "arrow.forward")
                                        Text(offer)
                                    }.padding(.vertical, 5)
                                }
                            }
                        }.padding(20)
                        Spacer()
                    }
                }
                .scrollIndicators(.hidden)
                HStack {
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("$\(listing.price.formatted(.number.precision(.fractionLength(0...2))))")
                                .fontWeight(.bold)
                            Text("night")
                                .font(.footnote)
                                .fontWeight(.light)
                        }
                        Text("28-31 Aug")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .underline()
                    }
                    Spacer()
                    NavigationLink {
                        BookingView(listing: listing)
                    } label: {
                        Text("Reserve")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 18)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.pink)
                            }
                    }
                }
                .padding(.bottom, 20)
                .padding(20)
                .background {
                    Rectangle()
                        .fill(.bgWhite)
                        .overlay(alignment: .top) {
                            Rectangle()
                                .fill(Color(.systemGray5))
                                .frame(height: 1)
                    
                        }
                }
            }
            .navigationBarBackButtonHidden()
            .toolbarBackground(.bgWhite, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.textBlack)
                            .fontWeight(.semibold)
                            .font(.footnote)
                            .padding(.horizontal, 20)
                            .background {
                                Circle()
                                    .fill(.bgWhite)
                                    .frame(width: 32, height: 32)
                            }
                    }
                }
            }
            .ignoresSafeArea()
            .background(.bgWhite)
            .foregroundStyle(.textBlack)
    }
}

#Preview {
    ListingView(listing: listings[1])
}
