//
//  SongView.swift
//  Spotify
//
//  Created by dennis savchenko on 13/11/2024.
//

import SwiftUI

struct SongView: View {
    
    @Environment(Player.self) private var player
    
    @State private var barHeights: [CGFloat] = [2, 2, 2]
    
    @State private var timer: Timer? = nil
    
    @State private var isAnimating: Bool = false
    
    var song: Song
    
    var isChosen: Bool {
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
                HStack(alignment: .bottom, spacing: 6) {
                    if isChosen {
                        histogram
                            .padding(.bottom, 4)
                    }
                    Text(song.title)
                        .foregroundStyle(isChosen ? .accent : .white)
                        .fontWeight(.medium)
                        .lineLimit(1)
                }
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
    
    var histogram: some View {
        HStack(spacing: 2) {
            ForEach(0..<3, id: \.self) { index in
                Rectangle()
                    .fill(.accent)
                    .frame(width: 2, height: barHeights[index])
                    .frame(maxHeight: 10, alignment: .bottom) // Ensures bottom alignment
                    .animation(
                        .easeInOut(duration: 0.3),
                        value: barHeights[index]
                    )
            }
        }
        .onChange(of: player.isPlayingState) {
            print("hello")
            if player.currentSong?.id == song.id && player.isPlayingState {
                startAnimatingBars()
            } else {
                stopAnimatingBars()
            }
        }
        .onAppear {
            if player.currentSong?.id == song.id && player.isPlayingState {
                startAnimatingBars()
            }
        }
        .onDisappear {
            stopAnimatingBars()
        }
    }
    
//    private func startAnimatingBars() {
//        stopAnimatingBars()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
//            barHeights = barHeights.map { _ in CGFloat.random(in: 2...10) }
//        }
//    }
//
//    private func stopAnimatingBars() {
//        timer?.invalidate()
//        timer = nil
//        barHeights = [2, 2, 2]
//    }
    
    private func startAnimatingBars() {
        isAnimating = true
        Task {
            while isAnimating {
                barHeights = barHeights.map { _ in CGFloat.random(in: 2...10) }
                try? await Task.sleep(nanoseconds: 300_000_000) // 300 ms
            }
        }
    }

    private func stopAnimatingBars() {
        isAnimating = false
        barHeights = [2, 2, 2]
    }
    
}

#Preview {
    SongView(song: track_1_1)
        .environment(Player())
}
