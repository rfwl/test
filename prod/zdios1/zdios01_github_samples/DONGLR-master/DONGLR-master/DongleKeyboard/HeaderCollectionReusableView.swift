//
//  HeaderCollectionReusableView.swift
//  Dongle
//
//  Created by vixi on 14.10.15.
//  Copyright © 2015 Anatoly Rosencrantz. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    // MARK: outlets and vars
    @IBOutlet var sectionLabel: UILabel!
    
    // MARK: lifetime methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //тень
        var shadowRect = bounds
        shadowRect.size.width *= 0.1
        
        let shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: CGFloat(0.0))
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3.0, height: 0.0);
        layer.shadowOpacity = 0.8
        layer.shadowPath = shadowPath.cgPath
    }
    
    // MARK: my methods
    func rotateSectionLabel(){
        sectionLabel.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        
        for constraint in self.constraints{
            if constraint.identifier == "topConstraint"{
                constraint.constant = sectionLabel.frame.height/2
                self.updateConstraintsIfNeeded()
            }
        }
    }
    
}
