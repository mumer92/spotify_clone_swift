//
//  ViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 12.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class ViewController<V: View>: UIViewController {
    
    override func loadView() {
        view = V()
        print("wazzup")
    }
    var customView: V {
        return view as! V
    }
    
}
