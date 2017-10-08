//
//  KeyLevelTextLayer.swift
//  zdios05a
//
//  Created by Richard Feng on 5/12/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class KeyLevelTextLayer: CATextLayer { // KeyLevelTextLayer.getWidthForString
    
    var parentKeyLevel:KeyLevel = KeyLevel()
	static let keyLevelfont : UIFont = UIFont(name: "HelveticaNeue", size: 40.0)!
	//=========================================================
	// Constructors    
    init(frame: CGRect) {
        super.init()
        self.frame = frame
        self.font = KeyLevelTextLayer.keyLevelfont
        self.backgroundColor = hexStringToUIColor("#b3bdc9").cgColor; //UIColor(  (hex: "b3bdc9"); //UIColor.gray.cgColor
        self.borderColor = hexStringToUIColor("#f0f0f0").cgColor; //UIColor(hex: "f0f0f0"); //UIColor.red.cgColor
        self.borderWidth = 3
        self.alignmentMode = "center"
        self.foregroundColor = UIColor.darkGray.cgColor
       
        //let radius: CGFloat = frame.width / 2.0 //change it to .height if you need spread for height
        let path = UIBezierPath(rect: CGRect(x: -0.5 * frame.width, y: -0.5 * frame.height, width: 2.1 * frame.width, height: 2.1 * frame.height))
        self.cornerRadius = 2
        self.shadowColor = UIColor.darkGray.cgColor
        self.shadowOffset = CGSize(width: 0.0, height: 0.0)  //Here you control x and y
        self.shadowOpacity = 0.0
        self.shadowRadius = 25.0 //Here your control your blur
        self.masksToBounds =  false
        self.shadowPath = path.cgPath
        
    } // end of func
     
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
   	//=========================================================
	// Overrides
	 
     override func draw(in ctx: CGContext) {
        //let fontSize = self.fontSize
        //let height = self.bounds.size.height //+ fontSize/10
        //let yDiff = CGFloat(2.0) //(height-fontSize)/2 // - fontSize/10
        
        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: 1.0)  //yDiff)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
   
   	//=========================================================
	// Operations
		
    func addHighlight(){
        shadowOpacity = 0.85
    }
    
    func removeHighlight(){
       shadowOpacity = 0.0
    }
/*
     if (highlighted) {
     self.backgroundColor = UIColorFromRGB(0x387038);
     }
     else {
     self.backgroundColor = UIColorFromRGB(0x5bb75b);
     }
*/
   	//=========================================================
    class func getWidthForString(_ str: String) -> CGFloat {
        if(str.characters.count>=2){}
        
        let attrs = [NSFontAttributeName: keyLevelfont]
        let attributedString = NSMutableAttributedString(string:str, attributes:attrs)
        return attributedString.size().width
    }
    
    func hexStringToUIColor (_ hex:String) -> UIColor {
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
/*
 class func getWidthForString(_ str: String, font: UIFont) -> CGFloat {
 let attrs = [NSFontAttributeName:font]
 let attributedString = NSMutableAttributedString(string:str, attributes:attrs)
 return attributedString.size().width
 }
 
 //  UIColorExtensions.swift
 import UIKit
 extension UIColor {
 
 convenience init(argb: UInt) {
 self.init(
 red: CGFloat((argb & 0xFF0000) >> 16) / 255.0,
 green: CGFloat((argb & 0x00FF00) >> 8) / 255.0,
 blue: CGFloat(argb & 0x0000FF) / 255.0,
 alpha: CGFloat((argb & 0xFF000000) >> 24) / 255.0
 )
 }
 }
 usage:
 
 var clearColor: UIColor = UIColor.init(argb: 0x00000000)
 var redColor: UIColor = UIColor.init(argb: 0xFFFF0000)
 
*/


