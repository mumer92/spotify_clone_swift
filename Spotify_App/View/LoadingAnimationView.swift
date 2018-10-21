//
//  LoadingAnimationView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 20.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class LoadingAnimationView: UIView {
    let backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.black.withAlphaComponent(0.8).cgColor
        return layer
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(backgroundLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

