//
//  HomeViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 30.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: ViewController<HomeView> {
    var customTabBarController: MainTabBarController? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let tabBarCntrllr = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {
            print("HomeViewController's root view controller is not MainTabBarController...")
            return
        }
        customTabBarController = tabBarCntrllr
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
            return
        }
        statusBarView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    
}
