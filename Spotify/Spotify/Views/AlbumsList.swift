//
//  AlbumsList.swift
//  Spotify
//
//  Created by Денис Савченко on 16/02/2023.
//

import SwiftUI
import SwiftfulUI

struct AlbumsList: View {
    
    var artist: Artist = lana_del_rey
    
    @Environment(AlbumsViewModel.self) private var albumsViewModel
    @Environment(SongsViewModel.self) private var songViewModel
    @Environment(Player.self) private var player
    
    @State private var isPlayerPresented: Bool = false
    
    var sortedAlbums: [Album] {
        albumsViewModel.getArtistsAlbums(artist: artist).sorted { $0.releaseYear > $1.releaseYear }
    }
    
    var sortedSongs: [Song] {
        songViewModel.getArtistsSongs(artist: artist).sorted { $0.playedTimes > $1.playedTimes }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    Header(artist: artist)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Popular")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        ForEach(sortedSongs.prefix(5)) { song in
                            HStack(spacing: 16) {
                                Text(((sortedSongs.firstIndex { $0.id == song.id} ?? 0) + 1).formatted())
                                    .foregroundStyle(.white)
                                    .font(.footnote)
                                Image(song.album.imageName)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                SongView(song: song, isPopular: true)
                                    .onTapGesture {
                                        player.songs = sortedSongs
                                        if player.currentSong == nil {
                                            isPlayerPresented.toggle()
                                        }
                                        player.playSong(song: song)
                                    }
                            }
                        }
                        Text("Popular Relases")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        ForEach(sortedAlbums) { album in
                            NavigationLink {
                                AlbumView(album: album)
                            } label: {
                                AlbumListItem(album: album)
                            }
                        }
                    }.padding()
                }
                .padding(.bottom, 100)
            }
            .scrollIndicators(.hidden)
            .background(.bg)
            .ignoresSafeArea()
        }
        .overlay(alignment: .bottom) {
            if player.currentSong != nil && isPlayerPresented == false {
                SmallPlayerView()
                    .padding(8)
                    .environment(player)
                    .shadow(color: .bg, radius: 10)
                    .onTapGesture {
                        isPlayerPresented.toggle()
                    }
            }
        }
        .fullScreenCover(isPresented: $isPlayerPresented) {
            PlayerView()
                .environment(player)
        }
    }
    
    func Header(artist: Artist) -> some View {
        Rectangle()
            .opacity(0)
            .overlay (
                Image(artist.imageName)
                    .resizable()
                    .scaledToFill()
            )
            .overlay(
                Text(artist.name)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .bottomLeading), alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: 300)
    }
    
}

#Preview {
    AlbumsList()
        .environment(AlbumsViewModel())
        .environment(SongsViewModel())
        .environment(Player())
}
