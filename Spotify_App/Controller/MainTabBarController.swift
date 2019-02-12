//
//  ViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 12.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController, ControlTabBarControllerDelegate {
    
    
    //MARK: - Layout Variables
    var musicPlayerSmallHeight : CGFloat {
        get {
            return tabBar.frame.height - 10
        }
    }
    var topConstraintForAlbumsTableView : NSLayoutConstraint?
    var tabBarHeightWithoutSafeBottom: CGFloat {
        get {
            return tabBar.frame.height - bottomSafeAreaHeight
        }
    }
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
    
     //distance to take it to full screen
    var distanceToFullScreen: CGFloat {
        get {
            return topSafeAreaHeight - view.frame.height
        }
    }
    
    //MARK: - Variables
    let musicPlayerViewController = MusicPlayerViewController()
    var musicPlayerView = PlayerView()
    var originalTabBarFrame : CGRect? = nil
    let screenSize = UIScreen.main.bounds
    
    var firstTouchPositionY : CGFloat?
    var locationYChange: CGFloat = 0
   
    //MARK: - View Appareance
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ///Todo animation code here
        LoadingAnimation.startAnimation(view: self.view)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (t) in
            LoadingAnimation.stopAnimation(view: self.view)
        }
       
        musicPlayerViewController.controlTabBarControllerDelegate = self
        tabBar.tintColor = .white
        tabBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 255)
        
        originalTabBarFrame = tabBar.frame
        
        setupTabBars()
        setUpMusicPlayerView()
        
        hidesBottomBarWhenPushed = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureMakeFullScreen(gesture:)))
        musicPlayerView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        musicPlayerView.addGestureRecognizer(panGesture)
        
        
       self.view.bringSubviewToFront(tabBar) //This is to keep tabBar in front of music players item.
    }
    
    //MARK: - Gesture Functions
    @objc func tapGestureMakeFullScreen(gesture: UITapGestureRecognizer) {
        musicPlayerViewController.isSmall = false
        musicPlayerFullScreenAnimation()
    }
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            firstTouchPositionY = gesture.location(in: view).y
        }
        if gesture.state == .changed {
            handlePanGestureChange(gesture: gesture)
        }
        if gesture.state == .ended {
            handlePanGestureEnded(gesture: gesture)
        }
    }
    
     ///TODO Doesn't work very well. fix it later on.
    @objc func handlePanGestureChange(gesture: UIPanGestureRecognizer) {
        let limit = view.frame.height * 0.15 // Change isSmall value when user exceeds the limit
        locationYChange = (gesture.location(in: view).y) - (firstTouchPositionY!) //
        
        if locationYChange < 0 { //moving up down
            topConstraintForAlbumsTableView?.constant = -self.tabBarHeightWithoutSafeBottom + locationYChange
            if locationYChange.magnitude > limit {
                musicPlayerViewController.isSmall = false
            }
        } else { //moving down
            topConstraintForAlbumsTableView?.constant = self.distanceToFullScreen + locationYChange
            if locationYChange > limit {
                musicPlayerViewController.isSmall = true
            }
        }
        
        if (topConstraintForAlbumsTableView?.constant)! > -tabBarHeightWithoutSafeBottom  { // can't be smaller than -tabBar.frame.height
            topConstraintForAlbumsTableView?.constant = -tabBarHeightWithoutSafeBottom
        }

        
    }
    @objc func handlePanGestureEnded(gesture: UIPanGestureRecognizer) {
        if musicPlayerViewController.isSmall {
            musicPlayerSmallScreenAnimation()
        } else {
            musicPlayerFullScreenAnimation()
        }
    }

    func musicPlayerFullScreenAnimation() {
        hideTabBar()
        UIView.animate(withDuration: 0.2) {
            self.topConstraintForAlbumsTableView?.constant = self.distanceToFullScreen
            self.view.layoutIfNeeded()
        }
        
    }
    
    func musicPlayerSmallScreenAnimation() {
        showTabBar()
        UIView.animate(withDuration: 0.2) {
            self.topConstraintForAlbumsTableView?.constant = -self.tabBarHeightWithoutSafeBottom
            self.view.layoutIfNeeded()
        }
        
    }
   
    //MARK: - Functions
    func showTabBar() {
        UIView.animate(withDuration: 0.2) {
            self.tabBar.center.y = self.view.frame.height - self.tabBar.frame.height / 2
            self.view.layoutIfNeeded()
        }
    }
    
    func hideTabBar() {
        UIView.animate(withDuration: 0.2) {
            self.tabBar.center.y = self.view.frame.height + self.tabBar.frame.height / 2
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Layout
    func setUpMusicPlayerView() {
        // tabBar.frame.height
        
        musicPlayerView = musicPlayerViewController.customView
        view.addSubview(musicPlayerView)
//        addChild(musicPlayerViewController)

        musicPlayerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        musicPlayerView.leftAnchor.constraint(equalTo: tabBar.leftAnchor).isActive = true
        musicPlayerView.rightAnchor.constraint(equalTo: tabBar.rightAnchor).isActive = true
        topConstraintForAlbumsTableView = musicPlayerView.topAnchor.constraint(equalTo: musicPlayerView.bottomAnchor, constant: -tabBar.frame.height)
        topConstraintForAlbumsTableView?.isActive = true

    }
    
    private func setupTabBars() {
    
        let homeViewController = UINavigationController(rootViewController: HomeViewController())

        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let libraryViewController = UINavigationController(rootViewController: LibraryViewController())
        
        homeViewController.tabBarItem.image = UIImage(named: "home")
        homeViewController.tabBarItem.title = "Home"
        
        searchViewController.tabBarItem.image = UIImage(named: "search")
        searchViewController.tabBarItem.title = "Browse"
        
        libraryViewController.tabBarItem.image = UIImage(named: "library")
        libraryViewController.tabBarItem.title = "Your Library"

        viewControllers = [homeViewController, searchViewController, libraryViewController]
    }
    
    //MARK: - UITabBar Delegate
    //To give small effect everytime i switch between tabs
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
