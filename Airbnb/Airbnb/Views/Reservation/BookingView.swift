//
//  BookingView.swift
//  Airbnb
//
//  Created by dennis savchenko on 12/09/2024.
//

import SwiftUI

struct BookingView: View {
    
    @State var listing: Listing
    @State var lowerDate: Date = Calendar.current.date(byAdding: .day, value: 10, to: Date.now)!
    @State var upperDate: Date = Calendar.current.date(byAdding: .day, value: 14, to: Date.now)!
    @State var guests: Guests = Guests(adults: 3, children: 1, infants: 1, pets: 1)
    
    @State var editDates: Bool = false
    @State var editGuests: Bool = false
    @State var selectedDate: Date? = Calendar.current.date(byAdding: .day, value: 3, to: Date.now)!
    
    var daysToStart: Int {
        return Calendar.current.dateComponents([.day], from: Date.now, to: lowerDate).day ?? 0
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                PlaceSummary(listing: listing, lowerDate: $lowerDate)
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 8)
                YourTrip(lowerDate: $lowerDate, upperDate: $upperDate, guests: $guests, editDates: $editDates, editGuests: $editGuests)
                if daysToStart >= 4 {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(height: 8)
                    HowToPay(lowerDate: $lowerDate, upperDate: $upperDate, price: listing.price)
                }
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 8)
                PriceDetails(lowerDate: $lowerDate, upperDate: $upperDate, price: listing.price)
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 8)
                CancellationPolicy(lowerDate: $lowerDate)
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 8)
                GroundRules()
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 8)
                Submit()
                Button {
                    //
                } label: {
                    Text("Request to book")
                        .foregroundStyle(.bgWhite)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.pink)
                        }
                }.padding([.horizontal, .bottom])
                Divider()
            }
        }
        .navigationTitle("Request to book")
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
                }
            }
        }
        .scrollIndicators(.hidden)
        .sheet(isPresented: $editDates) {
            EditDates(editDates: $editDates, lowerDate: $lowerDate, upperDate: $upperDate)
        }
        .sheet(isPresented: $editGuests) {
            EditGuests(guests: $guests, editGuests: $editGuests)
                .presentationDetents([.height(420)])
                .presentationDragIndicator(.visible)
        }
        
    }
}

struct Submit: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("The Host has 24 hours to confirm your booking. You'll be charged when the request is accepted.").font(.footnote)
            Divider()
            Text("By selecting the button, I agree to the ")
                .font(.caption)
            + Text("booking terms.")
                .font(.caption)
                .fontWeight(.medium)
                .underline()
        }.padding()
    }
}

struct GroundRules: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ground rules")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.vertical, 8)
            Text("We ask every guest to remember a few simple things about what makes a great guest.")
                .font(.footnote)
            VStack(alignment: .leading) {
                Text("•  ") + Text("Follow the house rules").font(.footnote)
                Text("•  ") + Text("Treat your Host's home like your own").font(.footnote)
            }
        }.padding()
    }
}

struct CancellationPolicy: View {
    
    @Binding var lowerDate: Date
    
    var daysToStart: Int {
        return Calendar.current.dateComponents([.day], from: Date.now, to: lowerDate).day ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Cancellation policy")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.vertical, 8)
            Text("\(daysToStart >= 6 ? "Free cancellation before \(Calendar.current.date(byAdding: .day, value: -5, to: lowerDate)!.formatted(.dateTime.day().month(.abbreviated))). " : "")") +
            Text("\(Calendar.current.isDate(Date.now, inSameDayAs: lowerDate) ? "This reservation is non-refundable." : "Cancel before check-in on \(lowerDate.formatted(.dateTime.day().month(.abbreviated))) for partial refund.")")
        }.padding()
    }
}


struct PriceDetails: View {
    
    @Binding var lowerDate: Date
    @Binding var upperDate: Date
    @State var price: Double
    
    var numberOfNights: Int {
        return Calendar.current.dateComponents([.day], from: lowerDate, to: upperDate).day ?? 0
    }
    
    var totalPrice: Double {
        return price * Double(numberOfNights)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Price details")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.vertical, 8)
            VStack(spacing: 8) {
                HStack {
                    Text("$\(price.formatted(.number.precision(.fractionLength(0...2)))) × \(numberOfNights) \(numberOfNights == 1 ? "night" : "nights")")
                    Spacer()
                    Text("$\(totalPrice.formatted(.number.precision(.fractionLength(0...2))))")
                }
                HStack {
                    Text("Cleaning fee")
                    Spacer()
                    Text("$\((totalPrice * 0.15).formatted(.number.precision(.fractionLength(0...2))))")
                }
                HStack {
                    Text("Airbnb service fee")
                    Spacer()
                    Text("$\((totalPrice * 0.2).formatted(.number.precision(.fractionLength(0...2))))")
                }
            }
            Divider()
            HStack {
                Text("Total (USD)")
                Spacer()
                Text("$\((totalPrice + totalPrice * 0.35).formatted(.number.precision(.fractionLength(0...2))))")
            }.fontWeight(.medium)
        }.padding()
    }
}

