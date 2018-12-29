//
//  InnerCollectionViewCell.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 29.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class InnerCollectionViewCell: UICollectionViewCell {
    
    var playListImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    var playListNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "List name"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        playListImageView.image = UIImage(named: "lenfant_sauvage")
        
        backgroundColor = .clear
        
        setView()
        setLayout()
    }
    
    private func setView() {
        addSubview(playListImageView)
        addSubview(playListNameLabel)
    }
    private func setLayout() {
        playListImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        playListImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
        playListImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        playListImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -2).isActive = true
        
        playListNameLabel.topAnchor.constraint(equalTo: playListImageView.bottomAnchor, constant: 5).isActive = true
        playListNameLabel.centerXAnchor.constraint(equalTo: playListImageView.centerXAnchor).isActive = true
        playListNameLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        playListNameLabel.widthAnchor.constraint(equalTo: playListImageView.widthAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
