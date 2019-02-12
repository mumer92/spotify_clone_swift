//
//  CollectionView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 9.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class CollectionView: UICollectionView {
    
//    let tabBarController = MainTabBarController()
    
//    var navigationBarHeight: CGFloat {
//        get {
//            return tabBarController.tabBarHeight + topSafeAreaHeight
//        }
//    }
//    var topSafeAreaHeight : CGFloat {
//        get {
//            if let window = UIApplication.shared.keyWindow , #available(iOS 11.0, *) {
//                return window.safeAreaInsets.top
//            }
//            return 0
//        }
//    }
//
//    var tabBarHeight: CGFloat {
//        get {
//            return tabBarController.tabBarHeight + bottomSafeAreaHeight
//        }
//    }
    
//    var bottomSafeAreaHeight : CGFloat {
//        get {
//            if let window = UIApplication.shared.keyWindow , #available(iOS 11.0, *) {
//                return window.safeAreaInsets.bottom
//            }
//            return 0
//        }
//    }
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        setViews()
        layoutViews()
        
//        contentInsetAdjustmentBehavior = .never
//        contentInset = UIEdgeInsets(top: navigationBarHeight, left: 0, bottom: tabBarHeight-15, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
        layoutViews()
    }
    func setViews() {}
    func layoutViews() {}
}
