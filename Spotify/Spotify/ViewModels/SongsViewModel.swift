//
//  SongsViewModel.swift
//  Spotify
//
//  Created by dennis savchenko on 12/11/2024.
//

import Foundation

@Observable
class SongsViewModel {
    
    var songs: [Song] = []
    
    init() {
        songs = tracks_1 + tracks_2 + tracks_3 + tracks_5
    }
    
    func getArtistsSongs(artist: Artist) -> [Song] {
        songs.filter { $0.artists.contains { $0.id == artist.id } }
    }
    
    func getSongsOfAlbum(album: Album) -> [Song] {
        songs.filter { $0.album.id == album.id }
    }
    
}
