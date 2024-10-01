//
//  SearchModeView.swift
//  Airbnb
//
//  Created by dennis savchenko on 21/08/2024.
//

import SwiftUI

struct WhereTo: View {
    
    @Binding var active: Int
    @Binding var search: Search
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Where to?")
                    .fontWeight(active == 0 ? .bold : .semibold)
                    .font(active == 0 ? .title : .footnote)
                    .foregroundStyle(active != 0 ? .noteGray : .textBlack)
                    .padding(.bottom, active == 0 ? 10 : 0)
                if active == 0 {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.textBlack)
                        TextField("", text: $search.whereTo, prompt: Text("Search destinations")
                            .foregroundStyle(.noteGray))
                        .font(.footnote)
                        Spacer()
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.bgWhite)
                            .stroke(.pale)
                    }
                }
            }
            Spacer()
            if active != 0 {
                Text("Anywhere")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textBlack)
            }
                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: active == 0 ? 20 : 15)
                        .foregroundColor(.bgWhite)
                        .shadow(color: .textBlack.opacity(0.1), radius: active != 0 ? 1 : 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: active == 0 ? 20 : 15)
                                .stroke(.pale, lineWidth: 0.3)
                        }
                }
                .onTapGesture {
                    withAnimation {
                        active = 0
                    }
                }
    }
}

struct When: View {
    
    @Binding var active: Int
    @Binding var search: Search
    @Binding var selectedDate: Date?
    
    func getDateString(_ day: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: day)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if active == 1 {
                Text("When's your trip?")
                     .font(.title)
                     .fontWeight(.bold)
                CustomCalendar(selectedDate: $selectedDate, lowerDate: $search.lowerDate, upperDate: $search.upperDate)
                     .overlay(alignment: .top, content: {
                         Rectangle()
                             .frame(height: 30)
                             .foregroundStyle(Gradient(colors: [.bgWhite, .bgWhite.opacity(0)]))
                     })
                     .overlay(alignment: .bottom, content: {
                         VStack(spacing: 0) {
                             Rectangle()
                                 .frame(height: 40)
                                 .foregroundStyle(Gradient(colors: [.bgWhite.opacity(0), .bgWhite]))
                             HStack {
                                 Button {
                                     if selectedDate != nil {
                                         search.upperDate = Date.now
                                         search.lowerDate = search.upperDate
                                         selectedDate = nil
                                     } else {
                                         withAnimation {
                                             active = 0
                                         }
                                     }
                                 } label: {
                                     Text(selectedDate != nil ? "Reset" : "Skip")
                                         .foregroundStyle(.textBlack)
                                         .underline()
                                         .fontWeight(.semibold)
                                 }
                                 Spacer()
                                 Button {
                                     withAnimation {
                                         active = 2
                                     }
                                 } label: {
                                     Text("Next")
                                         .foregroundStyle(.bgWhite)
                                         .padding()
                                         .fontWeight(.semibold)
                                         .padding(.horizontal)
                                         .background {
                                             RoundedRectangle(cornerRadius: 10)
                                                 .fill(.textBlack)
                                         }
                                 }
                             }
                             .padding(.top, 10)
                             .padding(.horizontal, 10)
                             .background {
                                 Rectangle()
                                     .fill(.bgWhite)
                             }
                         }
                     })
            }
            else {
                HStack {
                    VStack(alignment: .leading) {
                        Text("When")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.noteGray)
                    }
                    Spacer()
                    Text("Any week")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textBlack)
                }

            }
        }
        .padding(20)
        .background {
                RoundedRectangle(cornerRadius: active == 1 ? 20 : 15)
                    .fill(.bgWhite)
                    .shadow(color: .textBlack.opacity(0.1), radius: active == 1 ? 10 : 1)
                    .overlay {
                        RoundedRectangle(cornerRadius: active == 1 ? 20 : 15)
                            .stroke(.pale, lineWidth: 0.3)
                    }
                    .onTapGesture {
                        withAnimation {
                            active = 1
                        }
                    }
        }
    }
}

struct Who: View {
    
    @Binding var active: Int
    @Binding var search: Search
    
    var body: some View {
        
        if active == 1 {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 16) {
                if active == 2 {
                    Text("Who's coming?")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                    CustomStepper(text: "Adults", hint: "Ages 13 or above", value: $search.guests.adults, range: 0...10)
                    Divider()
                    CustomStepper(text: "Children", hint: "Ages 2-12", value: $search.guests.children, range: 0...10)
                    Divider()
                    CustomStepper(text: "Infants", hint: "Under 2", value: $search.guests.infants, range: 0...10)
                    Divider()
                    CustomStepper(text: "Pets", value: $search.guests.pets, range: 0...10)
                } else {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text("Who")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.noteGray)
                            Spacer()
                            Text("Add guests")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.textBlack)
                        }
                    }
                }
            }
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: active == 2 ? 20 : 15)
                    .fill(.bgWhite)
                    .shadow(color: .textBlack.opacity(0.1), radius: active == 2 ? 10 : 1)
                    .overlay {
                        RoundedRectangle(cornerRadius: active == 2 ? 20 : 15)
                            .stroke(.pale, lineWidth: 0.3)
                    }
            }
            .onTapGesture {
                withAnimation {
                    active = 2
                }
            }
        }
    }
}

struct SearchModeView: View {
    
    @Environment (\.dismiss) private var dismiss
    
    @State private var search: Search = Search()
    
    @State private var active = 0
    
    @State var selectedDate: Date?

    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .padding(10)
                        .background {
                            Circle()
                                .fill(.bgWhite)
                                .stroke(.noteGray, lineWidth: 0.3)
                        }
                }.buttonStyle(PlainButtonStyle())
                
                WhereTo(active: $active, search: $search)
                When(active: $active, search: $search, selectedDate: $selectedDate)
                Who(active: $active, search: $search)
                
            }
            .padding()
            
            Spacer()
            
            HStack {
                Button {
                    search = Search()
                    selectedDate = nil
                } label: {
                    Text("Clear all")
                        .underline()
                        .fontWeight(.medium)
                }
                Spacer()
                Button {
                    print(search)
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .foregroundStyle(.bgWhite)
                    .padding()
                    .fontWeight(.semibold)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.pink)
                    }
                }
            }
            .padding()
            .background(.bgWhite)
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(.pale)
                    .frame(height: 0.3)
            }
        }
        .presentationBackground(.thickMaterial)
    }
}

#Preview {
    SearchModeView()
}