struct HowToPay: View {
    
    @Binding var lowerDate: Date
    @Binding var upperDate: Date
    @State var price: Double
    @State var payFull: Bool = true
    
    var numberOfNights: Int {
        return Calendar.current.dateComponents([.day], from: lowerDate, to: upperDate).day ?? 0
    }
    
    var totalPrice: Double {
        return price * Double(numberOfNights) + price * Double(numberOfNights) * 0.35
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Choose how to pay")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.vertical, 8)
            HStack {
                Text("Pay $\(totalPrice.formatted(.number.precision(.fractionLength(0...2)))) now")
                    .fontWeight(.medium)
                Spacer()
                Circle()
                    .fill(payFull ? .textBlack : .noteGray)
                    .frame(width: 20, height: 20)
                    .overlay {
                        Circle()
                            .fill(.bgWhite)
                            .frame(width: payFull ? 8 : 18, height: payFull ? 8 : 18)
                    }
            }.onTapGesture {
                withAnimation {
                    payFull = true
                }
            }
            Divider()
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pay part now, part later")
                        .fontWeight(.medium)
                    Text("$\((totalPrice * 0.25).formatted(.number.precision(.fractionLength(0...2)))) due today, $\((totalPrice * 0.75).formatted(.number.precision(.fractionLength(0...2)))) on \(Calendar.current.date(byAdding: .day, value: -4, to: lowerDate)!.formatted(.dateTime.day().month(.abbreviated).year())). No extra fees.")
                }
                Spacer()
                Circle()
                    .fill(!payFull ? .textBlack : .noteGray)
                    .frame(width: 20, height: 20)
                    .overlay {
                        Circle()
                            .fill(.bgWhite)
                            .frame(width: !payFull ? 8 : 18, height: !payFull ? 8 : 18)
                    }
            }
            .onTapGesture {
                withAnimation {
                    payFull = false
                }
            }
        }.padding()
    }
}

struct YourTrip: View {
    
    @Binding var lowerDate: Date
    @Binding var upperDate: Date
    @Binding var guests: Guests
    @Binding var editDates: Bool
    @Binding var editGuests: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your trip")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.vertical, 8)
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Dates")
                        .fontWeight(.medium)
                    Text("\(lowerDate.formatted(.dateTime.day().month(.abbreviated))) - \(upperDate.formatted(.dateTime.day().month(.abbreviated)))")
                }
                Spacer()
                Button {
                    editDates.toggle()
                } label: {
                    Text("Edit")
                        .fontWeight(.medium)
                        .underline()
                }.buttonStyle(PlainButtonStyle())
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Guests")
                        .fontWeight(.medium)
                    Text(guests.getString())
                }
                Spacer()
                Button {
                    editGuests.toggle()
                } label: {
                    Text("Edit")
                        .fontWeight(.medium)
                        .underline()
                }.buttonStyle(PlainButtonStyle())
            }
        }.padding()
    }
}

struct PlaceSummary: View {
    
    @State var listing: Listing
    @Binding var lowerDate: Date
    
    var daysToStart: Int {
        return Calendar.current.dateComponents([.day], from: Date.now, to: lowerDate).day ?? 0
    }
    
    var cancellationDeadline: Date? {
        return daysToStart >= 6 ? Calendar.current.date(byAdding: .day, value: -5, to: lowerDate)! : nil
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(listing.images[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack(alignment: .leading) {
                    Text(listing.placeType.rawValue)
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text(listing.title)
                        .font(.footnote)
                    Spacer()
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                        Text("\(listing.rating.formatted()) ⋅ ")
                        if listing.host.isSuperhost {
                            Image(systemName: "star.circle.fill")
                            Text("Superhost")
                                .foregroundStyle(.noteGray)
                        }
                    }
                    .font(.caption)
                }.padding(.horizontal)
               Spacer()
            }
            .frame(height: 100)
            if let cancellationDeadline = cancellationDeadline {
                Divider()
                HStack(spacing: 10) {
                    Text("Free cancellation before \(cancellationDeadline.formatted(.dateTime.day().month(.abbreviated))). ").fontWeight(.medium)
                    + Text("Get a full refund if you change your mind.")
                    Spacer()
                    Image(systemName: "calendar")
                        .font(.title)
                }
            }
        }.padding()
    }
}

#Preview {
    BookingView(listing: listings[0])
}
