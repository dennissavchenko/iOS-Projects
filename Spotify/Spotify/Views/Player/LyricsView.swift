//
//  LyricsView.swift
//  Spotify
//
//  Created by dennis savchenko on 27/12/2024.
//

import SwiftUI

struct LyricsView: View {
    
    @Environment(Player.self) private var player
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var progress: Double = 0
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            player.currentSong?.album.themeColor
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "chevron.down")
                        .padding(12)
                        .background {
                            Circle()
                                .foregroundStyle(.black.opacity(0.2))
                        }
                        .onTapGesture {
                            dismiss()
                        }
                        .frame(width: 40, height: 40)
                    Spacer()
                    VStack {
                        Text(player.currentSong?.title ?? "")
                            .fontWeight(.semibold)
                        Text(player.currentSong?.artistsToString ?? "")
                    }.font(.footnote)
                    Spacer()
                    Image(systemName: "flag")
                        .font(.title2)
                        .fontWeight(.medium)
                        .frame(width: 40, height: 40)
                }
                ScrollView {
                    Text(readFileContents(song: player.currentSong?.id ?? "#10_3") ?? "")
                        .padding(.vertical, 30)
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineSpacing(8)
                }
                .overlay(alignment: .top, content: {
                    Rectangle()
                        .frame(height: 40)
                        .foregroundStyle(LinearGradient(colors: [player.currentSong?.album.themeColor ?? .blue, .blue.opacity(0)], startPoint: .top, endPoint: .bottom))
                })
                .overlay(alignment: .bottom, content: {
                    Rectangle()
                        .frame(height: 40)
                        .foregroundStyle(LinearGradient(colors: [player.currentSong?.album.themeColor ?? .blue, .blue.opacity(0)], startPoint: .bottom, endPoint: .top))
                })
                .scrollIndicators(.hidden)
                SongSlider
                SongControlls
                    .padding(.top, -20)
            }
            .padding()
            .foregroundStyle(.white)
            .onReceive(timer) { _ in
                if let currentTime = player.currentTime {
                    progress = currentTime
                }
            }
        }
    }
    
    var SongControlls: some View {
        HStack {
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
        }
    }
    
    var SongSlider: some View {
        VStack(spacing: 2) {
            Slider(value: $progress, in: 0...Double(player.duration)) { editing in
                    if !editing {
                        player.setTime(time: progress)
                    }
                }
                .tint(.white)
                .onAppear {
                    let progressCircleConfig = UIImage.SymbolConfiguration(scale: .small)
                    UISlider.appearance().setThumbImage(UIImage(systemName: "circle.fill", withConfiguration: progressCircleConfig), for: .normal)
                    UISlider.appearance().maximumTrackTintColor = UIColor.white.withAlphaComponent(0.1)
                }
            HStack {
                Text(secondsToTime(Int(progress)))
                Spacer()
                Text("-\(secondsToTime(player.duration - Int(progress)))")
            }
            .font(.caption)
            .foregroundStyle(Color(.systemGray4))
        }
    }
    
    func secondsToTime(_ seconds: Int) -> String {
        let minutes = Int(seconds / 60)
        let seconds = seconds % 60
        return String(format: "%0d:%02d", minutes, seconds)
    }
    
}

#Preview {
    LyricsView()
        .environment(Player())
}
