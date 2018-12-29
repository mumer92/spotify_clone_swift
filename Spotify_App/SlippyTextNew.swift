//
//  SlippyTextNew.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 3.12.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit
    ///TODO :
    // WHAT HAPPENS WHEN USER ADDS MULTIPLE LINES??????
public class SlippyTextNew: UIScrollView,  UIScrollViewDelegate {
    
    //MARK: - Public Objects
    var textObject : UILabel = {
        let label = UILabel()
        label.text = "sivasin yollarina cikayim daglarina"
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15)

        return label
    }()
    
    //MARK: - Public Variables
    public var aspettaDuration: Double = 3.5 //standart value
    public var forwardScrollDuration: Double = 3.5 //3.5 seconds is the default value
    public var backwardScrollDuration: Double = 3.5 // 3.5 seconds is the default value
    public var autoScrollDuration: Bool = true {
        didSet {
            forwardScrollDuration = Double(textWidth / 100)
            backwardScrollDuration = forwardScrollDuration
        }
    }
    
    
    public var attributedText: NSAttributedString = NSAttributedString(string: "") {
        didSet {
            text = attributedText.string
            textObject.attributedText = self.attributedText
            setupLayout()
            layoutIfNeeded()
        }
    }
    public var numberOfLines: Int = 1 { //todo
        didSet {
            if numberOfLines > 1 {
                
            }
        }
    }
    
    public var text: String = "" {
        didSet {
            textObject.text = text
            setupLayout()
            layoutIfNeeded()
        }
    }
    public var textWidth: CGFloat {
        get {
            return textFont.textWidth(str: text)
        }
    }
    public var textFont: UIFont {
        get{
            return textObject.font!
        }
    }
    public func getTextWidth(text: String) -> CGFloat { //to check multiple string values
        return textFont.textWidth(str: text)
    }
    
    //MARK: - Private Variables
    private var totalDuration : Double {
        get {
            return forwardScrollDuration + backwardScrollDuration + aspettaDuration
        }
    }
    private var frameWidth: CGFloat = 0 { ///todo i am not using it yet.
        didSet {
            if oldValue != frameWidth {
                layoutSubviews()
                autoScroll()
            }
        }
    }
    
    private var distance: CGFloat {
        get {
            return textWidth - frameWidth + 5
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    public override func layoutSubviews() {
        if bounds.width > 0 {
            frameWidth = bounds.width
        }
    }
    public func startSliding() {
        self.layoutIfNeeded()
        if distance > 0 { // if label is not fitting inside of scroll view than start animate it
            autoScroll()
        }
    }

    @objc func autoScroll() {
        if distance > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.aspettaDuration, execute: {
                UIView.animate(withDuration: self.forwardScrollDuration, delay: 0, options: [], animations: { //forward animation
                    self.contentOffset.x = self.distance
                })
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (2 * self.aspettaDuration) + self.forwardScrollDuration) {
                UIView.animate(withDuration: self.backwardScrollDuration, delay: 0, options: [], animations: {
                    self.contentOffset.x = 0
                })
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (2 * self.aspettaDuration) + self.backwardScrollDuration + self.forwardScrollDuration) {
                self.autoScroll()
            }
        }
    }
        
    
    
    //MARK: - Layout
    var textFieldWidthAnchor : NSLayoutConstraint?
    private func setupLayout() {
        addSubview(textObject)
        textObject.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        textObject.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    
        textFieldWidthAnchor?.isActive = false
        textFieldWidthAnchor = textObject.widthAnchor.constraint(equalToConstant: textWidth+10)
        textFieldWidthAnchor?.isActive = true
    }
}

//MARK: - Extension


