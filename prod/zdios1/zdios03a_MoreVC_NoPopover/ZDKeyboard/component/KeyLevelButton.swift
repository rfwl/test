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
    
    override init() {
        super.init(frame: new CGRect(x:0,y:0,width:40,height:20))        
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        //parentKeyLevel = keyLevel
        titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18.0)
        titleLabel?.textAlignment = .center
        setTitleColor(UIColor(white: 38.0/255, alpha: 1.0), for: UIControlState.normal)
        titleLabel?.sizeToFit()
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        let gradientColors: [AnyObject] = [UIColor(red: 80.0/255, green: 80.0/255, blue: 80.0/255, alpha: 1.0).cgColor, UIColor(red: 60.0/255, green: 60.0/255, blue: 60.0/255, alpha: 1.0).cgColor]
        gradient.colors = gradientColors // Declaration broken into two lines to prevent 'unable to bridge to Objective C' error.
        //setBackgroundImage(gradient.UIImageFromCALayer(), for: .normal)
        
        let selectedGradient = CAGradientLayer()
        selectedGradient.frame = bounds
        let selectedGradientColors: [AnyObject] = [UIColor(red: 67.0/255, green: 116.0/255, blue: 224.0/255, alpha: 1.0).cgColor, UIColor(red: 32.0/255, green: 90.0/255, blue: 214.0/255, alpha: 1.0).cgColor]
        selectedGradient.colors = selectedGradientColors // Declaration broken into two lines to prevent 'unable to bridge to Objective C' error.
        //setBackgroundImage(selectedGradient.UIImageFromCALayer(), for: .Selected)
        
        layer.masksToBounds = true
        layer.cornerRadius = 3.0
        
        contentVerticalAlignment = .center
        contentHorizontalAlignment = .center
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0)
        
        
        
    } // end of func
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
} //end of class

