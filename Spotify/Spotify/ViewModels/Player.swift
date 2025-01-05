import Foundation
import AVFoundation
import MediaPlayer

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
    
    var duration: Int {
        Int(player?.duration ?? 0)
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
        
        setupRemoteCommandCenter()
        
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
            updateNowPlayingInfo()
        } catch {
            return
        }
        
    }
    
    func setTime(time: Double) {
        player?.currentTime = time
        updateNowPlayingInfo()
    }

    func pause() {
        player?.pause()
        isPlayingState = false
        updateNowPlayingInfo()
    }
    
    func play() {
        player?.play()
        isPlayingState = true
        updateNowPlayingInfo()
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

    func updateNowPlayingInfo() {
        guard let player = player else { return }
        
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = currentSong?.title
        nowPlayingInfo[MPMediaItemPropertyArtist] = currentSong?.artistsToString
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = currentSong?.album.name
        
        if let image = UIImage(named: currentSong?.album.imageName ?? "") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { _ in image }
        }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate

        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { [weak self] event in
            self?.play()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] event in
            self?.pause()
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget { event in
            self.nextSong()
            return .success
        }
        
        commandCenter.previousTrackCommand.addTarget { event in
            self.previousSong()
            return .success
        }
        
        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
                guard let self = self, let player = self.player,
                      let playbackEvent = event as? MPChangePlaybackPositionCommandEvent else {
                    return .commandFailed
                }
                
                self.setTime(time: playbackEvent.positionTime)
                return .success
            }
        
    }

    
}
