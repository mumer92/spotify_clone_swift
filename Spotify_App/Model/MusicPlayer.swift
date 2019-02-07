//
//  MusicPlayer.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 7.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation

class MusicPlayer {
    
    //MARK: - Variables
    var songs : [Track] = [] {
        didSet {
            print("\n\n\n TAMAM TAMAM TAMAM songs count : " , songs.count)
        }
    }
    var songsBackup : [Track] = []
    var isShuffled : Bool = false
    var isPlaying : Bool = false
    var repeatPlaylist : Bool = false
    var isSmall : Bool = false
    var currentSongIndex: Int = 0 {
        didSet {
            if currentSongIndex < 0  { // repeatPlayList = true
                if repeatPlaylist {
                    currentSongIndex = songs.count - 1
                } else {
                    currentSongIndex = 0
                }
            } else if currentSongIndex == songs.count { // repeatPlayList = true
                if repeatPlaylist {
                    currentSongIndex = 0
                } else {
                    currentSongIndex = songs.count - 1
                }
            }
        }
    }
    
    //MARK: - Initialization
    init() {}
    init(songs: [Track], isPlaying: Bool, isSmall: Bool, currentSongIndex: Int, isShuffled: Bool, repeatPlaylist: Bool) {
        self.songs = songs
        self.currentSongIndex = currentSongIndex
        self.isPlaying = isPlaying
        self.isShuffled = isShuffled
        self.repeatPlaylist = repeatPlaylist
        self.songsBackup = songs
    }
    
}

