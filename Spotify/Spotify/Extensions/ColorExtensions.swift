//
//  ColorExtensions.swift
//  Spotify
//
//  Created by dennis savchenko on 15/11/2024.
//

import SwiftUI
import UIKit

extension Color {
    
    func darkenedColor(by ratio: Double) -> Color {
        
        let clampedRatio = max(0, min(ratio, 1))
        
        let targetColor = UIColor.bg
        let startColor = UIColor(self)
        
        var red1: CGFloat = 0, green1: CGFloat = 0, blue1: CGFloat = 0, alpha1: CGFloat = 0
        var red2: CGFloat = 0, green2: CGFloat = 0, blue2: CGFloat = 0, alpha2: CGFloat = 0
        
        startColor.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        targetColor.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        
        let red = red1 + (red2 - red1) * clampedRatio
        let green = green1 + (green2 - green1) * clampedRatio
        let blue = blue1 + (blue2 - blue1) * clampedRatio
        let alpha = alpha1 + (alpha2 - alpha1) * clampedRatio
        
        return Color(UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    func makeColorBrighter(amount: CGFloat) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        // Convert Color to UIColor to access HSB components
        if UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            // Increase brightness, ensuring it doesn't exceed 1.0
            brightness = min(brightness + amount, 1.0)
            return Color(hue: hue, saturation: saturation, brightness: brightness)
        }
        
        return self // Return the original color if conversion fails
    }
    
    func makeColorDarker(amount: CGFloat) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        // Convert Color to UIColor to access HSB components
        if UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            // Decrease brightness, ensuring it doesn't go below 0.0
            brightness = max(brightness - amount, 0.0)
            return Color(hue: hue, saturation: saturation, brightness: brightness)
        }
        
        return self // Return the original color if conversion fails
    }
    
}
