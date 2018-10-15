//
//  PlayerViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 12.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit


class MusicPlayerViewController: ViewController<PlayerView> {
    
     //MARK: - NSLayoutConstraints
    var topConstraintForAlbumsTableView : NSLayoutConstraint?
    //var tabBarHeight: CGFloat = 0
    
    
    //MARK: - Variables
    
    var originalTabBarFrame : CGRect? = nil
    let screenSize = UIScreen.main.bounds
    
    var firstTouchPosition : CGPoint?
    var locationChange: CGFloat = 0

    
    //MARK: - Variables
    var smallCustomView = MusicPlayerSmallSizeView()
    var fullScreenCustomView = MusicPlayerFullScreenSizeView()
    
    var isSmall: Bool = true {
        didSet {
            if customView.isSmall {
                print("kuculdu")
                isSmall = false
                isStatusBarHidden = false
            } else {
                print("buyudu")
                isSmall = true
                isStatusBarHidden = true
            }
        }
    }
    
    
    //MARK: - View Appareance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isSmall = true
        
        fullScreenCustomView = customView.fullScreenSizeView
        smallCustomView = customView.smallSizeView
        
        smallCustomView.upArrowButton.addTarget(self, action: #selector(deneme2), for: .touchUpInside)
        
        //Setting up Gesture Recognizers
        
        
    }
    
    //MARK: - Delegate Status Bar
    var isStatusBarHidden: Bool = false {
        didSet {
            print("isStatisBarHidden : " , isStatusBarHidden)
            UIView.animate(withDuration: 1.1) {
                
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }

    @objc func deneme2() {
        print("deneme amk")
    }
    
}
