//
//  File.swift
//  Bible
//
//  Created by Денис Савченко on 15/02/2023.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer!

func getPlayer() -> AVAudioPlayer? {
    return player
}

func isPlayerPlaying() -> Bool {
    if player == nil {
       return false
    } else {
        return player.isPlaying
    }
}

func playSound(time: Double, song: String) {
    
    let audioSession = AVAudioSession.sharedInstance()
    
    let url = Bundle.main.url(forResource: song, withExtension: "mp3")
    
    guard url != nil else {
        return
    }
    
    do {
        try audioSession.setCategory(.playback, mode: .default, options: [])
        try audioSession.setActive(true, options: [])
        
        player = try AVAudioPlayer(contentsOf: url!)
        player.currentTime = time
        player?.play()
    } catch {
        print("error")
    }
}

func pauseSound(song: String) {
    let url = Bundle.main.url(forResource: song, withExtension: "mp3")
    guard url != nil else {
        return
    }
    
    do {
        player = try AVAudioPlayer(contentsOf: url!)
        player?.stop()
    } catch {
        print("error")
    }
}
