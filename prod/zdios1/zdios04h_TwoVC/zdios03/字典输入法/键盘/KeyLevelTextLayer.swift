//
//  KeyLevelTextLayer.swift
//  zdios05a
//
//  Created by Richard Feng on 5/12/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class KeyLevelTextLayer: CATextLayer {
    
    var parentKeyLevel:KeyLevel = KeyLevel()
	static let keyLevelFont : UIFont = UIFont(name: Configuration.KeyLevel_Font_Name, size: Configuration.KeyLevel_Font_Size)!
	//=========================================================
	// Constructors    
    init(frame: CGRect) {
        super.init()
        self.frame = frame
        self.font = KeyLevelTextLayer.keyLevelFont
        self.backgroundColor = Utilities.hexStringToUIColor(Configuration.KeyLevel_BackgroundColor_1_HexString).cgColor
        self.borderColor = Utilities.hexStringToUIColor(Configuration.KeyLevel_BorderColor_HexString).cgColor
        self.borderWidth = 0.5
        self.alignmentMode = "center"
        self.foregroundColor = UIColor.black.cgColor
        self.zPosition = 100
        //let radius: CGFloat = frame.width / 2.0 //change it to .height if you need spread for height
        let path = UIBezierPath(rect: CGRect(x: -0.5 * frame.width, y: -0.5 * frame.height, width: 2.0 * frame.width, height: 2.0 * frame.height))
        self.cornerRadius = 0
        self.shadowColor = UIColor.white.cgColor
        self.shadowOffset = CGSize(width: 0.0, height: 0.0)  //Here you control x and y
        self.shadowOpacity = 0.0
        self.shadowRadius = 20.0 //Here your control your blur
        self.masksToBounds =  false
        self.shadowPath = path.cgPath
        self.fontSize = Configuration.KeyLevel_Font_Size //This really take effect. Size insize UIFont is not really working.
        self.alignmentMode = kCAAlignmentCenter
        
        
        self.contentsScale = UIScreen.main.scale
        
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
        // Codes copied from https://stackoverflow.com/questions/4765461/vertically-align-text-in-a-catextlayer
//        let yDiff: CGFloat
//        let fontSize: CGFloat
//        let height = self.bounds.height
//        
//        if let attributedString = self.string as? NSAttributedString {
//            fontSize = attributedString.size().height
//            yDiff = (height-fontSize)/2
//        } else {
//            fontSize = self.fontSize
//            yDiff = (height-fontSize)/2 - fontSize/10
//        }
        
        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: Configuration.KeyLevel_PaddingTop)  // original code: yDiff)
        super.draw(in: ctx)
        ctx.restoreGState()

    }
   
   	//=========================================================
	// Operations
    var backgroundColorBeforeHighlight:CGColor? = Utilities.hexStringToUIColor(Configuration.KeyLevel_BackgroundColor_1_HexString).cgColor
    func addHighlight(){
        self.zPosition = 900
        self.shadowOpacity = 0.95
        self.shadowColor = UIColor.white.cgColor
        backgroundColorBeforeHighlight = self.backgroundColor
        self.backgroundColor = UIColor.white.cgColor
    }
   
    func removeHighlight(){
        self.zPosition = 100
        self.shadowOpacity = 0.0
        self.shadowColor = UIColor.white.cgColor
        self.backgroundColor = backgroundColorBeforeHighlight
    }
   	//=========================================================
    //
    class func getWidthForString(_ str: String) -> CGFloat {
    	return Utilities.getStringWidthForFont(str,font: keyLevelFont);
    }
    //=========================================================
    
} // end of class
/*
 func addRedHighlight(){
 self.zPosition = 900
 self.shadowOpacity = 0.75
 self.shadowColor = UIColor.red.cgColor
 self.backgroundColor = UIColor.white.cgColor
 }
*/


