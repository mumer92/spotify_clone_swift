//
//  CollectionViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 9.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController<V: CollectionView>: UICollectionViewController {
    
    override func loadView() {
        view = V()
        
    }
    var customView: V {
        return view as! V
    }
    
}
