//
//  InnerHeaderView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 29.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UICollectionViewCell {
    
    var generalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .orange
        label.text = "genel label kismi"
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("tamam header ekraninin atadik")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        addSubview(generalLabel)
        
    }
    private func layouViews() {
        generalLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        generalLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        generalLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        generalLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
}
