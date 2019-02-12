//
//  SongInfoLabelsView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 8.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class SongInfoLabelsView: UIView {

    var songNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.text = "Art of Dying sdjgnsdljgnsldjgn is the way to let all go"
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()
//
    var artistNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Gojira"
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setViews()
        layoutViews()
        
//        songNameSlippyText.textObject = songNameLabel
//        artistNameSlippyText.textObject = artistNameLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
//        addSubview(songNameLabel)
//        addSubview(artistNameLabel)
        
    }
    private func layoutViews() {
        
        
//        artistNameSlippyText.topAnchor.constraint(equalTo: songNameSlippyText.bottomAnchor).isActive = true
//        artistNameSlippyText.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        artistNameSlippyText.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        artistNameSlippyText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
//        songNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        songNameLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        songNameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        songNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
//
//        artistNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor).isActive = true
//        artistNameLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        artistNameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        artistNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
}

