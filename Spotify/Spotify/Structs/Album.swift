//
//  Structs.swift
//  Bible
//
//  Created by Денис Савченко on 16/02/2023.
//

import Foundation

struct Album {
    var name: String
    var picture: String
    var releaseYear: Int
    var color_set: ColorSet
}

let album_1 = Album(name: "Born To Die", picture: "album_1", releaseYear: 2012, color_set: color_set_1)

let album_2 = Album(name: "Paradise", picture: "album_2", releaseYear: 2012, color_set: color_set_2)

let album_5 = Album(name: "Lust For Life", picture: "album_5", releaseYear: 2017, color_set: color_set_5)

let album_3 = Album(name: "Ultraviolence", picture: "album_3", releaseYear: 2014, color_set: color_set_3)

let albums = [album_1, album_2, album_3, album_5]
