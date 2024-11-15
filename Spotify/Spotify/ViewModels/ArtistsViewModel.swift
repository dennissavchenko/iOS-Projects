//
//  SongsViewModel.swift
//  Spotify
//
//  Created by dennis savchenko on 12/11/2024.
//

import Foundation

@Observable
class ArtistsViewModel {
    
    var artists: [Artist] = []
    
    init() {
        artists = [lana_del_rey, stevie_nicks]
    }
    
}
