//
//  AlbumCoverCollectionView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 18.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

protocol ControlCollectionViewDelegate: class {
    func collectionViewScrolled(goToNextSong: Bool)
}

class AlbumCoverCollectionView: UICollectionView {
    
    //MARK: - Constants
    let cellId = "AlbumCoverCell"
    let itemHeight = UIScreen.main.bounds.height / 2.6
    let itemWidth = UIScreen.main.bounds.width / 1.4
    let pageController = UIPageControl()
    
    //MARK: - Variables

    var musicPlayer : MusicPlayer = MusicPlayer() {
        didSet {
            self.songs = musicPlayer.songs
            currentPage = musicPlayer.currentSongIndex
        }
    }

    var songs: [Track] = [] {
        didSet {
            reloadData()
        }
    }
    
    var controlCollectionViewDelegate: ControlCollectionViewDelegate?
    var currentPage: Int = 0 { //Changes
        didSet {
            pageController.currentPage = currentPage
            
            if currentPage < 0  { // repeatPlayList = true
                if musicPlayer.repeatPlaylist {
                    currentPage = songs.count - 1
                } else {
                    currentPage = 0
                }
            } else if currentPage == songs.count { // repeatPlayList = true
                if musicPlayer.repeatPlaylist {
                    currentPage = 0
                } else {
                    currentPage = songs.count - 1
                }
            }
        }
    }
    private func getIndexPath(index: Int) -> IndexPath {
        return IndexPath(row: index, section: 0)
    }
    private func makeCellUnselected(previousCell : AlbumCoverCell) {
        previousCell.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseOut], animations: {
            previousCell.alpha = 0.7
            previousCell.transform = CGAffineTransform.init(scaleX: 0.85, y: 0.85)
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func animateCellForNextSong() {
        let indexPath = IndexPath(row: currentPage, section: 0)
        
        let cell : AlbumCoverCell = cellForItem(at: indexPath) as! AlbumCoverCell
        let prevIndexPath = IndexPath(row: currentPage-1, section: 0)
        var prevCell = AlbumCoverCell()

        if currentPage == 0 { //to prevent viewcontroller next button's bug
            prevCell = cellForItem(at: getIndexPath(index: currentPage)) as! AlbumCoverCell
        } else if currentPage < songs.count - 1 {
            prevCell = cellForItem(at: prevIndexPath) as! AlbumCoverCell
            makeCellUnselected(previousCell: prevCell)
        } else { //last song..
            prevCell = cellForItem(at: getIndexPath(index: currentPage)) as! AlbumCoverCell
            makeCellUnselected(previousCell: prevCell)
        }

        ///To animate main cell
        cell.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseIn], animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform.init(scaleX: 1.05, y: 1.05)
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func animateCellForPreviousSong() {
        
        let indexPath = IndexPath(row: currentPage, section: 0)
        let cell : AlbumCoverCell = cellForItem(at: indexPath) as! AlbumCoverCell
        
        let nextIndexPath = IndexPath(row: currentPage+1, section: 0)
        var nextCell = AlbumCoverCell()
        
        if currentPage == songs.count {
            // don't change anything. We are in the last song
        } else if currentPage == 0 {
            nextCell = cellForItem(at: getIndexPath(index: 0)) as! AlbumCoverCell
            makeCellUnselected(previousCell: nextCell)
            //dont change anything
        } else {
            nextCell = cellForItem(at: nextIndexPath) as! AlbumCoverCell
            makeCellUnselected(previousCell: nextCell)
        }
        
        ///To animate main cell
        cell.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseIn], animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform.init(scaleX: 1.05, y: 1.05)
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    //MARK: Initiliazer
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .horizontal
        myLayout.minimumLineSpacing = 10
        super.init(frame: frame, collectionViewLayout: myLayout)

        pageController.numberOfPages = songs.count - 1
        delegate = self
        dataSource = self
        register(AlbumCoverCell.self, forCellWithReuseIdentifier: cellId)
        
        showsHorizontalScrollIndicator = true
        decelerationRate = UIScrollView.DecelerationRate.fast
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        isScrollEnabled = false
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { // todo fix if repeat is closed than shouldnt go back
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // To avoid user to change songs in a row
            self.isScrollEnabled = true
        }
    }
    
}

//MARK: Extension
extension AlbumCoverCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return songs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AlbumCoverCell
        cell.imageView.image = songs[indexPath.row].albumCover
        cell.alpha = 0.7
        cell.transform = CGAffineTransform.init(scaleX: 0.85, y: 0.85)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { //to center horizontally my cell
        
        let collectionViewWidth = UIScreen.main.bounds.width
        let leftInset = (collectionViewWidth - itemWidth) / 2
        let rightInset =  leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) { // Centerizes the cell
        
        let pageWidth = Float(itemWidth + 10)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(contentSize.width  )

        var newPage = Float(currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? currentPage + 1 : currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        if newPage == Float(songs.count) { // This statement prevents bug.
            newPage = Float(songs.count - 1)
        }
        
///TODO
        if currentPage > Int(newPage) { //moved to previous cell
            controlCollectionViewDelegate?.collectionViewScrolled(goToNextSong: false)
            currentPage = Int(newPage) //bug
            animateCellForPreviousSong()
        } else if currentPage < Int(newPage) { //moved to next cell
            controlCollectionViewDelegate?.collectionViewScrolled(goToNextSong: true)
            currentPage = Int(newPage) //bug
            animateCellForNextSong()
        }
        
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point

    }
    
}
