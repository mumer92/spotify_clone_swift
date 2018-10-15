//
//  ViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 12.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - Layout Variables
    var topConstraintForAlbumsTableView : NSLayoutConstraint?
    var tabBarHeight: CGFloat {
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
    
    //MARK: - Variables
    let musicPlayerViewController = MusicPlayerViewController()
    var musicPlayerView = PlayerView()
    var originalTabBarFrame : CGRect? = nil
    let screenSize = UIScreen.main.bounds
    
    var firstTouchPosition : CGPoint?
    var locationChange: CGFloat = 0
    
   
    
    //MARK: - View Appareance
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    //MARK: - Handle UIPanGestureRecognizer
    @objc func tapGestureMakeFullScreen(gesture: UITapGestureRecognizer) {
        playerFullScreenAnimation()
    }
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            firstTouchPosition = gesture.location(in: view)
        }
        if gesture.state == .changed {
            handlePanGestureChange(gesture: gesture)
        }
        if gesture.state == .ended {
            handlePanGestureEnded(gesture: gesture)
            //animations must work
        }
    }
    
    @objc func handlePanGestureChange(gesture: UIPanGestureRecognizer) {
        
        let oldLocation = locationChange
        locationChange = (gesture.location(in: view).y) - (firstTouchPosition!.y) // positive value means it moved down. negative value means that it moved up
        
        let difference = locationChange - oldLocation
        topConstraintForAlbumsTableView?.constant += difference
        
        if (topConstraintForAlbumsTableView?.constant)! > -tabBarHeight  { //can't be smaller than -tabBar.frame.height
            topConstraintForAlbumsTableView?.constant = -tabBarHeight
        }
    }
    @objc func handlePanGestureEnded(gesture: UIPanGestureRecognizer) {
        let limit = view.frame.height * 0.1
        print("limit : " , limit)
        if locationChange < 0 { // moved up
            locationChange.magnitude > limit
            playerFullScreenAnimation()
        } else { // moved down
            locationChange > limit
            playerSmallScreenAnimation()
        }
    }

    private func playerFullScreenAnimation() {
//        let shouldMove: CGFloat =  -(view.frame.height) + bottomSafeAreaHeight //full screen topSafeAreaHeight
          let shouldMove: CGFloat = -(view.frame.height) + topSafeAreaHeight  //full screen
        topConstraintForAlbumsTableView?.constant = shouldMove
        
        
//        self.selectedViewController = musicPlayerViewController
        //musicPlayerViewController.isStatusBarHidden = true
        
        hideTabBar()
        UIView.animate(withDuration: 0.2) {
            self.setNeedsStatusBarAppearanceUpdate()
            self.view.layoutIfNeeded()
        }
    }

    //MARK: - bla bla
    private func playerSmallScreenAnimation() {
        showTabBar()
        UIView.animate(withDuration: 0.2) {
            self.topConstraintForAlbumsTableView?.constant = -self.tabBarHeight
            self.view.layoutIfNeeded()
        }
    }
    func deneme() {
        print("deneme worked amk \n")
    }
    
    //MARK: - Functions
    func showTabBar() {
        UIView.animate(withDuration: 0.2) {
            self.tabBar.center.y -= self.tabBar.frame.height
            self.view.layoutIfNeeded()
        }
    }
    
    func hideTabBar() {
        UIView.animate(withDuration: 0.2) {
            self.tabBar.center.y += self.tabBar.frame.height
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Layout
    ///todo
    func setUpMusicPlayerView() {
        
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
