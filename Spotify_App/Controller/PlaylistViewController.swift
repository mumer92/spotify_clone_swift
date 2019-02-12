//
//  PlaylistViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 9.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class PlaylistViewController: CollectionViewController<PlaylistView> {
    
    
    var songs : [Track] = [] {
        didSet {
            //customView.albumCoverCollectionView.songs = self.songs
            customView.songs = songs
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        setNavigationBar()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        songs = getSongs()
    }   
}


extension PlaylistViewController {
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = .clear
        
        let backButton = UIBarButtonItem(image: UIImage(named: "left_arrow"), style: UIBarButtonItem.Style.done, target: self, action: nil)
        let optionsButton = UIBarButtonItem(image: UIImage(named: "options")?.withRenderingMode(.alwaysTemplate).maskWithColor(color: .white), style: UIBarButtonItem.Style.done, target: self, action: nil)
        
        backButton.tintColor = .white
        optionsButton.tintColor = .white
        
        navigationItem.rightBarButtonItem = optionsButton
        navigationItem.leftBarButtonItem = backButton

    }
}
