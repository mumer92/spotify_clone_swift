//
//  SlippyTexts.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 30.11.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class SlippyTexts: UICollectionView {
    
    //MARK: - Variables
    var items : [String] = []
    let cellId = "cellId"
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 0
    private var leftPadding: CGFloat = 0
    private var rightPadding: CGFloat = 0
    
    //MARK: - Initialization
    init (frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, cellHeight: CGFloat, cellWidth: CGFloat) { //not working yet
        super.init(frame: frame, collectionViewLayout: layout)
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        isPagingEnabled = true
        backgroundColor = .green
        translatesAutoresizingMaskIntoConstraints = false
        
        dataSource = self
        delegate = self
        register(SlippyCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    public func padding(left: CGFloat, right: CGFloat) {//not working yet
        self.leftPadding = left
        self.rightPadding = right
    }
}
//MARK: - Extension
extension SlippyTexts: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return CGSize(width: cellWidth, height: cellHeight)
        return CGSize(width: 210, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
//MARK: - Extension
extension SlippyTexts: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SlippyCollectionViewCell
        cell.label.text = items[indexPath.row]
        cell.setupSlippyText()
        return cell
    }
}

class SlippyCollectionViewCell : UICollectionViewCell {
    
    //let slippyText = SlippyText()
//    let slippyText = SlippyText()
    var label : UILabel = {
        let label = UILabel()
        
        label.text = "text"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        label.textAlignment = NSTextAlignment.justified
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupSlippyText() {
        let slippyText = SlippyTextNew()
        addSubview(slippyText)
        
        slippyText.topAnchor.constraint(equalTo: topAnchor).isActive = true
        slippyText.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        slippyText.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        slippyText.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        slippyText.autoScrollDuration = true
        slippyText.aspettaDuration = 2
        slippyText.autoScrollDuration = true
    }
}
