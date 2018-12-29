//
//  SlippyText.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 30.11.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

public class SlippyText: UIScrollView,  UIScrollViewDelegate {
    
    //MARK: - Public Variables
    private var totalDuration : Double {
        get {
            return forwardScrollDuration + backwardScrollDuration + aspettaDuration
        }
    }
    //private var frameWidth
    public var aspettaDuration: Double = 3.5 //standart value
    private var frameWidth: CGFloat = 0
    //this values has to change on text widths
    public var forwardScrollDuration: Double = 3.5 //3.5 seconds is the default value
    public var backwardScrollDuration: Double = 3.5 // 3.5 seconds is the default value
    public var autoScrollDuration: Bool = true {
        didSet {
            forwardScrollDuration = Double(textWidth / 100)
            backwardScrollDuration = forwardScrollDuration
        }
    }
    public var textObject: UIView? {
        didSet {
            textObject?.translatesAutoresizingMaskIntoConstraints = false
            setupTextObjectLayout()
        }
    }
    
    public var text: String {
        get {
            if let textObject = textObject {
                if type(of: textObject) == UILabel.self {
                    let object = textObject as! UILabel
                    guard let str = object.text else {return ""}
                    return str
                } else if type(of: textObject) == UITextView.self {
                    let object = textObject as! UITextView
                    return object.text
                } else if type(of: textObject) == UITextField.self {
                    let object = textObject as! UITextField
                    guard let str = object.text else {return ""}
                    return str
                }
            }
            return ""
        }
    }
    
    public var textFont: UIFont {
        get{
            if let textObject = textObject {
                if type(of: textObject) == UILabel.self {
                    let object = textObject as! UILabel
                    return object.font
                } else if type(of: textObject) == UITextView.self {
                    let object = textObject as! UITextView
                    guard let font = object.font else {return UIFont()}
                    return font
                } else if type(of: textObject) == UITextField.self {
                    let object = textObject as! UITextField
                    guard let font = object.font else {return UIFont()}
                    return font
                }
            }
            return UIFont()
        }
    }
    
    public var textWidth: CGFloat { //checks only 1 strings text width value
        get {
            return textFont.textWidth(str: text)
        }
    }
    public func getTextWidth(text: String) -> CGFloat { //to check multiple string values
        return textFont.textWidth(str: text)
    }
    //MARK: - Private Variables
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
        guard let textObject = textObject else {return}
        textObject.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions
    
    public override func layoutSubviews() {
        print(" frame.width : " , frame.width)
        if frame.width > 0 { //exception
            frameWidth = frame.width
        }
    }

    public func startSlidingIfNeeded() { //private yapacam olmadi
        print("startSlidingIfNeeded() distance : " , distance)
        self.layoutIfNeeded()
        if distance > 0 { // if label is not fitting inside of scroll view than start animate it
            autoScroll(distance : distance)
        }
    }
    @objc func autoScroll(distance : CGFloat) { //9 sn icin 2.5 a 4.5tu.
        DispatchQueue.main.asyncAfter(deadline: .now() + aspettaDuration, execute: {
            UIView.animate(withDuration: self.forwardScrollDuration, delay: 0, options: .curveLinear, animations: {
                self.contentOffset.x += distance
            }, completion: nil)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (2 * aspettaDuration) + forwardScrollDuration, execute: {
            
            UIView.animate(withDuration: self.backwardScrollDuration, delay: 0, options: .curveLinear, animations: {
                self.contentOffset.x = 0
                self.layoutIfNeeded()
            }, completion: { (true) in
                self.autoScroll(distance: distance) //recuvsive
            })
        })
    }
    
    
    //MARK: - Layout
    private func setupTextObjectLayout() {
        guard let textObject = textObject else {return}
        addSubview(textObject)
        textObject.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        textObject.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textObject.widthAnchor.constraint(equalToConstant: textWidth+40).isActive = true //todo check again
    }
}

//MARK: - Extension
//extension UIFont {
//    public func textWidth(str: String) -> CGFloat {
//        return str.size(withAttributes: [NSAttributedString.Key.font : self]).width
//    }
//}
