//
//  KeyLevelTextLayer.swift
//  zdios05a
//
//  Created by Richard Feng on 5/12/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class KeyLevelTextLayer: CenterCATextLayer {
    
    var parentKeyLevel:KeyLevel = KeyLevel()
    
    init(frame: CGRect) {
        super.init()

        //self.string = text
        //self.parentKeyLevel = keyLvl
        self.backgroundColor = UIColor.gray.cgColor
        self.borderColor = UIColor.red.cgColor
        self.borderWidth = 3
        self.alignmentMode = "center"
        self.foregroundColor = UIColor.white.cgColor
       
        let radius: CGFloat = frame.width / 2.0 //change it to .height if you need spread for height
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.1 * radius, height: frame.height))
        self.cornerRadius = 2
        self.shadowColor = UIColor.black.cgColor
        self.shadowOffset = CGSize(width: 6.5, height: 0.4)  //Here you control x and y
        self.shadowOpacity = 0.5
        self.shadowRadius = 5.0 //Here your control your blur
        self.masksToBounds =  false
        self.shadowPath = path.cgPath
        
        
        
    } // end of func
    
    func addShadow(){
        self.shadowOpacity = 0.5
    }
    func removeShadow(){
       self.shadowOpacity = 0.0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
   

    
    

} // end of class
