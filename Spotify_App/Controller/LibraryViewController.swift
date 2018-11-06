//
//  YourLibraryViewController.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 12.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class LibraryViewController: ViewController<LibraryView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.backgroundColor = .gray
        
        setupNavigationBar()
    }
    @objc func profileImageTapped(btn: UIBarButtonItem) {
        print("profileImageTapped worked...")
    }
}

extension LibraryViewController {
   
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0.6)
        self.navigationController?.navigationBar.isTranslucent = true
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        label.text = "Your Library"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        
        let profileImageButton = UIBarButtonItem(image: UIImage(named: "the_way_of_all_flesh"), style: .done, target: self, action: #selector(profileImageTapped(btn:)))
        navigationItem.leftBarButtonItem = profileImageButton
        navigationItem.titleView = label
    }
    
    
    
}
