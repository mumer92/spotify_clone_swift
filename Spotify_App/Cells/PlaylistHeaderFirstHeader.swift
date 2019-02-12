//
//  PlaylistHeaderFirstHeader.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 10.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class PlaylistHeaderFirstView: UIView {
    
    var downloadedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sleep_party_people")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    var playlistNameLabel : UILabel = {
        let label = UILabel()
        label.text = "SPP & God is an Astronaut"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var followerLabel : UILabel = {
        let label = UILabel()
        label.text = "5 followers"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        addSubview(downloadedImageView)
        addSubview(playlistNameLabel)
        addSubview(followerLabel)
    }
    private func setLayout() {
        
        downloadedImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        downloadedImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        downloadedImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        downloadedImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        
        playlistNameLabel.topAnchor.constraint(equalTo: downloadedImageView.bottomAnchor, constant: 15).isActive = true
        playlistNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playlistNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        playlistNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        followerLabel.topAnchor.constraint(equalTo: playlistNameLabel.bottomAnchor, constant: 10).isActive = true
        followerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        followerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        followerLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}


