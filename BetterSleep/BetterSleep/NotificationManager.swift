//
//  NotificationManager.swift
//  BetterSleep
//
//  Created by dennis savchenko on 10/11/2024.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    func scheduleNotification(hour: Int, minute: Int) {
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Better Sleep"
        content.body = "It's time to sleep!"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: calendarTrigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func setBadgeCount(_ count: Int) {
        UNUserNotificationCenter.current().setBadgeCount(count)
    }
    
}
