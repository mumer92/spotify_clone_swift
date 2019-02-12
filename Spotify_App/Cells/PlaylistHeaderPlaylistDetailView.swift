//
//  PlaylistHeaderPlaylistDetailView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 10.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class PlaylistHeaderDetailView: UIView {
  
    var playlistCommentLabel : UILabel = {
        let label = UILabel()
        label.text = "Best Paylist ever in the history of the world"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dateAndDurationView = DateAndDurationView()
    let profilePhotoView = ProfilePhotoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        setView()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        addSubview(playlistCommentLabel)
        addSubview(profilePhotoView)
        addSubview(dateAndDurationView)
    }
    private func setLayout() {
        playlistCommentLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        playlistCommentLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        playlistCommentLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playlistCommentLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        profilePhotoView.topAnchor.constraint(equalTo: playlistCommentLabel.bottomAnchor, constant: 10).isActive = true
        profilePhotoView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        profilePhotoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profilePhotoView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        dateAndDurationView.topAnchor.constraint(equalTo: profilePhotoView.bottomAnchor, constant: 15).isActive = true
        dateAndDurationView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        dateAndDurationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateAndDurationView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
    }
}
