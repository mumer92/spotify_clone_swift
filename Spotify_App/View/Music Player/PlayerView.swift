//
//  PlayerView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 12.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit


class PlayerView: View {
    
    //MARK: - Variables
    var smallSizeView = MusicPlayerSmallSizeView()
    var fullScreenSizeView = MusicPlayerFullScreenSizeView()
    var isPlaying : Bool = false {
        didSet{
            
        }
    }
    
    var isSmall: Bool = true {
        didSet {
            if isSmall == true {
                print("setting layout for small size")
                setLayoutForSmallSize()
            } else {
                setLayoutForFullScreenSize()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("init workeeddddd")
//        setLayoutForSmallSize()
        setLayoutForFullScreenSize()
        backgroundColor = grayColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setLayoutForFullScreenSize() {
        addSubview(fullScreenSizeView)
        fullScreenSizeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fullScreenSizeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        fullScreenSizeView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        fullScreenSizeView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
    private func setLayoutForSmallSize() {
        addSubview(smallSizeView)
        smallSizeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        smallSizeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        smallSizeView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        smallSizeView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
    
    
}
