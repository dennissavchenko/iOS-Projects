//
//  Song.swift
//  Bible
//
//  Created by Денис Савченко on 16/02/2023.
//

import Foundation

struct Song {
    var id: String
    var song: String
    var artists: [String]?
    var time: Int
    var album: Album
    
    func getSingers(song: Song) -> String {
        if song.artists == nil {
            return "Lana Del Rey"
        } else {
            var result = "Lana Del Rey"
            for i in 0..<(song.artists?.count ?? 0) {
                result += ", \(song.artists?[i] ?? "")"
            }
            return result
        }
    }
}

//album_1

let track_1_1 = Song(id: "#1_1", song: "Born To Die", time: 286, album: album_1)

let tracks_1 = [track_1_1]

//album_2

let track_1_2 =  Song(id: "#1_2", song: "Ride", time: 289, album: album_2)

let tracks_2 = [track_1_2]

//album_3

let track_1_3 = Song(id: "#1_3", song: "Cruel World", time: 400, album: album_3)

let track_2_3 = Song(id: "#2_3", song: "Ultraviolence", time: 251, album: album_3)

let track_3_3 = Song(id: "#3_3", song: "Shades of Color", time: 342, album: album_3)

let track_4_3 = Song(id: "#4_3", song: "Brooklyn Baby", time: 351, album: album_3)

let track_5_3 = Song(id: "#5_3", song: "West Coast", time: 256, album: album_3)

let track_6_3 = Song(id: "#6_3", song: "Sad Girl", time: 317, album: album_3)

let track_7_3 = Song(id: "#7_3", song: "Pretty When You Cry", time: 234, album: album_3)

let track_8_3 = Song(id: "#8_3", song: "Money Power Glory", time: 270, album: album_3)

let track_9_3 = Song(id: "#9_3", song: "****** My Way Up to the Top", time: 212, album: album_3)

let track_10_3 = Song(id: "#10_3", song: "Old Money", time: 271, album: album_3)

let track_11_3 = Song(id: "#11_3", song: "The Other Woman", time: 182, album: album_3)

let tracks_3 = [track_1_3, track_2_3, track_3_3, track_4_3, track_5_3, track_6_3, track_7_3, track_8_3, track_9_3, track_10_3, track_11_3]

//album_5

let track_1_5 = Song(id: "#1_5", song: "Love", time: 272, album: album_5)

let track_2_5 = Song(id: "#2_5", song: "Lust For Life", artists: ["The Weekend"], time: 263, album: album_5)

let track_3_5 = Song(id: "#3_5", song: "13 Beaches", time: 295, album: album_5)

let track_4_5 = Song(id: "#4_5", song: "Cherry", time: 180, album: album_5)

let track_5_5 = Song(id: "#5_5", song: "White Mustang", time: 164, album: album_5)

let track_6_5 = Song(id: "#6_5", song: "Summer Bummer", artists: ["A$AP Rocky", "Playboi Carti"], time: 260, album: album_5)

let track_7_5 = Song(id: "#7_5", song: "Goupie Love", artists: ["A$AP Rocky"], time: 264, album: album_5)

let track_8_5 = Song(id: "#8_5", song: "In My Feelings", time: 238, album: album_5)

let track_9_5 = Song(id: "#9_5", song: "Coachella - Woodstock In My Mind", time: 258, album: album_5)

let track_10_5 = Song(id: "#10_5", song: "God Bless America - And All The Beautiful Women In It", time: 276, album: album_5)

let track_11_5 = Song(id: "#11_5", song: "When the World Was at War We Kept Dancing", time: 275, album: album_5)

let track_12_5 = Song(id: "#12_5", song: "Beautiful People Beautiful Problems", artists: ["Stevie Nicks"], time: 253, album: album_5)

let track_13_5 = Song(id: "#13_5", song: "Tomorrow Never Came", artists: ["Sean Ono Lennon"], time: 307, album: album_5)

let track_14_5 = Song(id: "#14_5", song: "Heroin", time: 355, album: album_5)

let track_15_5 = Song(id: "#15_5", song: "Change", time: 321, album: album_5)

let track_16_5 = Song(id: "#16_5", song: "Get Free", time: 334, album: album_5)

let tracks_5 = [track_1_5, track_2_5, track_3_5, track_4_5, track_5_5, track_6_5, track_7_5, track_8_5, track_9_5, track_10_5, track_11_5, track_12_5, track_13_5, track_14_5, track_15_5, track_16_5]

// all albums

let songs = [tracks_1, tracks_2, tracks_3, tracks_5]
