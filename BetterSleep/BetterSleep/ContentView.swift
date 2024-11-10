//
//  ContentView.swift
//  BetterSleep
//
//  Created by dennis savchenko on 29/08/2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    @State private var alertTitle: LocalizedStringKey = ""
    @State private var alertMessage: LocalizedStringKey = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("When do you want to wake up?")
                    .font(.headline)
                CustomDatePicker(selectedDate: $wakeUp)
                Text("Desired amount of sleep")
                    .font(.headline)

                CustomStepper(text: "\(convertDecimalToTime(sleepAmount)) hours", value: $sleepAmount, step: 0.25, range: 4...12, systemImage: "hourglass")
                Text("Daily coffee intake")
                    .font(.headline)

                CustomStepper(text: coffeeAmount == 0 ? "No coffee today" : coffeeAmount == 1 ? "\(coffeeAmount) cup" : "\(coffeeAmount) cups", value: $coffeeAmount, systemImage: "mug.fill")
                Spacer()
            }
            .padding()
            .navigationTitle("Better Sleep")
            .toolbar {
                Button {
                    calculateBedtime()
                } label: {
                    Image(systemName: "command")
                }.buttonStyle(PlainButtonStyle())
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func convertDecimalToTime(_ decimal: Double) -> String {
        let hours = Int(decimal)
        let minutes = Int((decimal - Double(hours)) * 60)
        return String(format: "%d:%02d", hours, minutes)
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 3600
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep

            alertTitle = "Your ideal bedtime is…"
            alertMessage = LocalizedStringKey(sleepTime.formatted(date: .omitted, time: .shortened))
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }

        showingAlert = true
    }
}

#Preview("English") {
    ContentView()
        .environment(\.locale, .init(identifier: "en"))
}

#Preview("Ukrainian") {
    ContentView()
        .environment(\.locale, .init(identifier: "uk"))
}
