//
//  FullScreenMusicPlayerView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 13.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class MusicPlayerFullScreenSizeView: UIView {
    //MARK: Variables
    
    var isPlaying : Bool = false {
        didSet{
            
        }
    }
    
    //MARK: - Player Items
    var playButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "pause_small")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        
        return button
    }()
    var nextSongButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "next_song")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        
        return button
    }()
    var previousSongButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "previous_song")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        
        return button
    }()
    var shuffleButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "shuffle")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        
        return button
    }()
    var repeatSongButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "repeat")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        
        return button
    }()
    
    var imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "masashi")?.withRenderingMode(.alwaysTemplate)
        imgView.image = image
        
        return imgView
    }()
    
    
    var upArrowButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "up_arrow")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
        layoutViews()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(imageView)
        
        addSubview(shuffleButton)
        addSubview(previousSongButton)
        addSubview(playButton)
        addSubview(nextSongButton)
        addSubview(repeatSongButton)
    }
    func layoutViews() {
        
        imageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor,  multiplier: 0.3).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.widthAnchor.constraint(lessThanOrEqualToConstant: 140).isActive = true
        playButton.heightAnchor.constraint(lessThanOrEqualToConstant: 140).isActive = true
        
        
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        playButton.heightAnchor.constraint(lessThanOrEqualToConstant: 52).isActive = true
        
    }

}
