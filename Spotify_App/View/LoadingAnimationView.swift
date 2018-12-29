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
    static let backgroundView = UIView()
    static let circle1 = CAShapeLayer()
    static let circle2 = CAShapeLayer()
    static let circle3 = CAShapeLayer()

    static let circleAnimation = CABasicAnimation(keyPath: "path")
    static let circleAnimation2 = CABasicAnimation(keyPath: "path")
    static let circleAnimation3 = CABasicAnimation(keyPath: "path")
   
    //  Setting Layer's paths
    private static func addLayerToView(view: UIView) {
        
        backgroundView.frame = CGRect(x: view.center.x - 80, y: view.center.y + -45, width: 160, height: 90)
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.cornerRadius = 15
        backgroundView.alpha = 0
        
        circle1.path = UIBezierPath(ovalIn: CGRect(x: 30, y: 35 , width: 20, height: 20)).cgPath
        circle1.fillColor = UIColor.white.cgColor
        
        circle2.fillColor = UIColor.white.cgColor
        circle2.path = UIBezierPath(ovalIn: CGRect(x: 70, y: 35, width: 20, height: 20)).cgPath //center
        
        circle3.fillColor = UIColor.white.cgColor
        circle3.path = UIBezierPath(ovalIn: CGRect(x: 110, y: 35, width: 20, height: 20)).cgPath
        
        view.addSubview(backgroundView)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        backgroundView.layer.addSublayer(circle1)
        backgroundView.layer.addSublayer(circle2)
        backgroundView.layer.addSublayer(circle3)

        //Animating view when it's showing up
        UIView.animate(withDuration: 0.3) {
            backgroundView.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
            backgroundView.alpha = 1
            backgroundView.layoutIfNeeded()
        }
        backgroundView.transform = CGAffineTransform.identity
        
    }
    
    //MARK: - Functions
    public static func startAnimation(view: UIView) {
        addLayerToView(view: view)
        let duration = 0.5
        
        circleAnimation.duration = duration
        let toValue = UIBezierPath(ovalIn: CGRect(x: 30, y: 35, width: 23, height: 23)).cgPath
        circleAnimation.toValue = toValue
        circleAnimation.autoreverses = true
        circleAnimation.repeatCount = HUGE
        
        circleAnimation2.duration = duration
        circleAnimation2.beginTime = CACurrentMediaTime() + 0.17
        let toValue2 = UIBezierPath(ovalIn: CGRect(x: 70, y: 35 , width: 23, height: 23)).cgPath
        circleAnimation2.toValue = toValue2
        circleAnimation2.autoreverses = true
        circleAnimation2.repeatCount = HUGE
        
        circleAnimation3.duration = duration
        circleAnimation3.beginTime = CACurrentMediaTime() + 0.34
        let toValue3 = UIBezierPath(ovalIn: CGRect(x: 110, y: 35, width: 23, height: 23)).cgPath
        circleAnimation3.toValue = toValue3
        circleAnimation3.repeatCount = HUGE
        circleAnimation3.autoreverses = true
        
        circle1.add(circleAnimation, forKey: "wtf")
        circle2.add(circleAnimation2, forKey: "wtf")
        circle3.add(circleAnimation3, forKey: "wtf")
        
    }
    public static  func stopAnimation(view: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {//removing from view with animation
            backgroundView.transform = CGAffineTransform.init(translationX: 0, y: 60)
            backgroundView.alpha = 0.3
            backgroundView.layoutIfNeeded()
        }) { (true) in
            backgroundView.removeFromSuperview()
        }
    }
}
