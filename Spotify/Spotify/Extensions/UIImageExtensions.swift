//
//  UIImageExtensions.swift
//  Spotify
//
//  Created by dennis savchenko on 14/11/2024.
//

import UIKit
import SwiftUI

extension UIImage {
    
    var themeColor: UIColor? {

        let size = CGSize(width: 10, height: 10)
        
        UIGraphicsBeginImageContext(size)
        
        self.draw(in: CGRect(origin: .zero, size: size))
        
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        guard let cgImage = resizedImage.cgImage else { return nil }
        
        // Create a Core Image representation
        let inputImage = CIImage(cgImage: cgImage)
        
        // Apply an area average filter to get the dominant color
        let filter = CIFilter(name: "CIAreaAverage", parameters: [
            kCIInputImageKey: inputImage,
            kCIInputExtentKey: CIVector(cgRect: inputImage.extent)
        ])
        
        guard let outputImage = filter?.outputImage else { return nil }
        
        // Render the output image to a bitmap
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext()
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: outputImage.extent, format: .RGBA8, colorSpace: nil)
        
        // Convert the RGBA values to a UIColor
        let red = CGFloat(bitmap[0]) / 255.0
        let green = CGFloat(bitmap[1]) / 255.0
        let blue = CGFloat(bitmap[2]) / 255.0
        let alpha = CGFloat(bitmap[3]) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
    }
}
