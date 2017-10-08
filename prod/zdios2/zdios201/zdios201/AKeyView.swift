//
//  AKeyView.swift
//  zdios201
//
//  Created by Wanlou Feng on 25/9/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit

class AKeyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.cyan.cgColor
        self.isOpaque = false
        self.backgroundColor = UIColor.brown
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ frame: CGRect) {
        let h = frame.height
        let w = frame.width
        let color:UIColor = UIColor.yellow
        
        let drect = CGRect(x: 18, y: 18, width: w - 16, height: h - 16 )
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        
        color.set()
        bpath.fill()
      
    }
    
    

} //end of class

