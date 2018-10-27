//
//  TrackTitleScrollView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 22.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class TrackTitleScrollView: UIScrollView, UIScrollViewDelegate {
    var attributedString = NSAttributedString() {
        didSet {
            print(attributedString.string)
            songNameLabel.attributedText = attributedString
        }
    }
    var songNameLabel : UILabel = {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 15)))
        
        label.text = "somewhere i belooong and i've got nothing to say i cant believe blablabla..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y != 0 {
            scrollView.contentOffset.y = 0
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false

        isDirectionalLockEnabled = true
        isUserInteractionEnabled = true
        
        Timer.scheduledTimer(withTimeInterval: 9, repeats: true) { (t) in
            self.autoScroll()
        }
        setupViews()
        layoutViews()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func autoScroll() {
        
        let textWidth = attributedString.size().width
        let mesafe = textWidth - bounds.width
        if mesafe > 0 {
            UIView.animate(withDuration: 2.5, delay: 0, options: .curveLinear, animations: {
                self.contentOffset.x += mesafe
            }, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: {
                UIView.animate(withDuration: 2.5, delay: 0, options: .curveLinear, animations: {
                    self.contentOffset.x = 0
                    self.layoutIfNeeded()
                }, completion: nil)
            })
        }
        
    }
    
    
    //MARK: - Layout
    private func setupViews() {
        addSubview(songNameLabel)
    }
    private func layoutViews() {
        songNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        songNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        songNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        songNameLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}

