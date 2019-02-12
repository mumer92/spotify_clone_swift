//
//  PlayerViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 12.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import AVFoundation

protocol PlaylistTransporter {
    func sendPlaylist(songs: [Track])
}
protocol ControlTabBarControllerDelegate: class {
    func musicPlayerFullScreenAnimation()
    func musicPlayerSmallScreenAnimation()
}

class MusicPlayerViewController: ViewController<PlayerView>, ControlCollectionViewDelegate {
    
    //MARK: - NSLayoutConstraints
    var topConstraintForAlbumsTableView : NSLayoutConstraint?
    
    //MARK: - Layout Variables
    var controlTabBarControllerDelegate: ControlTabBarControllerDelegate?
    let screenSize = UIScreen.main.bounds
    var originalTabBarFrame : CGRect?
    
    var firstTouchPosition : CGPoint?
    var locationChange: CGFloat = 0
    
    //MARK: - Music Player Variables
    var audioPlayer = AVAudioPlayer()
    var audioSession = AVAudioSession.sharedInstance()
    var timer = Timer()
    var musicPlayer = MusicPlayer() {
        didSet {
            customView.musicPlayer = musicPlayer
        }
    }
    
    var songs : [Track] = [] {
        didSet {
            customView.albumCoverCollectionView.songs = self.songs
        }
    }
    var songsBackup : [Track] = []
    var currentTime = 0.0 {
        didSet { //Set's label and slider's value by the time
            customView.secondPassedInfoLabel.text = secondsToUserTime(second: Int(currentTime))
            if currentTime > 0.0 {
                let time = Float(TimeInterval(currentTime) / audioPlayer.duration)
                customView.timeUpdaterDisplay.value = time
                customView.timeUpdaterDisplayForSmallView.value = time
            } else if currentTime == 0.0 {
                customView.timeUpdaterDisplay.value = 0
                customView.timeUpdaterDisplayForSmallView.value = 0
            }
        }
    }
    var repeatPlayList : Bool = false {
        didSet {
            musicPlayer.repeatPlaylist = repeatPlayList
            customView.musicPlayer = musicPlayer
        }
    }
    var currentSongIndex: Int = 0 {
        didSet {
            if currentSongIndex < 0  { // repeatPlayList = true
                if repeatPlayList {
                    currentSongIndex = songs.count - 1
                } else {
                    currentSongIndex = 0
                }
            } else if currentSongIndex == songs.count { // repeatPlayList = true
                if repeatPlayList {
                    currentSongIndex = 0
                } else {
                    currentSongIndex = songs.count - 1
                }
            }
            //customView.albumCoverCollectionView.currentPage = currentSongIndex
            musicPlayer.currentSongIndex = currentSongIndex
            customView.musicPlayer = musicPlayer
        }
    }
    
    var currentTrack: Track? {
        didSet {
            resetTimer()
            guard let track = currentTrack else {return}
            updateMusicPlayer(track: track)
            do { //Setting up media player
                guard let data = currentTrack?.trackData else {return}
                try audioPlayer = AVAudioPlayer(data: data)
                audioPlayer.prepareToPlay()
                
                try audioSession.setCategory(.playback, mode: .spokenAudio, options: [.mixWithOthers, .allowAirPlay])
                try audioSession.setActive(true)
            } catch {
                print("error inside currentTrack didSet")
            }
        }
    }
    var isShuffled : Bool = false {
        didSet {
            if isShuffled {
                songs = songs.shuffled()
            } else {
                songs = songsBackup
            }
            currentTrack = songs.first
            updateMusicPlayer(track: currentTrack!)
            musicPlayer.isShuffled = isShuffled
            customView.musicPlayer = musicPlayer
        }
    }
   
    
    //MARK: - Variables
    var isPlaying : Bool = false {
        didSet {
            if isPlaying {
                
                let pauseImage = UIImage(named: "pause_small")?.withRenderingMode(.alwaysTemplate)
                customView.playButton.setImage(pauseImage, for: .normal)
    
                audioPlayer.play()
                keepTrackOfAudio() // todo change function name
                if isSmall {
                    customView.playListButton.setImage(pauseImage, for: .normal)
                }
            } else {
                let playImage = UIImage(named: "play_small")?.withRenderingMode(.alwaysTemplate)
                customView.playButton.setImage(playImage, for: .normal)
                audioPlayer.pause()
                pauseTimer()
                if isSmall {
                  customView.playListButton.setImage(playImage, for: .normal)
                }
            }
            musicPlayer.isPlaying = isPlaying
            customView.musicPlayer = musicPlayer
        }
    }
    
