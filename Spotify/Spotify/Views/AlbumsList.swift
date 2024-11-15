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
    
    var sortedAlbums: [Album] {
        albumsViewModel.getArtistsAlbums(artist: artist).sorted { $0.releaseYear > $1.releaseYear }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    Header(artist: artist)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Popular Relases")
                            .fontWeight(.medium)
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
            }
            .scrollIndicators(.hidden)
            .background(.bg)
            .ignoresSafeArea()
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
}
