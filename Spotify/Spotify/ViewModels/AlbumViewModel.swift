//
//  AlbumViewModel.swift
//  Spotify
//
//  Created by dennis savchenko on 12/11/2024.
//

import Foundation

@Observable
class AlbumsViewModel {
    
    var albums: [Album]
    
    init() {
        albums = [album_2, album_3, album_5]
    }
    
    func getArtistsAlbums(artist: Artist) -> [Album] {
        albums.filter { $0.artist.id == artist.id }
    }
    
}
