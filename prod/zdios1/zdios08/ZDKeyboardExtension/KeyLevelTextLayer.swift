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
	static let keyLevelfont : UIFont = UIFont(name: "HelveticaNeue", size: 40.0)!
	//=========================================================
	// Constructors    
    init(frame: CGRect) {
        super.init()
        self.frame = frame
        self.font = KeyLevelTextLayer.keyLevelfont
        self.backgroundColor = Utilities.hexStringToUIColor("#b3bdc9").cgColor; //UIColor(  (hex: "b3bdc9"); //UIColor.gray.cgColor
        self.borderColor = Utilities.hexStringToUIColor("#f0f0f0").cgColor; //UIColor(hex: "f0f0f0"); //UIColor.red.cgColor
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
   	//=========================================================
    //
    class func getWidthForString(_ str: String) -> CGFloat {
    	return Utilities.getWidthForString(str,keyLevelFont);
    }
    //=========================================================
    
} // end of class
/*
 
*/


