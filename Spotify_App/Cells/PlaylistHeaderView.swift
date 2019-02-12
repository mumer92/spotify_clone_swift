//
//  PlaylistHeaderView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 10.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class PlaylistHeaderView: UICollectionReusableView, UIScrollViewDelegate {
    
    let backgroundImageView = UIImageView(image: UIImage(named: "sleep_party_people")!)
    
    var shufflePlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SHUFFLE PLAY", for: .normal)
        button.backgroundColor = greenColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setLayout()
        setupBlurryBackground()
        
        setupScrollView()
        setupPageControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    //MARK: - Layout
    private func setupPageControl() {
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: frame.width * 2, height: frame.height)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let playlistHeaderFirstView = PlaylistHeaderFirstView()
        playlistHeaderFirstView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: bounds.height))
        scrollView.addSubview(playlistHeaderFirstView)
        playlistHeaderFirstView.frame.origin.x = 0
        
        let playlistHeaderDetailView = PlaylistHeaderDetailView()
        playlistHeaderDetailView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: bounds.height))
        scrollView.addSubview(playlistHeaderDetailView)
        playlistHeaderDetailView.frame.origin.x = bounds.size.width
    }
    
    private func setupBlurryBackground() {
        backgroundImageView.image = UIImage(named: "sleep_party_people")
        backgroundImageView.frame = self.frame
        backgroundImageView.addBlurEffect()
        insertSubview(backgroundImageView, at: 0)
    }
    private func setView() {
        addSubview(scrollView)
        addSubview(pageControl)
        addSubview(shufflePlayButton)
    }
    
    private func setLayout() {
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
 
        pageControl.bottomAnchor.constraint(equalTo: shufflePlayButton.topAnchor, constant: -10).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 20).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        shufflePlayButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 25).isActive = true
        shufflePlayButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        shufflePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shufflePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
