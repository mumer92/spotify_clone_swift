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
    
    //MARK: - Variables
    var smallCustomView = MusicPlayerSmallSizeView()
    //var fullScreenCustomView = MusicPlayerSmallSizeView()
    var isSmall: Bool = false {
        didSet {
            if customView.isSmall {
                isSmall = true
            } else {
                isSmall = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        print("view didload worked amk.. let's set MusicPalyersmallsizeview")
    

        smallCustomView = customView.smallSizeView
        smallCustomView.upArrowButton.addTarget(self, action: #selector(deneme2), for: .touchUpInside)
        isSmall = true
    }
    
    @objc func deneme2() {
        print("deneme amk")
    }
    
}
