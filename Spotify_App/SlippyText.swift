//
//  SlippyText.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 7.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

public class SlippyText: UIScrollView,  UIScrollViewDelegate {
    
    //MARK: - Public Variables
    private var totalDuration : Double {
        get {
            print("total duration : " , forwardDuration + backwardDuration + 2 * aspettaDuration)
            return forwardDuration + backwardDuration + aspettaDuration
        }
    }
    public var aspettaDuration: Double = 3.5 // standart value
    
    ///this values has to change on text widths
    public var forwardDuration: Double = 2.5 //2 seconds is the standart value
    public var backwardDuration: Double = 2.5 // 2 seconds is the standart value
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
    //MARK: - Private Variables
    private var textWidth: CGFloat {
        get {
            return textFont.textWidth(str: text) // todo fix it later on...
        }
    }
    
    //MARK: - Init
    init(TextObject: UIView, Text: String,Font: UIFont) {
        super.init(frame: CGRect())
        self.textObject = TextObject
    }
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
    public func startSlidingIfNeeded() {
        
        self.layoutIfNeeded()
        let distance = textWidth - bounds.width + 5
        if distance > 0 { // if label is not fitting inside of scroll view than start animate it
            autoScroll(distance : distance)
        }
    }
    @objc func autoScroll(distance : CGFloat) { //9 sn icin 2.5 a 4.5tu.
        DispatchQueue.main.asyncAfter(deadline: .now() + aspettaDuration, execute: {
            UIView.animate(withDuration: self.forwardDuration, delay: 0, options: .curveLinear, animations: {
                self.contentOffset.x += distance
            }, completion: nil)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (2 * aspettaDuration) + forwardDuration, execute: {
            
            UIView.animate(withDuration: self.backwardDuration, delay: 0, options: .curveLinear, animations: {
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
        textObject.widthAnchor.constraint(equalToConstant: textWidth+20).isActive = true
    }
}

//To get text size from UIFont. The reason why i used this is, to get label & text field & text view's text width globally.
//MARK: - Extension
//extension UIFont {
//    public func textWidth(str: String) -> CGFloat {
//        return str.size(withAttributes: [NSAttributedString.Key.font : self]).width
//    }
//}


//    private func getViewType(textObject: UIView) -> AnyObject {
//        var object = NSObject()
//        if type(of: textObject) == UILabel.self {
//            object = textObject as! UILabel
//        } else if type(of: textObject) == UITextView.self {
//            object = textObject as! UITextView
//        } else if type(of: textObject) == UITextField.self {
//            object = textObject as! UITextField
//        }
//        return object
//    }
