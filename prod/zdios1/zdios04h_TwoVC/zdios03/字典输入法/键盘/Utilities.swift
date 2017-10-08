//
//  Utilities.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 22/02/2017.
//  Copyright © 2017 Richard Feng. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    static func getStringWidthForFont(_ str: String, font:UIFont) -> CGFloat {        
    	let attrs = [NSFontAttributeName: font]
        let attributedString = NSMutableAttributedString(string:str, attributes:attrs)
        return attributedString.size().width
    }
	    
    static func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

} // end of class
