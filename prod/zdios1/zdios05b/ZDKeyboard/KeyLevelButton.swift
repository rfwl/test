//
//  KeyLevelButton.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 23/10/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
//

import UIKit

class KeyLevelButton: UIButton {
    
    var parentKeyLevel:KeyLevel = KeyLevel()  
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        //parentKeyLevel = keyLevel
        titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18.0)
        titleLabel?.textAlignment = .center
        setTitleColor(UIColor(white: 38.0/255, alpha: 1.0), for: UIControlState.normal)
        titleLabel?.sizeToFit()
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(red: 180/255, green: 240.0/255, blue: 180.0/255, alpha: 1.0).cgColor,
            UIColor(red: 220.0/255, green: 210.0/255, blue: 200.0/255, alpha: 1.0).cgColor]
        //setBackgroundImage(gradient, for: .normal)
        self.layer.insertSublayer(gradient, at: 0)

        layer.borderColor = UIColor.red.cgColor
        layer.isHidden = false
        layer.borderWidth = 1.0
        layer.masksToBounds = true
        layer.cornerRadius = 3.0
        
        contentVerticalAlignment = .center
        contentHorizontalAlignment = .center
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0)
        
        
    } // end of func
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //===================================================================
    // 
    var contentVC:KeyLevelViewController?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       contentVC?.reportTouches(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentVC?.reportTouches(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         contentVC?.reportTouches(touches, with: event)  
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
         //contentVC?.reportTouches(touches, with: event)
    }
    //===================================================================
} //end of class

