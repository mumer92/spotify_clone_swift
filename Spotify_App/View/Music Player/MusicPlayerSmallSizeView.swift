//
//  MusicPlayerSmallView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 13.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit


class MusicPlayerSmallSizeView: UIView {
    
    //MARK: Variables
    
    var isPlaying : Bool = false {
        didSet{
            
        }
    }
    
    //MARK: Items
    var playButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "pause_small")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        
        return button
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
        addSubview(playButton)
        addSubview(upArrowButton)
    }
     func layoutViews() {
        playButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playButton.widthAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        playButton.heightAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        playButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        
        upArrowButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        upArrowButton.widthAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        upArrowButton.heightAnchor.constraint(lessThanOrEqualToConstant: 32).isActive = true
        upArrowButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
    }
}
