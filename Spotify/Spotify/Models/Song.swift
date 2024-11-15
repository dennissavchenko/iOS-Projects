//
//  Song.swift
//  Bible
//
//  Created by Денис Савченко on 16/02/2023.
//

import Foundation

struct Song: Identifiable {
    
    var id: String
    var title: String
    var artists: [Artist]
    var album: Album
    var time: Int
    
    var artistsToString: String {
        if artists.isEmpty {
            return "Not Found :("
        } else {
            return artists.map { $0.name }.joined(separator: ", ")
        }
    }
    
}

//album_1

let track_1_1 = Song(id: "#1_1", title: "Born To Die", artists: [lana_del_rey], album: album_1, time: 286)

let tracks_1 = [track_1_1]

//album_2

let track_1_2 =  Song(id: "#1_2", title: "Ride", artists: [lana_del_rey], album: album_2, time: 289)

let tracks_2 = [track_1_2]

//album_3

let track_1_3 = Song(id: "#1_3", title: "Cruel World", artists: [lana_del_rey], album: album_3, time: 400)

let track_2_3 = Song(id: "#2_3", title: "Ultraviolence", artists: [lana_del_rey], album: album_3, time: 251)

let track_3_3 = Song(id: "#3_3", title: "Shades of Color", artists: [lana_del_rey], album: album_3, time: 342)

let track_4_3 = Song(id: "#4_3", title: "Brooklyn Baby", artists: [lana_del_rey], album: album_3, time: 351)

let track_5_3 = Song(id: "#5_3", title: "West Coast", artists: [lana_del_rey], album: album_3, time: 256)

let track_6_3 = Song(id: "#6_3", title: "Sad Girl", artists: [lana_del_rey], album: album_3, time: 317)

let track_7_3 = Song(id: "#7_3", title: "Pretty When You Cry", artists: [lana_del_rey], album: album_3, time: 234)

let track_8_3 = Song(id: "#8_3", title: "Money Power Glory", artists: [lana_del_rey], album: album_3, time: 270)

let track_9_3 = Song(id: "#9_3", title: "****** My Way Up to the Top", artists: [lana_del_rey], album: album_3, time: 212)

let track_10_3 = Song(id: "#10_3", title: "Old Money", artists: [lana_del_rey], album: album_3, time: 271)

let track_11_3 = Song(id: "#11_3", title: "The Other Woman", artists: [lana_del_rey], album: album_3, time: 182)

let tracks_3 = [track_1_3, track_2_3, track_3_3, track_4_3, track_5_3, track_6_3, track_7_3, track_8_3, track_9_3, track_10_3, track_11_3]

//album_5

let track_1_5 = Song(id: "#1_5", title: "Love", artists: [lana_del_rey], album: album_5, time: 272)

let track_2_5 = Song(id: "#2_5", title: "Lust For Life", artists: [lana_del_rey], album: album_5, time: 263)

let track_3_5 = Song(id: "#3_5", title: "13 Beaches", artists: [lana_del_rey], album: album_5, time: 295)

let track_4_5 = Song(id: "#4_5", title: "Cherry", artists: [lana_del_rey], album: album_5, time: 180)

let track_5_5 = Song(id: "#5_5", title: "White Mustang", artists: [lana_del_rey], album: album_5, time: 164)

let track_6_5 = Song(id: "#6_5", title: "Summer Bummer", artists: [lana_del_rey], album: album_5, time: 260)

let track_7_5 = Song(id: "#7_5", title: "Goupie Love", artists: [lana_del_rey], album: album_5, time: 264)

let track_8_5 = Song(id: "#8_5", title: "In My Feelings", artists: [lana_del_rey], album: album_5, time: 238)

let track_9_5 = Song(id: "#9_5", title: "Coachella - Woodstock In My Mind", artists: [lana_del_rey], album: album_5, time: 258)

let track_10_5 = Song(id: "#10_5", title: "God Bless America - And All The Beautiful Women In It", artists: [lana_del_rey], album: album_5, time: 276)

let track_11_5 = Song(id: "#11_5", title: "When the World Was at War We Kept Dancing", artists: [lana_del_rey], album: album_5, time: 275)

let track_12_5 = Song(id: "#12_5", title: "Beautiful People Beautiful Problems", artists: [lana_del_rey, stevie_nicks], album: album_5, time: 253)

let track_13_5 = Song(id: "#13_5", title: "Tomorrow Never Came", artists: [lana_del_rey],  album: album_5, time: 307)

let track_14_5 = Song(id: "#14_5", title: "Heroin", artists: [lana_del_rey], album: album_5, time: 355)

let track_15_5 = Song(id: "#15_5", title: "Change", artists: [lana_del_rey], album: album_5, time: 321)

let track_16_5 = Song(id: "#16_5", title: "Get Free", artists: [lana_del_rey], album: album_5, time: 334)

let tracks_5 = [track_1_5, track_2_5, track_3_5, track_4_5, track_5_5, track_6_5, track_7_5, track_8_5, track_9_5, track_10_5, track_11_5, track_12_5, track_13_5, track_14_5, track_15_5, track_16_5]

// all albums

let songs = [tracks_1, tracks_2, tracks_3, tracks_5]
