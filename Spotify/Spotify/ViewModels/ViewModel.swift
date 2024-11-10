//
//
//  Bible
//
//  Created by Денис Савченко on 16/02/2023.
//

import Foundation
import SwiftUI

extension Player {
    @MainActor class ViewModel: ObservableObject {
        init() { UISlider.appearance().setThumbImage(UIImage.init(named: "thumb"), for: .normal) }
        @Published var percentage: Double = 0
        @Published var isPlaying: Bool = false
        @Published var buttonImage: String = "buttonPlay"
        @Published var index: Int = 0
        @Published var timeSec: Int = 0
        @Published var timeSec10: Double = 0
        @Published var timeLeftSec: Int = 0
        @Published var isEditing: Bool = false
        @Published var shuffleColor: String = "white"
        @Published var repeatColor: String = "white"
        @Published var album_index: Int = 0
        
        let countDownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        let countDownTimer10 = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        
        func setAlbumIndex(ind: Int) {
            album_index = ind
        }
        
        func getTextBackground() -> String {
            return songs[album_index][index].album.color_set.lyricsBackground
        }
        
        func getSingers(artists: [String]?) -> String {
            if artists == nil {
                return "Lana Del Rey"
            } else {
                var result = "Lana Del Rey"
                for i in 0..<(artists?.count ?? 0) {
                    result += ", \(artists?[i] ?? "")"
                }
                return result
            }
        }
            
            func onAppear() {
                timeLeftSec = songs[album_index][index].time
            }
            
            func onChange() {
                timeSec = (Int)(timeSec10)
                timeLeftSec = songs[album_index][index].time - timeSec
            }
            
            func timeOnReceive() {
                if isPlaying {
                    if timeSec >= songs[album_index][index].time {
                        if repeatColor == "white" {
                            right()
                        } else {
                            reset()
                        }
                    } else {
                        timeSec += 1
                    }
                }
            }
            
            func onEditing(editing: Bool) {
                if !editing && isPlaying {
                    playSound(time: timeSec10, song: songs[album_index][index].id)
                }
            }
            
            func timeOnReceive10() {
                if !isPlayerPlaying() && getPlayer() != nil {
                    isPlaying = true
                    play()
                }
                if isPlaying {
                    timeSec10 += 0.01
                    percentage = timeSec10 / (Double)(songs[album_index][index].time)
                }
            }
            
            func timeLeftOnReceive() {
                if isPlaying {
                    timeLeftSec -= 1
                }
            }
            
            func getLyrics() -> String {
                return readFileContents(song: songs[album_index][index].id) ?? "not found"
            }
            
            func shuffle() {
                if shuffleColor == "white" {
                    shuffleColor = "AccentColor"
                } else {
                    shuffleColor = "white"
                }
            }
            
            func repeatSong() {
                if repeatColor == "white" {
                    repeatColor = "AccentColor"
                } else {
                    repeatColor = "white"
                }
            }
            func play() {
                if isPlaying == false {
                    isPlaying = true
                    buttonImage = "buttonPause"
                    playSound(time: timeSec10, song: songs[album_index][index].id)
                } else {
                    isPlaying = false
                    buttonImage = "buttonPlay"
                    pauseSound(song: songs[album_index][index].id)
                }
            }
            func reset() {
                timeSec = 0
                timeLeftSec = songs[album_index][index].time
                percentage = 0
                timeSec10 = 0
                if isPlaying {
                    playSound(time: timeSec10, song: songs[album_index][index].id)}
            }
            func right() {
                if shuffleColor == "white" {
                    if index + 1 >= songs[album_index].count {
                        index = 0
                        reset()
                    } else {
                        index += 1
                        reset()
                    }
                } else {
                    index = Int.random(in: 0..<songs[album_index].count)
                    reset()
                }
            }
            func left() {
                if shuffleColor == "white" {
                    if index - 1 == -1 {
                        index = songs[album_index].count - 1
                        reset()
                    } else {
                        index -= 1
                        reset()
                    }
                } else {
                    index = Int.random(in: 0..<songs[album_index].count)
                    reset()
                }
            }
            func timer(time: Int) -> String {
                let min_ = time / 60
                let sec_ = time - min_ * 60
                if sec_ < 10 {
                    return "\(min_):0\(sec_)"
                } else {
                    return "\(min_):\(sec_)"
                }
            }
        }
    }
