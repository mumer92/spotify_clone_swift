//
//  DateAndDurationView.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 11.02.2019.
//  Copyright © 2019 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit

class DateAndDurationView: UIView {
    var dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var durationLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var durationAttributedString = NSAttributedString() {
        didSet {
            durationLabel.attributedText = durationAttributedString
        }
    }
    var dateAttributedString = NSAttributedString() {
        didSet {
            dateLabel.attributedText = dateAttributedString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        durationLabel.setImage(image: UIImage(named: "clock")!, with: " 7h 12 min")
        dateLabel.setImage(image: UIImage(named: "calendar")!, with: " 19 Jan 2019")
        
        setView()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        addSubview(dateLabel)
        addSubview(durationLabel)
    }
    private func setLayout() {
        dateLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
//        dateLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        durationLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        durationLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        durationLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        //durationLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
}


extension UILabel {
    func setImage(image: UIImage, with text: String) {
        
        let attachment = NSTextAttachment()
        
        attachment.image = image.withRenderingMode(.alwaysTemplate).maskWithColor(color: .white)
        attachment.bounds = CGRect(x: 0, y: 0, width: 18, height: 19)
        let attachmentStr = NSAttributedString(attachment: attachment)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentStr)
        
        let textString = NSAttributedString(string: text, attributes: [.font: self.font])
        mutableAttributedString.append(textString)
        
        self.attributedText = mutableAttributedString
    }
}
