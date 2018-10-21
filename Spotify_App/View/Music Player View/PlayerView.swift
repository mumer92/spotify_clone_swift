//
//  MusicPlayerFullScreenSizeView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 13.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class PlayerView: View {
    
    //MARK: Constraint Variables
    var bottomConstraintForAvaibleDevicesButton: NSLayoutConstraint?
    
    //MARK: Variables
    var isSmall: Bool = true {
        didSet {
            if isSmall {
                updateDisplayForSmallView()
            } else { //FullScreen
                updateDisplayForFullScreenView()
            }
        }
    }
    //todo carry theme under mark:-layout
    private func updateDisplayForSmallView() {
        let image = UIImage(named: "up_arrow")?.withRenderingMode(.alwaysTemplate)
        upDownArrowButton.setImage(image, for: .normal)
        let playImage = UIImage(named: "play_18")?.withRenderingMode(.alwaysTemplate)
        playListButton.setImage(playImage, for: .normal)
        
        upDownArrowButton.tintColor = .white
        bottomConstraintForAvaibleDevicesButton?.constant = -2
        layoutIfNeeded()
    }
    private func updateDisplayForFullScreenView() {
        
        let image = UIImage(named: "down_arrow")?.withRenderingMode(.alwaysTemplate)
        upDownArrowButton.setImage(image, for: .normal)
        
        let playListImage = UIImage(named: "playlist")?.withRenderingMode(.alwaysTemplate)
        playListButton.setImage(playListImage, for: .normal)
        
        upDownArrowButton.tintColor = .white
        bottomConstraintForAvaibleDevicesButton?.constant = -idealGapBetweenItems
        layoutIfNeeded()
    }
    var idealGapBetweenItems : CGFloat  {
        get {
            return UIScreen.main.bounds.height / 35
        }
    }
    //MARK: - Items
    //MARK: - Background Image Items
    let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
    var backgroundImage = UIImage(named: "the_way_of_all_flesh") {
        didSet {
            backgroundImageView.image = backgroundImage
        }
    }
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
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    //MARK: - Song Information and options
    var songNameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
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
    
    var secondPassedInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeUpdaterDisplay : UISlider = {
        let timeUpdateDisplay = UISlider()
 
        let image = UIImage(named: "circle")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor.white)
        let image2 = UIImage(named: "circle_2")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: UIColor.white)
        
        timeUpdateDisplay.isContinuous = true
        
        timeUpdateDisplay.tintColor = .white
        timeUpdateDisplay.maximumTrackTintColor = .gray
        
        timeUpdateDisplay.setThumbImage(image, for: .normal)
        timeUpdateDisplay.setThumbImage(image2, for: .highlighted)
        
        timeUpdateDisplay.translatesAutoresizingMaskIntoConstraints = false
        
        return timeUpdateDisplay
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
        
        let image = UIImage(named: "play_small")?.withRenderingMode(.alwaysTemplate)

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
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        
        return button
    }()
    var repeatButton : UIButton = {
        let image = UIImage(named: "repeat")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        
        return button
    }()

    
    //MARK: - Bottom
    var avaibleDevicesButton : UIButton = {
        let image = UIImage(named: "devices")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .white)
        button.setTitle(" Devices Avaible", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        
        return button
    }()
    
    var albumCoverCollectionView : AlbumCoverCollectionView = { // Must be collection view ///TODO
        let cv = AlbumCoverCollectionView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = grayColor
        
        setViews()
        layoutViews()
        setupStackViews()
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.addBlurEffect()
        insertSubview(backgroundImageView, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tintColorDidChange() {
        print("color changed amina kodumun yerinde")
    }
    
    //MARK: - Layout
    override func setViews() {
        addSubview(albumCoverCollectionView)
        addSubview(timeUpdaterDisplay)
        addSubview(avaibleDevicesButton)
    }
    override func layoutViews() {
        

        upDownArrowButton.widthAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        upDownArrowButton.heightAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        
        playListButton.widthAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        playListButton.heightAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        
        
        //setting up top Anchor in setupStackView function
        albumCoverCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        albumCoverCollectionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        let idealHeightForImageView = UIScreen.main.bounds.height / 3
        albumCoverCollectionView.heightAnchor.constraint(equalToConstant: idealHeightForImageView).isActive = true //gotta change it. todo
        
        
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
        bottomConstraintForAvaibleDevicesButton = avaibleDevicesButton.bottomAnchor.constraint(equalTo: bottomAnchor)
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
        topStackView.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
        topStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        albumCoverCollectionView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: idealGapBetweenItems).isActive = true
        
        
        let songInformationStackView = UIStackView(arrangedSubviews: [addToLibraryButton,songNameLabel,optionsButton])
        songInformationStackView.distribution = .equalSpacing
        songInformationStackView.spacing = 0.5
        songInformationStackView.axis = .horizontal
        songInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        songInformationStackView.alignment = .center
        
        addSubview(songInformationStackView)
        
        songInformationStackView.subviews[1].widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.65).isActive = true
        
        songInformationStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        songInformationStackView.topAnchor.constraint(equalTo: albumCoverCollectionView.bottomAnchor, constant: 5).isActive = true
        songInformationStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.90).isActive = true
        
        songInformationStackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        let timeLabelsStackView = UIStackView(arrangedSubviews: [secondPassedInfoLabel, totalTimeInfoLabel])
        addSubview(timeLabelsStackView)
        timeLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        timeLabelsStackView.alignment = .center
        timeLabelsStackView.distribution = .equalSpacing
        timeLabelsStackView.axis = .horizontal
        
        timeLabelsStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        timeLabelsStackView.topAnchor.constraint(equalTo: songInformationStackView.bottomAnchor, constant: idealGapBetweenItems).isActive = true
        timeLabelsStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        timeLabelsStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        timeUpdaterDisplay.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        timeUpdaterDisplay.heightAnchor.constraint(equalToConstant: 15).isActive = true
        timeUpdaterDisplay.topAnchor.constraint(equalTo: timeLabelsStackView.bottomAnchor, constant: 5).isActive = true
        timeUpdaterDisplay.leftAnchor.constraint(equalTo: timeLabelsStackView.leftAnchor).isActive = true
        
        
        
        let playerControllerStackView = UIStackView(arrangedSubviews: [shuffleButton, previousSongButton, playButton, nextSongButton, repeatButton])
        addSubview(playerControllerStackView)
        playerControllerStackView.translatesAutoresizingMaskIntoConstraints = false
        playerControllerStackView.alignment = .center
        playerControllerStackView.distribution = .equalSpacing
        playerControllerStackView.axis = .horizontal
        
        playerControllerStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playerControllerStackView.topAnchor.constraint(equalTo: timeUpdaterDisplay.bottomAnchor, constant: idealGapBetweenItems).isActive = true
        playerControllerStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        playerControllerStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
}
extension UIImageView {
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
