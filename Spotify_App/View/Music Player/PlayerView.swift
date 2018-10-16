//
//  MusicPlayerFullScreenSizeView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 13.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

//class MusicPlayerFullScreenSizeView: UIView {
class PlayerView: View {
    //MARK: Constraint Variables
    var bottomConstraintForAvaibleDevicesButton: NSLayoutConstraint?
    
    //MARK: Variables
    var isPlaying : Bool = false {
        didSet{
            
        }
    }
    var isSmall: Bool = true {
        didSet {
            if isSmall {
//                let image = UIImage(named: "up_arrow")?.withRenderingMode(.alwaysTemplate)
//                upDownArrowButton.setImage(image, for: .normal)
//
//                let pauseImage = UIImage(named: "pause_small")?.withRenderingMode(.alwaysTemplate)
//                playListButton.setImage(pauseImage, for: .normal)
                
                upDownArrowButton.tintColor = .white
                bottomConstraintForAvaibleDevicesButton?.constant = -2
            } else { //FullScreen
//
//                let image = UIImage(named: "down_arrow")?.withRenderingMode(.alwaysTemplate)
//                upDownArrowButton.setImage(image, for: .normal)
//                let playListImage = UIImage(named: "playlist")?.withRenderingMode(.alwaysTemplate)
//
//                playListButton.setImage(playListImage, for: .normal)
                
                upDownArrowButton.tintColor = .white
                bottomConstraintForAvaibleDevicesButton?.constant = -idealGapBetweenItems
            }
        }
    }
    var idealGapBetweenItems : CGFloat  {
        get {
            return UIScreen.main.bounds.height / 25
        }
    }
    //MARK: - Items
    
    //MARK: - Top
    var upDownArrowButton : UIButton = {
        let image = UIImage(named: "down_arrow")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .white)
        
        return button
    }()
    var playListButton : UIButton = {
        let image = UIImage(named: "playlist")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .white)
        
        return button
    }()
    
    var playlistInfoLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Playing from Playlist"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    //MARK: - Song Information and options
    var songInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "Sivasin Yollarina"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var addToLibraryButton : UIButton = {
        let image = UIImage(named: "plus_symbol")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .gray)
        
        return button
    }()
    var optionsButton : UIButton = {
        let image = UIImage(named: "options")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .gray)
        
        return button
    }()
    
    //MARK: - Song's Time Information
    
    var timePassedInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "2:45"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var totalTimeInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "3:59"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Player Controls
    var playButton : UIButton = {
        
        let image = UIImage(named: "pause_small")?.withRenderingMode(.alwaysTemplate)

        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .white)
        return button
    }()
    var previousSongButton : UIButton = {
        let image = UIImage(named: "previous_song")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .white)
        
        return button
    }()
    var nextSongButton : UIButton = {
        let image = UIImage(named: "next_song")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .white)
        
        return button
    }()
    var shuffleButton : UIButton = {
        let image = UIImage(named: "shuffle")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .gray)
        
        return button
    }()
    var repeatButton : UIButton = {
        let image = UIImage(named: "repeat")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .gray)
        
        return button
    }()

    
    //MARK: - Bottom
    var avaibleDevicesButton : UIButton = {
        let image = UIImage(named: "devices")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .white)
        button.setTitle(" Devices Avaible", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        
        return button
    }()
    
    var imageView : UIImageView = { // Must be collection view ///TODO
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "masashi")?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        
        return imageView
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = grayColor
        
        setViews()
        layoutViews()
        setupStackViews()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
      //MARK: - Layout
   override func setViews() {
        addSubview(shuffleButton)
        addSubview(previousSongButton)
        addSubview(playButton)
        addSubview(nextSongButton)
        addSubview(repeatButton)
        
        addSubview(imageView)
        addSubview(upDownArrowButton)
        addSubview(playListButton)
        
        addSubview(timePassedInfoLabel)
        addSubview(totalTimeInfoLabel)
        
        addSubview(addToLibraryButton)
        addSubview(songInfoLabel)
        addSubview(optionsButton)
        
        addSubview(avaibleDevicesButton)
    }
    override func layoutViews() {
        

        upDownArrowButton.widthAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        upDownArrowButton.heightAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        
        playListButton.widthAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        playListButton.heightAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        
        
        //setting up top Anchor in setupStackView function
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        let idealHeightForImageView = UIScreen.main.bounds.height / 3
        imageView.heightAnchor.constraint(equalToConstant: idealHeightForImageView).isActive = true //gotta change it. todo
        
        
        //Player
        playButton.widthAnchor.constraint(lessThanOrEqualToConstant: 75).isActive = true
        playButton.heightAnchor.constraint(lessThanOrEqualToConstant: 75).isActive = true
        
        previousSongButton.widthAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        previousSongButton.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        
        nextSongButton.widthAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        nextSongButton.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        
        shuffleButton.widthAnchor.constraint(lessThanOrEqualToConstant: 35).isActive = true
        shuffleButton.heightAnchor.constraint(lessThanOrEqualToConstant: 35).isActive = true
        
        repeatButton.widthAnchor.constraint(lessThanOrEqualToConstant: 35).isActive = true
        repeatButton.heightAnchor.constraint(lessThanOrEqualToConstant: 35).isActive = true
        
        ///Avaible Devices
        avaibleDevicesButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        avaibleDevicesButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        bottomConstraintForAvaibleDevicesButton = avaibleDevicesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        bottomConstraintForAvaibleDevicesButton?.isActive = true
    }
    
    private func setupStackViews() {
        
        
        let topStackView = UIStackView(arrangedSubviews: [upDownArrowButton,playlistInfoLabel,playListButton])
        topStackView.distribution = .equalSpacing
        topStackView.axis = .horizontal
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.alignment = .center
        
        addSubview(topStackView)
        topStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topStackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        imageView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: idealGapBetweenItems).isActive = true
        
        
        let sonInformationStackView = UIStackView(arrangedSubviews: [addToLibraryButton,songInfoLabel,optionsButton])
        sonInformationStackView.distribution = .equalSpacing
        sonInformationStackView.axis = .horizontal
        sonInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        sonInformationStackView.alignment = .center
        
        addSubview(sonInformationStackView)
        sonInformationStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        sonInformationStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        sonInformationStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        sonInformationStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        let timeLabelsStackView = UIStackView(arrangedSubviews: [timePassedInfoLabel, totalTimeInfoLabel])
        addSubview(timeLabelsStackView)
        timeLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        timeLabelsStackView.alignment = .center
        timeLabelsStackView.distribution = .equalSpacing
        timeLabelsStackView.axis = .horizontal
        
        timeLabelsStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        timeLabelsStackView.topAnchor.constraint(equalTo: sonInformationStackView.bottomAnchor, constant: idealGapBetweenItems).isActive = true
        timeLabelsStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        timeLabelsStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let playerControllerStackView = UIStackView(arrangedSubviews: [shuffleButton, previousSongButton, playButton, nextSongButton, repeatButton])
        addSubview(playerControllerStackView)
        playerControllerStackView.translatesAutoresizingMaskIntoConstraints = false
        playerControllerStackView.alignment = .center
        playerControllerStackView.distribution = .equalSpacing
        playerControllerStackView.axis = .horizontal
        
        playerControllerStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playerControllerStackView.topAnchor.constraint(equalTo: timeLabelsStackView.bottomAnchor, constant: idealGapBetweenItems).isActive = true
        playerControllerStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        playerControllerStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
}
