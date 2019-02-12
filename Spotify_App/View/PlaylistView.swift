//
//  PlaylistView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 9.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class PlaylistView: CollectionView {
    
    let songsCellID = "songsPlaylistCell"
    let downloadCellID = "downloadPlaylistCell"
    let headerCellID = "PlaylistHeaderCell"
    
    
    var songs : [Track] = [] {
        didSet {
            reloadData()
        }
    }
    
    var songNameLabel : UILabel = {
        let label = UILabel()
        label.text = "The City Light Died"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        
        translatesAutoresizingMaskIntoConstraints = false
        setViews()
        layoutViews()
        
        register(PlaylistSongsCell.self, forCellWithReuseIdentifier: songsCellID)
        register(PlaylistDownloadedCell.self, forCellWithReuseIdentifier: downloadCellID)
        register(PlaylistHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellID)
        dataSource = self
        delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setViews() {}
    override func layoutViews() {}
}

//MARK: - Collection View Delegate
extension PlaylistView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = dequeueReusableCell(withReuseIdentifier: downloadCellID, for: indexPath) as! PlaylistDownloadedCell
            
            return cell
        }
        
        let cell = dequeueReusableCell(withReuseIdentifier: songsCellID, for: indexPath) as! PlaylistSongsCell
        cell.songNameLabel.text = songs[indexPath.row].title
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath)
        
        return headerView
    }
    
    
}


//MARK: - Layout
extension PlaylistView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 45, left: 0, bottom: 20, right: 0)
        }
        return UIEdgeInsets(top: 10, left: 0, bottom: 15, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        if indexPath.section == 0 {
            return CGSize(width: screenSize.width, height: 40)
        }
        return CGSize(width: screenSize.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 380)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 0)
    }
}
