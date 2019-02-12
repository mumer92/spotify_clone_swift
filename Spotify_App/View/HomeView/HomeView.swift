//
//  HomeView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 30.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class HomeView: View {
    
    //MARK: - Items
    var collectionView: HomeCollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = HomeCollectionView(frame: CGRect(origin: .zero, size: .zero), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        setViews()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Layouts
    override func setViews() {
        addSubview(collectionView)
    }
    override func layoutViews() {
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        // todo fix bottomanchor's constant
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
