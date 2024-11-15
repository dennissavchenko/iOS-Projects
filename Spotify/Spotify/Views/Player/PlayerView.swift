//
//  PlayerView.swift
//  Spotify
//
//  Created by dennis savchenko on 15/11/2024.
//

import SwiftUI

struct PlayerView: View {
    
    @Environment(Player.self) private var player
    
    @State private var progress: Double = 0
    
    @Environment(\.dismiss) private var dismiss
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 52) {
                HStack {
                    Image(systemName: "chevron.down")
                        .font(.title2)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                    Text(player.currentSong?.album.name ?? "")
                        .font(.callout)
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .font(.title2)
                }
                Image(player.currentSong?.album.imageName ?? "")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(4)
                    .shadow(radius: 10)
                VStack(spacing: 16) {
                    SongInfo
                    SongSlider
                    SongControlls
                }
                AboutArtist
                Lyrics
            }
            .padding()
            .foregroundStyle(.white)
            .background(LinearGradient(colors: [player.currentSong?.album.themeColor ?? .bg, .bg], startPoint: .top, endPoint: .bottom))
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
        .background {
            VStack {
                Color(player.currentSong?.album.themeColor ?? .bg)
                Color(.bg)
            }.ignoresSafeArea()
        }
        .onReceive(timer) { _ in
            if let currentTime = player.currentTime {
                progress = currentTime
            }
        }
    }
    
    func secondsToTime(_ seconds: Int) -> String {
        let minutes = Int(seconds / 60)
        let seconds = seconds % 60
        return String(format: "%0d:%02d", minutes, seconds)
    }
    
    var AboutArtist: some View {
        VStack(spacing: 0) {
            Image(player.currentSong?.album.artist.imageName ?? "")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            VStack(alignment: .leading, spacing: 16) {
                Text(player.currentSong?.album.artist.name ?? "")
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text(player.currentSong?.album.artist.bio ?? "")
                    .foregroundStyle(Color(.systemGray4))
                    .font(.callout)
                    .lineLimit(6)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.artistBioBg)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 20)
        .overlay(alignment: .topLeading) {
            Text("About the artist")
                .font(.headline)
                .fontWeight(.bold)
                .shadow(radius: 10)
                .padding()
        }
    }
    
    var Lyrics: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Lyrics")
                .fontWeight(.bold)
            Text(readFileContents(song: player.currentSong?.id ?? "") ?? "")
                .font(.title2)
                .fontWeight(.bold)
                .lineSpacing(8)
                .frame(height: 200)
        }
        .padding()
        .background(player.currentSong?.album.themeColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 20)
    }
    
    var SongInfo: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(player.currentSong?.title ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(player.currentSong?.artistsToString ?? "")
                    .foregroundStyle(Color(.systemGray4))
                    .font(.callout)
            }
            Spacer()
            Image(systemName: "plus.circle")
                .font(.title)
                .fontWeight(.medium)
        }
    }
    
    var SongControlls: some View {
        HStack {
            Image(systemName: "shuffle")
                .font(.title2)
                .foregroundStyle(player.shuffle ? .accent : .white)
                .onTapGesture {
                    player.shuffle.toggle()
                }
            Spacer()
            Image(systemName: "backward.end.fill")
                .font(.title)
                .onTapGesture {
                    player.previousSong()
                    if player.repeatMode == .one {
                        player.repeatMode = .all
                    }
                }
            Spacer()
            Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .font(.system(size: 68))
                .onTapGesture {
                    if player.isPlaying {
                        player.pause()
                    } else {
                        player.play()
                    }
                }
            Spacer()
            Image(systemName: "forward.end.fill")
                .font(.title)
                .onTapGesture {
                    player.nextSong()
                    if player.repeatMode == .one {
                        player.repeatMode = .all
                    }
                }
            Spacer()
            Image(systemName: player.repeatMode == .one ? "repeat.1" : "repeat")
                .font(.title2)
                .foregroundStyle(player.repeatMode == .none ? .white : .accent)
                .onTapGesture {
                    if player.repeatMode == .none {
                        player.repeatMode = .all
                    } else if player.repeatMode == .all {
                        player.repeatMode = .one
                    } else {
                        player.repeatMode = .none
                    }
                }
        }
    }
    
    var SongSlider: some View {
        VStack(spacing: 2) {
            Slider(value: $progress, in: 0...Double(player.currentSong?.time ?? 0)) { editing in
                    if !editing {
                        player.setTime(time: progress)
                    }
                }
                .tint(.white)
                .onAppear {
                    let progressCircleConfig = UIImage.SymbolConfiguration(scale: .small)
                    UISlider.appearance().setThumbImage(UIImage(systemName: "circle.fill", withConfiguration: progressCircleConfig), for: .normal)
                }
            HStack {
                Text(secondsToTime(Int(progress)))
                Spacer()
                Text("-\(secondsToTime(player.currentSong?.time ?? 0 - Int(progress)))")
            }
            .font(.caption)
            .foregroundStyle(Color(.systemGray4))
        }
    }
    
}

#Preview {
    PlayerView()
        .environment(Player())
}
