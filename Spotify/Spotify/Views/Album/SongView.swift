//
//  SongView.swift
//  Spotify
//
//  Created by dennis savchenko on 13/11/2024.
//

import SwiftUI

struct SongView: View {
    
    @Environment(Player.self) private var player
    
    var song: Song
    
    var isPlaying: Bool {
        if let currentSong = player.currentSong {
            if currentSong.id == song.id {
                return true
            }
        }
        return false
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(song.title)
                    .foregroundStyle(isPlaying ? .accent : .white)
                    .fontWeight(.medium)
                    .lineLimit(1)
                Text(song.artistsToString)
                    .font(.footnote)
                    .foregroundStyle(Color(.systemGray4))
            }
            Spacer()
            Image(systemName: "ellipsis")
        }
        .foregroundStyle(.white)
        .background(.bg)
    }
}

#Preview {
    SongView(song: track_1_1)
}
