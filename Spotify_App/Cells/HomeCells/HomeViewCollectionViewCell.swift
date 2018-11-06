//
//  HomeViewCollectionViewCell.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 28.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class HomeViewCollectionViewCell: UICollectionViewCell {

    var generalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 2

        return label
    }()
    
    
    var homeInnerCV: HomeInnerCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = HomeInnerCollectionView(frame: CGRect(origin: .zero, size: .zero), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        setView()
        layoutView()        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributedString = NSMutableAttributedString(string: "Your heavy rotation \n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.paragraphStyle : paragraphStyle])
        attributedString.append(NSAttributedString(string: "The music you've had on repeat this month.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.paragraphStyle : paragraphStyle]))
            
        generalLabel.attributedText = attributedString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setView() {
        addSubview(generalLabel)
        addSubview(homeInnerCV)
    }
    private func layoutView() {
        generalLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        generalLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        generalLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        generalLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        generalLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
//        generalLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ///width might be needed i am not sure
        
        homeInnerCV.topAnchor.constraint(equalTo: generalLabel.bottomAnchor).isActive = true
        homeInnerCV.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        homeInnerCV.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        homeInnerCV.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