    var isSmall: Bool = true {
        didSet {
            if isSmall {
                customView.isSmall = self.isSmall
                customView.playListButton.removeTarget(self, action: #selector(showQueue(_:)), for: .touchUpInside)
                customView.playListButton.addTarget(self, action: #selector(playPauseSong), for: .touchUpInside)
            } else {
                customView.isSmall = self.isSmall
                customView.playListButton.removeTarget(self, action: #selector(playPauseSong), for: .touchUpInside)
                customView.playListButton.addTarget(self, action: #selector(showQueue(_:)), for: .touchUpInside)
            }
            
            musicPlayer.isSmall = isSmall
            customView.musicPlayer = musicPlayer
        }
    }
    
    //MARK: - View Appareance
    override func viewDidLoad() {
        super.viewDidLoad()

//        let cv = customView.albumCoverCollectionView
//        cv.controlCollectionViewDelegate = self
        
        //Setting Songs And Media Player
        songs = getSongs() //pulling all the songs with extension
        songsBackup = songs
        currentSongIndex = 0
        isSmall = true
        musicPlayer = MusicPlayer(songs: songs, isPlaying: isPlaying, isSmall: isSmall, currentSongIndex: currentSongIndex, isShuffled: isShuffled, repeatPlaylist: repeatPlayList)
        currentTrack = songs[currentSongIndex]
        
        
        //Setting Gesture Recognizers
        customView.upDownArrowButton.addTarget(self, action: #selector(upDownArrowButtonAction), for: .touchUpInside)
        customView.playButton.addTarget(self, action: #selector(playPauseSong), for: .touchUpInside)
        customView.previousSongButton.addTarget(self, action: #selector(previousSong), for: .touchUpInside)
        customView.nextSongButton.addTarget(self, action: #selector(nextSong), for: .touchUpInside)
        customView.shuffleButton.addTarget(self, action: #selector(shuffle(_:)), for: .touchUpInside)
        customView.repeatButton.addTarget(self, action: #selector(repeatList(_:)), for: .touchUpInside)
        customView.timeUpdaterDisplay.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    func structToData(track: Track) -> Data {
        var trck = track
        return Data(bytes: &trck, count: MemoryLayout<Track>.stride)
    }
    @objc func upDownArrowButtonAction() {
        isSmall = !isSmall
        if isSmall {
             controlTabBarControllerDelegate?.musicPlayerSmallScreenAnimation()
        } else {
            controlTabBarControllerDelegate?.musicPlayerFullScreenAnimation()
        }
        
    }
    
    @objc func showQueue(_ button: UIButton) {
        print("showQueue worked")
    }
    
    //MARK: - Music Player Controller
    private func updateMusicPlayer(track: Track) {
    
        //Setting song & artist name
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let songInfoAttributedString = NSMutableAttributedString(string: "\((currentTrack?.title)!)\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.paragraphStyle : paragraphStyle]) //should be 18
        
        songInfoAttributedString.append(NSAttributedString(string: (currentTrack?.artist)!, attributes: [NSAttributedString.Key.strokeColor : UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
        
        let songInfoAttributedStringForSmallView = NSMutableAttributedString(string: "\((currentTrack?.title)!) • ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.paragraphStyle : paragraphStyle])
        
        songInfoAttributedStringForSmallView.append(NSAttributedString(string: (currentTrack?.artist)!, attributes: [NSAttributedString.Key.strokeColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
        
        customView.songNameSlippyText.attributedText = songInfoAttributedString
        
        //Setting second
        let totalSecond : Int = (currentTrack?.duration)!
        customView.totalTimeInfoLabel.text = secondsToUserTime(second: totalSecond)

        //Setting Background Image
        customView.backgroundImage = customView.albumCoverCollectionView.songs[currentSongIndex].albumCover
    }
    @objc func playPauseSong() {
        isPlaying = !isPlaying
    }
    @objc func previousSong() {
        if currentTime > 4 { // Go to beggining of the current song if song is playing more than 4 seconds
            currentTrack = songs[currentSongIndex]
        } else {
            currentSongIndex -= 1
            currentTrack = songs[currentSongIndex]
        }
        
        isPlaying = true
        
        let indexPath = IndexPath(item: currentSongIndex, section: 0)
        customView.albumCoverCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        customView.albumCoverCollectionView.currentPage -= 1
//        customView.albumCoverCollectionView.animateCellForPreviousSong()
    }
    @objc func nextSong() {
        currentSongIndex += 1
        currentTrack = songs[currentSongIndex]
        isPlaying = true
        
        let indexPath = IndexPath(item: currentSongIndex, section: 0)
        customView.albumCoverCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        customView.albumCoverCollectionView.currentPage += 1
//        customView.albumCoverCollectionView.animateCellForNextSong()
    }
    
    @objc func shuffle(_ button: UIButton) {
        button.isSelected = !button.isSelected
        isShuffled = !isShuffled
        if button.isSelected {
            button.tintColor = .green
        } else {
            button.tintColor = .gray
        }
    }
    
    @objc func repeatList(_ button: UIButton) {
        button.isSelected = !button.isSelected
        repeatPlayList = !repeatPlayList
        if button.isSelected {
            button.tintColor = .green
        } else {
            button.tintColor = .gray
        }
    }
    private func songFinished() -> Bool {
        if Int(currentTime) > Int(audioPlayer.duration) {
            return true
        }
        return false
    }
    private func keepTrackOfAudio() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc private func updateTimer() {
        currentTime += 1
        if songFinished() { // each second checks if song finished or not. Goes to next song if it finished.
            nextSong()
        }
    }
    private func pauseTimer() {
        timer.invalidate()
    }
    private func resetTimer() {
        timer.invalidate()
        currentTime = 0
    }
    @objc func sliderValueChanged(_ slider: UISlider) {
        let newSecond = audioPlayer.duration * Double(slider.value)
        currentTime = newSecond
        audioPlayer.currentTime = TimeInterval(newSecond)
    }
    
    //MARK: ControlCollectionViewDelegate Function
    func collectionViewScrolled(goToNextSong: Bool) {
        if goToNextSong {
            currentSongIndex += 1
            currentTrack = songs[currentSongIndex]
            isPlaying = true
        } else {
            currentSongIndex -= 1
            currentTrack = songs[currentSongIndex]
            isPlaying = true
            //todo check it again if it's necessary or not
            customView.albumCoverCollectionView.isScrollEnabled = false
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { // To avoid user to change songs in a row
            self.customView.albumCoverCollectionView.isScrollEnabled = true
            }
        }
}


//MARK: Extension
extension MusicPlayerViewController {
    private func secondsToUserTime(second: Int) -> String {
        let minutes = Int(second / 60)
        let seconds = Int(second % 60)
        return NSString(format:"%2d:%02d", minutes, seconds) as String //9:54
    }
}
