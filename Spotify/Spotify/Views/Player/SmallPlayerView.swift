//
//  SmallPlayerView.swift
//  Spotify
//
//  Created by dennis savchenko on 15/11/2024.
//

import SwiftUI

struct SmallPlayerView: View {
    
    @Environment(Player.self) private var player
    
    @State private var progress: Double = 0
    @State private var width: CGFloat = 0
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Image(player.currentSong?.album.imageName ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .shadow(radius: 10)
            VStack(alignment: .leading, spacing: 1) {
                Text(player.currentSong?.title ?? "")
                    .font(.footnote)
                    .foregroundStyle(.white)
                Text(player.currentSong?.artistsToString ?? "")
                    .font(.footnote)
                    .foregroundStyle(Color(.systemGray4))
            }
            Spacer()
            Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                .font(.title2)
                .onTapGesture {
                    if player.isPlaying {
                        player.pause()
                    } else {
                        player.play()
                    }
                }
                .padding(.horizontal, 8)
                .foregroundStyle(.white)
        }
        .padding(8)
        .overlay(alignment: .bottom) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white.opacity(0.4))
                    .frame(height: 3)
                    .frame(maxWidth: .infinity)
                    .background {
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    width = geometry.size.width
                                }
                        }
                    }
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .frame(width: width * progress, height: 3)
            }.padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity)
        .background(player.currentSong?.album.themeColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onReceive(timer) { _ in
            progress = player.progress ?? 0
        }
    }
}

#Preview {
    SmallPlayerView()
        .environment(Player())
}
