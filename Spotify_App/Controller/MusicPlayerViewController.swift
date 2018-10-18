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

protocol ControlTabBarControllerDelegate: class {
    func musicPlayerFullScreenAnimation()
    func musicPlayerSmallScreenAnimation()
}
//ControlTabBarControllerDelegate
class MusicPlayerViewController: ViewController<PlayerView> {
    
     //MARK: - NSLayoutConstraints
    var topConstraintForAlbumsTableView : NSLayoutConstraint?
    
    //MARK: - Layout Variables
    var controlTabBarControllerDelegate: ControlTabBarControllerDelegate?
    
    var originalTabBarFrame : CGRect?
    let screenSize = UIScreen.main.bounds
    
    var firstTouchPosition : CGPoint?
    var locationChange: CGFloat = 0
    
    //MARK: Song Variables
    var mediaPlayer = AVAudioPlayer()
    private func updateMusicPlayer(track: Track) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let songInfoAttributedString = NSMutableAttributedString(string: "\((currentTrack?.title)!)\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.paragraphStyle : paragraphStyle])
        
        songInfoAttributedString.append(NSAttributedString(string: (currentTrack?.artist)!, attributes: [NSAttributedString.Key.strokeColor : UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.paragraphStyle: paragraphStyle]))
        customView.songNameLabel.attributedText = songInfoAttributedString
        
        
        let totalSecond : Int = (currentTrack?.duration)!
        customView.totalTimeInfoLabel.text = secondsToUserTime(second: totalSecond)
    }
    var timer = Timer()
    var songs : [Track] = []
    var selectedSongIndex: Int = 0 {
        didSet {
            if self.selectedSongIndex < 0 {
                self.selectedSongIndex = songs.count - 1
            } else if self.selectedSongIndex == songs.count {
                print("Set ediyok burada")
                self.selectedSongIndex = 0
            }
        }
    }
    
    var dataArray : [Data] = []
    var shuffled = false
    var currentTrack: Track? {
        didSet {
            resetTimer()
            guard let track = currentTrack else {return}
            updateMusicPlayer(track : track)
            
            do { //Setting up media player
                guard let data = currentTrack?.trackData else {return}
                try mediaPlayer = AVAudioPlayer(data: data)
            } catch {
                print("error lan mk")
            }
        }
    }
    
    //MARK: - Variables
    var timePassed: Int = 0 {
        didSet {
            customView.timePassedInfoLabel.text = secondsToUserTime(second: timePassed)
        }
    }
    var isPlaying : Bool = false {
        didSet {
            if isPlaying {
                
                let pauseImage = UIImage(named: "pause_small")?.withRenderingMode(.alwaysTemplate)
                customView.playButton.setImage(pauseImage, for: .normal)
    
                mediaPlayer.play()
                getLiveSongTime() // todo change function name
                if isSmall {
                  customView.playListButton.setImage(pauseImage, for: .normal)
                }
            } else {
                let playImage = UIImage(named: "play_small")?.withRenderingMode(.alwaysTemplate)
                customView.playButton.setImage(playImage, for: .normal)
                mediaPlayer.pause()
                pauseTimer()
                if isSmall {
                  customView.playListButton.setImage(playImage, for: .normal)
                }
            }
        }
    }
    var isSmall: Bool = true {
        didSet {
            if isSmall {
                customView.isSmall = self.isSmall
                controlTabBarControllerDelegate?.musicPlayerSmallScreenAnimation()
            } else {
                customView.isSmall = self.isSmall
                controlTabBarControllerDelegate?.musicPlayerFullScreenAnimation()
            }
        }
    }
    
    
    //MARK: - View Appareance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isSmall = true
        
        songs = getSongs() //pulling all the songs with extension
        
        selectedSongIndex = 0
        currentTrack = songs[selectedSongIndex]
        
        //Setting up Gesture Recognizers
        customView.upDownArrowButton.addTarget(self, action: #selector(upDownArrowButtonAction), for: .touchUpInside)
        
        customView.playButton.addTarget(self, action: #selector(playPauseSong(_:)), for: .touchUpInside)
        customView.previousSongButton.addTarget(self, action: #selector(previousSong(_:)), for: .touchUpInside)
        customView.nextSongButton.addTarget(self, action: #selector(nextSong(_:)), for: .touchUpInside)
        customView.shuffleButton.addTarget(self, action: #selector(shuffle(_:)), for: .touchUpInside)
        customView.repeatButton.addTarget(self, action: #selector(repeatList(_:)), for: .touchUpInside)
    }
    
    func structToData(track: Track) -> Data{
        var trck = track
        return Data(bytes: &trck, count: MemoryLayout<Track>.stride)
    }
    //MARK: - Delegate Status Bar
    var isStatusBarHidden: Bool = false {
        didSet {
            print("isStatisBarHidden : " , isStatusBarHidden)
            UIView.animate(withDuration: 1.1) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }

    @objc func upDownArrowButtonAction() {
        isSmall = !isSmall
    }
    
    //Music Player Controller
    @objc func playPauseSong(_ button: UIButton) {
        isPlaying = !isPlaying
        
    }
    @objc func previousSong(_ button: UIButton) {
        //sarkiyi ata
        selectedSongIndex -= 1
        print("Seleced Index : " , selectedSongIndex)
        currentTrack = songs[selectedSongIndex]
        isPlaying = true
    }
    @objc func nextSong(_ button: UIButton) {
        
        selectedSongIndex += 1
        print("Seleced Index : " , selectedSongIndex)
        currentTrack = songs[selectedSongIndex]
        isPlaying = true
    }
    
    @objc func shuffle(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            button.tintColor = .green
        } else {
            button.tintColor = .gray
        }
    }
    
    @objc func repeatList(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            button.tintColor = .green
        } else {
            button.tintColor = .gray
        }
    }
    private func getLiveSongTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    var counter = 0.0 {
        didSet {
            customView.timePassedInfoLabel.text = secondsToUserTime(second: Int(counter))
        }
    }
    @objc private func updateTimer() {
        counter = counter + 1
    }
    private func pauseTimer() {
        timer.invalidate()
    }
    private func resetTimer() {
        timer.invalidate()
        counter = 0
    }
}


extension MusicPlayerViewController {
    private func secondsToUserTime(second: Int) -> String {
        let minutes = Int(second / 60)
        let seconds = Int(second % 60)
        return NSString(format:"%2d:%02d", minutes, seconds) as String //9:54
    }
}
