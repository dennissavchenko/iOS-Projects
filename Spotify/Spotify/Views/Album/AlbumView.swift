//
//  AlbumView.swift
//  Spotify
//
//  Created by dennis savchenko on 11/11/2024.
//

import SwiftUI
import SwiftfulUI

struct AlbumView: View {
    
    var album: Album
    
    @Environment(Player.self) private var player
    @Environment(SongsViewModel.self) private var songsViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showHeader: Bool = false
    @State private var offset: CGFloat = 0
    @State private var initialOffset: CGFloat? = nil
    @State var isPlayerPresented = false
    
    let side: CGFloat = 264
    
    var safeArea: UIEdgeInsets? {
        getSafeAreaInsets()
    }
    
    var headerOffset: Double {
        Double(initialOffset ?? 486) - Double(safeArea?.top ?? 0) - 219
    }
    
    let screenWidht = UIScreen.main.bounds.width
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    AlbumCover(album: album)
                        .readingFrame { frame in
                            offset = frame.maxY
                            if initialOffset == nil && offset > 0 {
                                initialOffset = offset
                            }
                            if offset < headerOffset {
                                showHeader = true
                            } else {
                                showHeader = false
                            }
                        }
                    ForEach(songsViewModel.getSongsOfAlbum(album: album)) { song in
                        SongView(song: song)
                            .onTapGesture {
                                player.songs = songsViewModel.getSongsOfAlbum(album: album)
                                if player.currentSong == nil {
                                    isPlayerPresented.toggle()
                                }
                                player.playSong(song: song)
                            }
                    }
                    .padding(12)
                }.padding(.bottom, 80)
            }
            .scrollIndicators(.hidden)
            Header(album: album)
        }
        .toolbar(.hidden)
        .background(.bg)
        .fullScreenCover(isPresented: $isPlayerPresented) {
            PlayerView()
                .environment(player)
        }
        
    }
    
    func Header(album: Album) -> some View {
        ZStack {
            Text(album.name)
                .font(.headline)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .opacity(showHeader ? (headerOffset - Double(offset)) / 68 : 0)
                .offset(y: (4 - (headerOffset - Double(offset)) / 17) > 0 ? (4 - (headerOffset - Double(offset)) / 17) : 0)
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .padding()
                    .background(.clear)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.white)
        .background(LinearGradient(colors: [album.themeColor.darkenedColor(by: 0.55), album.themeColor.darkenedColor(by: 0.815)], startPoint: .top, endPoint: .bottom).opacity(showHeader ? 1 : 0).ignoresSafeArea())
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func AlbumCover(album: Album) -> some View {
        Rectangle()
            .opacity(0)
            .overlay (
                VStack {
                    Image(album.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: offset > 0 ? side * (offset / (initialOffset ?? CGFloat(486))) >  screenWidht - 32 ? screenWidht - 32 : CGFloat(side) * (offset / (initialOffset ?? CGFloat(486))) : 0, height: offset > 0 ? side * (offset / (initialOffset ?? CGFloat(486))) > screenWidht - 32 ? screenWidht - 32 : side * (offset / (initialOffset ?? CGFloat(486))) : 0)
                        .opacity((Double(offset) - (initialOffset ?? CGFloat(486))) / 200 + 1)
                        .clipped()
                        .shadow(radius: 20)
                    Rectangle()
                        .opacity(0)
                        .frame(height: 56)
                }
            )
            .overlay (
                VStack(alignment: .leading, spacing: 6) {
                    Text(album.name)
                        .lineLimit(1)
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundStyle(.white)
                    ArtistSmallView(artist: album.artist)
                    Text("Album · \(String(album.releaseYear))")
                        .foregroundStyle(Color(.systemGray2))
                        .font(.footnote)
                }
                .padding(16),
                alignment: .bottomLeading
            )
            .background(LinearGradient(colors: [album.themeColor, .bg], startPoint: .top, endPoint: .bottom))
            .asStretchyHeader(startingHeight: 362 + (safeArea?.top ?? 0))
    }
    
    func getSafeAreaInsets() -> UIEdgeInsets? {
        guard let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })
        else {
            print("No key window found.")
            return nil
        }
        return keyWindow.safeAreaInsets
    }
    
}

#Preview {
    AlbumView(album: album_5)
        .environment(SongsViewModel())
        .environment(Player())
}
