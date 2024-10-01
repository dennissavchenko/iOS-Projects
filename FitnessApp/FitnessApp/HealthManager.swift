//
//  HealthManager.swift
//  FitnessApp
//
//  Created by dennis savchenko on 14/09/2024.
//

import Foundation
import HealthKit

extension Date {
    static var lastMonth: Date {
        Calendar.current.date(byAdding: .day, value: -30, to: Date.now)!
    }
}

extension Double {
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    @Published var activities: [Activity] = []
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let healthTypes: Set = [steps, calories]
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                fetchTodaySteps()
                fetchTodayCalories()
            } catch {
                print("Error fetching health data!")
            }
        }
    }
    
    func fetchTodaySteps() {
        
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .lastMonth, end: Date.now)
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching steps data!")
                return
            }
            
            let stepCount = quantity.doubleValue(for: .count())
            
            let activity = Activity(title: "Average", subtitle: "Goal: 10 000", image: "figure.walk", amount: (stepCount / 31).formattedString(), imageColor: .blue)
            
            DispatchQueue.main.async {
                self.activities.append(activity)
            }
            
            print(stepCount.formattedString())
            
        }
        
        healthStore.execute(query)
        
    }
    
    func fetchTodayCalories() {
        
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .lastMonth, end: Date.now)
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching calories data!")
                return
            }
            
            let caloriesCount = quantity.doubleValue(for: .kilocalorie())
            
            let activity = Activity(title: "Active energy", subtitle: "Goal: 800", image: "flame.fill", amount: (caloriesCount / 31).formattedString(), imageColor: .orange)
            
            DispatchQueue.main.async {
                self.activities.append(activity)
            }
            
            print(caloriesCount.formattedString())
            
        }
        
        healthStore.execute(query)
        
    }
    
}
