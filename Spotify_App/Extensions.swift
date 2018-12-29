//
//  String Extension.swift
//  Spotify_App
//
//  Created by Anıl Akkaya on 6.12.2018.
//  Copyright © 2018 Anıl Akkaya. All rights reserved.
//

import Foundation
import UIKit
extension NSAttributedString {
    
    private func getFontSize(at index: Int) -> CGFloat {
        let fontAttribute : UIFont = self.attribute(NSAttributedString.Key.font, at: index, effectiveRange: NSRangePointer?.none) as! UIFont
        let fontSize : CGFloat = fontAttribute.pointSize
        print("fontSize : " , fontSize)
        return fontSize
    }
    
    private func getFont(at index: Int) -> UIFont {
        let fontAttribute : UIFont = self.attribute(NSAttributedString.Key.font, at: index, effectiveRange: NSRangePointer?.none) as! UIFont
        return fontAttribute
    }
    
    public func getLineWidth(lineText: String) -> CGFloat {
        var sum : CGFloat = 0
        return sum
    }
    
    public func getLargestLineWidth() -> CGFloat {
            
        var numberOfLines = 0
        var prevNumberCount = 0
        let string = self.string
        
        string.enumerateLines { (lineStr, _) in
            numberOfLines += 1
            print("SIZE : " , self.size().width)
            
//            find font size and calculate the width depending on font
//            print(numberOfLines, ". prevNumberCount : \(prevNumberCount) \n")
//            print(numberOfLines, ". prevNumberCount : \(self.getFontSize(at: prevNumberCount+1)) \n")
            prevNumberCount = lineStr.count

        }
        return 0
    }
}
extension String {
//    public func getLargestLineWidth() -> CGFloat {
//        return 0
//    }
}
extension UIFont {
    public func textWidth(str: String) -> CGFloat {
        return str.size(withAttributes: [NSAttributedString.Key.font : self]).width
    }
}
