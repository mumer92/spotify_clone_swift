//
//  PlaylistDownloadedCells.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 10.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class PlaylistDownloadedCell: UICollectionViewCell {
    
    var songNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Downloaded"
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var downloadSwitch : UISwitch = {
        let download = UISwitch()
        download.translatesAutoresizingMaskIntoConstraints = false
        download.isOn = true
        download.onTintColor = greenColor
        download.tintColor = .white
        
        return download
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
        addSubview(downloadSwitch)
    }
    
    private func setLayout() {
        songNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        songNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        songNameLabel.rightAnchor.constraint(equalTo: downloadSwitch.leftAnchor).isActive = true
        
        downloadSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        downloadSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        downloadSwitch.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
}
