//
//  PlaylistCell.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 9.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class PlaylistSongsCell: UICollectionViewCell {
    
    var songNameLabel : UILabel = {
        let label = UILabel()
        label.text = "The City Light Died"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var artistAndAlbumLabel : UILabel = {
        let label = UILabel()
        label.text = "Sleep Party People • Lingering"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var optionsButton: UIButton = {
        let image = UIImage(named: "options")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom, backgroundColor: nil, image: image, imageTintColor: .lightGray)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var downloadedImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        imageView.image = UIImage(named: "download")?.withRenderingMode(.alwaysTemplate)
//        imageView.tintColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .green
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        
        return imageView
    }()
    
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
        addSubview(songNameLabel)
        addSubview(downloadedImageView)
        addSubview(artistAndAlbumLabel)
        addSubview(optionsButton)
    }
    
    private func setLayout() {
        songNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        songNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        songNameLabel.rightAnchor.constraint(equalTo: optionsButton.leftAnchor, constant: 5).isActive = true
        songNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive = true
        
        downloadedImageView.centerYAnchor.constraint(equalTo: artistAndAlbumLabel.centerYAnchor).isActive = true
        downloadedImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        downloadedImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.28).isActive = true
        downloadedImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.28).isActive = true
        
        artistAndAlbumLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 5).isActive = true
        artistAndAlbumLabel.leftAnchor.constraint(equalTo: downloadedImageView.rightAnchor, constant: 5).isActive = true
        artistAndAlbumLabel.rightAnchor.constraint(equalTo: optionsButton.leftAnchor, constant: 5).isActive = true
        artistAndAlbumLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        
        optionsButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        optionsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        optionsButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        optionsButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
}
