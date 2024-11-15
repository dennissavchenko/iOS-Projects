//
//  Structs.swift
//  Bible
//
//  Created by Денис Савченко on 16/02/2023.
//

import Foundation
import SwiftUI
import UIKit

struct Album: Identifiable {
    
    var id = UUID()
    var name: String
    var imageName: String
    var releaseYear: Int
    var artist: Artist
    
    var themeColor: Color {
        if let image = UIImage(named: imageName) {
            return Color(image.themeColor ?? UIColor.bg)
        } else {
            return .bg
        }
    }
    
}

let album_1 = Album(name: "Born To Die", imageName: "album_1", releaseYear: 2012, artist: lana_del_rey)
let album_2 = Album(name: "Paradise", imageName: "album_2", releaseYear: 2012, artist: lana_del_rey)
let album_3 = Album(name: "Ultraviolence", imageName: "album_3", releaseYear: 2014, artist: lana_del_rey)
let album_5 = Album(name: "Lust For Life", imageName: "album_5", releaseYear: 2017, artist: lana_del_rey)

