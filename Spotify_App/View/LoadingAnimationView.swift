//
//  LoadingAnimationView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 20.10.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit


class LoadingAnimation {
    
    //MARK: - Variables
    static let backgroundLayer = CAShapeLayer()
    static let circle1 = CAShapeLayer()
    static let circle2 = CAShapeLayer()
    static let circle3 = CAShapeLayer()
    
    static let animation = CABasicAnimation(keyPath: "path")
    static let animation2 = CABasicAnimation(keyPath: "path")
    static let animation3 = CABasicAnimation(keyPath: "path")
   
    //  Setting Layer's paths
    private static func addLayerToView(view: UIView) {
        backgroundLayer.path = UIBezierPath(roundedRect: CGRect(x: view.center.x - 90, y: view.center.y - 60, width: 160, height: 90), cornerRadius: 15).cgPath
        backgroundLayer.fillColor = UIColor.cyan.withAlphaComponent(0.9).cgColor
        
        circle1.path = UIBezierPath(ovalIn: CGRect(x: view.center.x - 70, y: view.center.y - 25, width: 20, height: 20)).cgPath
        circle1.fillColor = UIColor.white.cgColor
        
        circle2.fillColor = UIColor.white.cgColor
        circle2.path = UIBezierPath(ovalIn: CGRect(x: view.center.x - 20, y: view.center.y - 25, width: 20, height: 20)).cgPath
        
        circle3.fillColor = UIColor.white.cgColor
        circle3.path = UIBezierPath(ovalIn: CGRect(x: view.center.x + 30, y: view.center.y - 25, width: 20, height: 20)).cgPath
        //CGAffineTransform
        view.layer.addSublayer(backgroundLayer)
        view.layer.addSublayer(circle1)
        view.layer.addSublayer(circle2)
        view.layer.addSublayer(circle3)
    }
    
    //MARK: - Functions
    public static func startAnimation(view: UIView) {
        ///TODO : Add here animation per favore
        let duration = 0.5
        addLayerToView(view: view)
        
        animation.duration = duration
        let toValue = UIBezierPath(ovalIn: CGRect(x: view.center.x - 70, y: view.center.y - 25, width: 24, height: 24)).cgPath
        animation.toValue = toValue
        animation.autoreverses = true
        animation.repeatCount = HUGE
        
        
        animation2.duration = duration
        animation2.beginTime = CACurrentMediaTime() + 0.17
        let toValue2 = UIBezierPath(ovalIn: CGRect(x: view.center.x - 20, y: view.center.y - 25 , width: 24, height: 24)).cgPath
        animation2.toValue = toValue2
        animation2.autoreverses = true
        animation2.repeatCount = HUGE
        
        
        animation3.duration = duration
        animation3.beginTime = CACurrentMediaTime() + 0.34
        let toValue3 = UIBezierPath(ovalIn: CGRect(x: view.center.x + 30, y: view.center.y - 25, width: 24, height: 24)).cgPath
        animation3.toValue = toValue3
        animation3.repeatCount = HUGE
        animation3.autoreverses = true
        
        circle1.add(animation, forKey: "wtf")
        circle2.add(animation2, forKey: "wtf")
        circle3.add(animation3, forKey: "wtf")
    }
    public static  func stopAnimation(view: UIView) {
        //first animate
        view.layer.sublayers?.removeAll()
    }
}
