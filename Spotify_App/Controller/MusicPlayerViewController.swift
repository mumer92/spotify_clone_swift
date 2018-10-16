//
//  PlayerViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 12.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit
protocol ControlTabBarControllerDelegate: class {
    func musicPlayerFullScreenAnimation()
    func musicPlayerSmallScreenAnimation()
}
//ControlTabBarControllerDelegate
class MusicPlayerViewController: ViewController<PlayerView> {
    
     //MARK: - NSLayoutConstraints
    var topConstraintForAlbumsTableView : NSLayoutConstraint?
    
    //MARK: - Variables
    var controlTabBarControllerDelegate: ControlTabBarControllerDelegate?
    
    var originalTabBarFrame : CGRect? = nil
    let screenSize = UIScreen.main.bounds
    
    var firstTouchPosition : CGPoint?
    var locationChange: CGFloat = 0

    
    //MARK: - Variables
    var isSmall: Bool = true {
        didSet {
            if isSmall {
                customView.isSmall = self.isSmall
                print("Small")
                controlTabBarControllerDelegate?.musicPlayerSmallScreenAnimation()
            } else {
                customView.isSmall = self.isSmall
                print("FullScreen")
                controlTabBarControllerDelegate?.musicPlayerFullScreenAnimation()
            }
        }
    }
    
    
    //MARK: - View Appareance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isSmall = true
        
//        fullScreenCustomView = customView.fullScreenSizeView
//        smallCustomView = customView.smallSizeView
//        smallCustomView.upArrowButton.addTarget(self, action: #selector(deneme2), for: .touchUpInside)
        //Setting up Gesture Recognizers
                customView.upDownArrowButton.addTarget(self, action: #selector(upDownArrowButtonAction), for: .touchUpInside)
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

    @objc func upDownArrowButtonAction() {
        isSmall = !isSmall
    }
    
}

