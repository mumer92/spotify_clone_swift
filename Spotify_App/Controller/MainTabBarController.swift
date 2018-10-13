//
//  ViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 12.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - NSLayoutConstraints
    var topConstraintForAlbumsTableView : NSLayoutConstraint? 
    
    //MARK: - Variables
    var topSafeAreaHeight : CGFloat {
        get {
            if let window = UIApplication.shared.keyWindow , #available(iOS 11.0, *) {
                return window.safeAreaInsets.top
            } else {
                return 0
            }
        }
    }
    var bottomSafeAreaHeight : CGFloat  {
        get {
            if let window = UIApplication.shared.keyWindow , #available(iOS 11.0, *) {
                return window.safeAreaInsets.bottom
            } else {
                return 0
            }
        }
    }
    
    var originalTabBarFrame : CGRect? = nil
    let screenSize = UIScreen.main.bounds
    
    var firstTouchPosition : CGPoint?
    var locationChange: CGFloat = 0
    
    var musicPlayerView = PlayerView()
    
    //MARK: - View Appareance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalTabBarFrame = tabBar.frame
        
        setupTabBars()
        setUpMusicPlayerView()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        musicPlayerView.addGestureRecognizer(panGesture)
        
        
        hidesBottomBarWhenPushed = true
        
        tabBar.tintColor = .white
        tabBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 255)
    }
    
    //MARK: - Handle UIPanGestureRecognizer
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            firstTouchPosition = gesture.location(in: view)
        }
        if gesture.state == .changed {
            handlePanGestureChange(gesture: gesture)
        }
        if gesture.state == .ended {
            handlePanGestureEnded(gesture: gesture)
        }
    }
    
    @objc func handlePanGestureChange(gesture: UIPanGestureRecognizer) {
        
        locationChange = (gesture.location(in: view).y) - (firstTouchPosition!.y) // positive value means it moved down. negative value means that it moved up
        
        topConstraintForAlbumsTableView?.constant = (gesture.location(in: view).y) - (view.frame.height) + topSafeAreaHeight + bottomSafeAreaHeight
        if (topConstraintForAlbumsTableView?.constant)! > -tabBar.frame.height  { //can't be smaller than -tabBar.frame.height
            topConstraintForAlbumsTableView?.constant = -tabBar.frame.height + bottomSafeAreaHeight
        }
    
    }
    private func playerFullScreenAnimation() {

        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            self.topConstraintForAlbumsTableView?.constant = (self.tabBar.frame.height) - (self.view.frame.height) + self.bottomSafeAreaHeight + self.topSafeAreaHeight + 10 //full screen
            self.view.layoutIfNeeded()
        }) { (true) in
            
        }
    }
    private func playerSmallScreenAnimation() {
        
        topConstraintForAlbumsTableView?.constant = -tabBar.frame.height

        UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (true) in
            
        }
    }
    @objc func handlePanGestureEnded(gesture: UIPanGestureRecognizer) {
        print(gesture.location(in: view))
    }
    
    func deneme() {
        print("deneme worked amk \n")
    }
    
    //MARK: - Functions
    
    func showTabBar() {
        
        UIView.animate(withDuration: 1) {
            if let originalTabBarFrame = self.originalTabBarFrame {
                self.tabBar.frame = originalTabBarFrame
                self.view.layoutIfNeeded()
            }
        }
    }
    func hideTabBar() {
        UIView.animate(withDuration: 1) {
            self.tabBar.frame = CGRect(origin: CGPoint(x: 0, y: self.screenSize.maxY), size: CGSize(width: self.screenSize.width, height:
                (self.originalTabBarFrame?.height)!))
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Layout
    
    func setUpMusicPlayerView() {
        let musicPlayerViewController = MusicPlayerViewController()
        musicPlayerView = musicPlayerViewController.customView
        view.addSubview(musicPlayerView)
        addChild(musicPlayerViewController)
        
        musicPlayerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        musicPlayerView.leftAnchor.constraint(equalTo: tabBar.leftAnchor).isActive = true
        musicPlayerView.rightAnchor.constraint(equalTo: tabBar.rightAnchor).isActive = true
        topConstraintForAlbumsTableView = musicPlayerView.topAnchor.constraint(equalTo: musicPlayerView.bottomAnchor, constant: -tabBar.frame.height)
        topConstraintForAlbumsTableView?.isActive = true
    }
    private func setupTabBars() {
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let browseViewController = UINavigationController(rootViewController: BrowseViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let radioViewController = UINavigationController(rootViewController: RadioViewController())
        let libraryViewController = UINavigationController(rootViewController: LibraryViewController())
        
        homeViewController.tabBarItem.image = UIImage(named: "home")
        homeViewController.tabBarItem.title = "Home"
        
        searchViewController.tabBarItem.image = UIImage(named: "search")
        searchViewController.tabBarItem.title = "Browse"
        
        browseViewController.tabBarItem.image = UIImage(named: "browse")
        browseViewController.tabBarItem.title = "Search"
        
        radioViewController.tabBarItem.image = UIImage(named: "radio")
        radioViewController.tabBarItem.title = "Radio"
        
        libraryViewController.tabBarItem.image = UIImage(named: "library")
        libraryViewController.tabBarItem.title = "Your Library"

        viewControllers = [homeViewController,browseViewController, searchViewController, radioViewController, libraryViewController]
    }
    
    //MARK: - UITabBar Delegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = self.tabBar.items?.index(of: item)
        let subView = tabBar.subviews[index!+1].subviews.first as! UIImageView
      
        subView.transform = CGAffineTransform.identity
        UIView.animateKeyframes(withDuration: 0.08, delay: 0.04, options: [.autoreverse], animations: {
            subView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (true) in
            subView.transform = CGAffineTransform.identity
        }
    }

}
