//
//  Singer.swift
//  Spotify
//
//  Created by dennis savchenko on 11/11/2024.
//

import Foundation

struct Artist: Identifiable {
    
    var id = UUID()
    var name: String
    var bio: String
    var imageName: String
    
}

let lana_del_rey = Artist(name: "Lana Del Rey", bio: "Lana Del Rey is a singer-songwriter known for her cinematic, melancholic sound and haunting lyrics that explore themes of love, loss, and Americana. Her music blends vintage vibes with modern influences, creating a unique style that’s captivated audiences worldwide. With albums like Born to Die, Ultraviolence, and Norman F**king Rockwell!, Lana has established herself as an icon of dreamy pop and nostalgic storytelling.", imageName: "lana_del_rey")

let stevie_nicks = Artist(name: "Stevie Nicks", bio: "Stevie Nicks is a legendary singer-songwriter known for her mystical stage presence and poetic lyrics. As the iconic voice behind Fleetwood Mac hits like Rhiannon and Dreams, she also carved out a successful solo career with songs like Edge of Seventeen. With her ethereal style and enchanting voice, Nicks remains one of rock’s most influential female artists, inspiring generations with her music and unique artistry.", imageName: "stevie_nicks")
