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
        setLayoutForSmallSize()
        backgroundColor = grayColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setLayoutForSmallSize() {
        print("setLayoutF")
        addSubview(smallSizeView)
        //smallSizeView.translatesAutoresizingMaskIntoConstraints = false
        smallSizeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        smallSizeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        smallSizeView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        smallSizeView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
    private func setLayoutForFullScreenSize() {
    
    }
    
}
