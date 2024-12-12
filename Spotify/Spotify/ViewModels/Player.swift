import Foundation
import AVFoundation

enum RepeatMode {
    case none
    case all
    case one
}

@Observable
class Player: NSObject, AVAudioPlayerDelegate {
    
    var player: AVAudioPlayer?
    var currentSong: Song?
    var songs: [Song] = []
    
    var isPlayingState: Bool = false
    
    var isPlaying: Bool {
        if let player = player {
            return player.isPlaying
        } else {
            return false
        }
    }
    
    var shuffle = false
    var repeatMode: RepeatMode = .none
    
    var progress: Double? {
        if let player = player {
            return player.currentTime / player.duration
        } else {
            return nil
        }
    }
    
    var currentTime: Double? {
        player?.currentTime
    }
    
    override init() {
        
        super.init()
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true, options: [])
        } catch {
            return
        }
        
    }
    
    func playSong(song: Song) {
        
        currentSong = song
        
        let url = Bundle.main.url(forResource: song.id, withExtension: "mp3")
        
        guard url != nil else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.delegate = self
            player?.currentTime = 0
            player?.play()
            isPlayingState = true
        } catch {
            return
        }
        
    }
    
    func setTime(time: Double) {
        player?.currentTime = time
    }

    func pause() {
        player?.pause()
        isPlayingState = false
    }
    
    func play() {
        player?.play()
        isPlayingState = true
    }
    
    private func getCurrentSongIndex() -> Int? {
        if let currentIndex = songs.firstIndex(where: { $0.id == currentSong?.id }) {
            return currentIndex
        } else {
            return nil
        }
    }
    
    func randomSong() {
        let random = Int.random(in: 0..<songs.count)
        playSong(song: songs[random])
    }
    
    func nextSong() {
        if shuffle {
            randomSong()
        } else {
            if let currentIndex = getCurrentSongIndex() {
                let nextIndex = (currentIndex + 1) % songs.count
                playSong(song: songs[nextIndex])
            }
        }
    }
    
    func previousSong() {
        if shuffle {
            randomSong()
        } else {
            if let currentIndex = getCurrentSongIndex() {
                let previousIndex = (currentIndex - 1 + songs.count) % songs.count
                playSong(song: songs[previousIndex])
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if repeatMode == .one {
            if let currentSong = currentSong {
                playSong(song: currentSong)
            }
        } else if repeatMode == .all {
            nextSong()
        } else {
            if let currentIndex = getCurrentSongIndex() {
                if currentIndex != songs.count - 1 {
                    nextSong()
                } else {
                    pause()
                }
            }
        }
    }
    
}
