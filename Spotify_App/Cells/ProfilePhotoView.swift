//
//  ProfilePhotoView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 11.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class ProfilePhotoView: UIView {
    
    var playlistByLabel : UILabel = {
        let label = UILabel()
        label.text = "PLAYLIST BY"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var userProfilePhotoImageView: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "sleep_party_people"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.width / 2
        
        return button
    }()
    var nickButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.setTitle("MKESHNODA", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.isEnabled = false
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        setView()
        setLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        addSubview(playlistByLabel)
        addSubview(userProfilePhotoImageView)
        addSubview(nickButton)
    }
    private func setLayout() {
        playlistByLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        playlistByLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playlistByLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        playlistByLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        userProfilePhotoImageView.topAnchor.constraint(equalTo: playlistByLabel.bottomAnchor, constant: 5).isActive = true
        userProfilePhotoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userProfilePhotoImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        userProfilePhotoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.54).isActive = true
        
        nickButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nickButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nickButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true
        nickButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
    }
}
