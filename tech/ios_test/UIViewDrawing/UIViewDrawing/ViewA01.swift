//
//  ViewA.swift
//  UIViewDrawing
//
//  Created by Wanlou Feng on 27/9/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit

class ViewA: UIView {
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 8
        self.layer.borderColor = UIColor.cyan.cgColor
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let h = 60 //frame.height
        let w = frame.width
        let color:UIColor = UIColor.red
        color.set()
        //let rt1 = CGRect(x: 8, y: 8, width: w - 16, height: h - 16 )
        //let path1:UIBezierPath = UIBezierPath(rect: rt1)
        //path1.fill()
        let rt2 = CGRect(x: 18, y: 18, width: Int(w - 36), height: h )
        let path2:UIBezierPath = UIBezierPath(roundedRect: rt2, cornerRadius: 10  )
        path2.stroke()
        let rt3 = CGRect(x: 88, y: 88, width: 100, height: 100 )
        let path3:UIBezierPath = UIBezierPath(roundedRect: rt3, cornerRadius: 10  )
        path3.stroke()
        
        let x1 = 20, x2 = 320, x3 = 120, x4 = 220
        let y1 = 50, y2 = 150, y3 = 180, y4 = 380
        let r1 = CGFloat(10.0), r2 = CGFloat(5.0), r3 = CGFloat(15.0)
        
        let p1 = CGPoint(x:x1, y:y1), p2 = CGPoint(x:x2, y:y1), p3 = CGPoint(x:x1, y:y2), p4 = CGPoint(x:x2, y:y2)        
        let p1c = p1.shift(x:r1, y:r1), p2c = p2.shift(x:-r1, y:r1), p3c = p3.shift(x:r1, y:-r1), p4c = p4.shift(x:-r1, y:-r1)   
        let p1a = p1.shift(x:r1, y:0), p2a = p2.shift(x:0, y:r1), p3a = p3.shift(x:0, y:-r1), p4a = p4.shift(x:-r1, y:0)   
        let p1b = p1.shift(x:0, y:r1), p2b = p2.shift(x:-r1, y:0), p3b = p3.shift(x:r1, y:0), p4b = p4.shift(x:0, y:-r1)
                        
        let left  = CGFloat(Double.pi)
        let up    = CGFloat(1.5*Double.pi)
        let down  = CGFloat(2.0 * Double.pi)
        let right = CGFloat(0.0)
        let color1:UIColor = UIColor.green
        color1.set()
        
        let path4:UIBezierPath = UIBezierPath()
        path4.move(to: p1a)
        path4.addArc(withCenter: p1c, radius: r1, startAngle: up, endAngle: left, clockwise: true)
        
        path4.addLine(to:p3a)        
        path4.addArc(withCenter: p3c, radius: r1, startAngle: left, endAngle: down, clockwise: true)
        
        path4.addLine(to:p4a)        
        path4.addArc(withCenter: p4c, radius: r1, startAngle: down, endAngle: right, clockwise: true)
        
        path4.addLine(to:p2a)        
        path4.addArc(withCenter: p2c, radius: r1, startAngle: right, endAngle: up, clockwise: true)
        
        path4.addLine(to:p1a)
        path4.close()
        
        let q1 = CGPoint(x:x3, y:y3), q2 = CGPoint(x:x4, y:y3), q3 = CGPoint(x:x3, y:y4), q4 = CGPoint(x:x4, y:y4)
        let q1c = q1.shift(x:r2, y:r2), q2c = q2.shift(x:-r2, y:r2), q3c = q3.shift(x:r2, y:-r2), q4c = q4.shift(x:-r2, y:-r2)   
        let q1a = q1.shift(x:r2, y:0), q2a = q2.shift(x:0, y:r2), q3a = q3.shift(x:0, y:-r2), q4a = q4.shift(x:-r2, y:0)   
        let q1b = q1.shift(x:0, y:r2), q2b = q2.shift(x:-r2, y:0), q3b = q3.shift(x:r2, y:0), q4b = q4.shift(x:0, y:-r2)
        
          
        let path5:UIBezierPath = UIBezierPath()
        path5.move(to: q1a)
        path5.addArc(withCenter: q1c, radius: r1, startAngle: up, endAngle: left, clockwise: true)
        
        path5.addLine(to:q3a)        
        path5.addArc(withCenter: q3c, radius: r1, startAngle: left, endAngle: down, clockwise: true)
        
        path5.addLine(to:q4a)        
        path5.addArc(withCenter: q4c, radius: r1, startAngle: down, endAngle: right, clockwise: true)
        
        path5.addLine(to:q2a)        
        path5.addArc(withCenter: q2c, radius: r1, startAngle: right, endAngle: up, clockwise: true)
        
        path5.addLine(to:q1a)
        path5.close()
        path5.stroke()
        
        let s1 = CGPoint(x:x2, y:y2), s2 = CGPoint(x:x3, y:y2)
        let s1c = s1.shift(x:-r3,y:r3), s2c = s2.shift(x:r3,y:r3)
        let s1a = s1.shift(x:-r3,y:0), s2a = s2.shift(x:0,y:r3)
        let s1b = s1.shift(x:0,y:r3), s2c = s2.shift(x:r3,y:0)
        
        let path6:UIBezierPath = UIBezierPath()
        path6.move(to: s1a)
        path6.addArc(withCenter: s1c, radius: r1, startAngle: up, endAngle: right, clockwise: true)
        
        path6.move(to: s2a)
        path6.addArc(withCenter: s2c, radius: r1, startAngle: left, endAngle: up, clockwise: true)
        path6.close()
        path6.stroke()
        
        
        
        
        
    } //end of func
    
    
    
} //end of class

extension CGPoint {
    func shift(x:CGFloat, y:CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y:self.y + y)
    }
}


/*
 
 
 # To round all four corners
 let rectangle = CGRect(x: 0, y: 0, width: 100, height: 100)
 let path = UIBezierPath(roundedRect: rectangle, cornerRadius: 20)
 
 # To round some of the corners
 let rectangle = CGRect(x: 0, y: 0, width: 100, height: 100)
 let path = UIBezierPath(roundedRect: rectangle, byRoundingCorners: [.TopLeft, .BottomRight], cornerRadii: CGSize(width: 35, height: 35))
 
 # To have a different corner radius for each corner, then you'll have to add the arc for each circle individually.
 This comes down to calculating the center and the start and end angle of each arc.
 You'll find that the center of each arc is inset the corner radius from corresponding corner of the rectangle.
 CGPoint(x: rectangle.minX + upperLeftRadius, y: rectangle.minY + upperLeftRadius)
 The start and end angle for each arc will be either straight left, up, down, or right.
 The angles is clockwise, not counter-clockwise.
 
 # extension to drw round rectangle with different corner radius:
 
 extension UIBezierPath {
 convenience init(roundedRect rect: CGRect, topLeftRadius r1: CGFloat, topRightRadius r2: CGFloat, bottomRightRadius r3: CGFloat, bottomLeftRadius r4: CGFloat) {
 let left  = CGFloat(M_PI)
 let up    = CGFloat(1.5*M_PI)
 let down  = CGFloat(M_PI_2)
 let right = CGFloat(0.0)
 self.init()
 addArcWithCenter(CGPoint(x: rect.minX + r1, y: rect.minY + r1), radius: r1, startAngle: left,  endAngle: up,    clockwise: true)
 addArcWithCenter(CGPoint(x: rect.maxX - r2, y: rect.minY + r2), radius: r2, startAngle: up,    endAngle: right, clockwise: true)
 addArcWithCenter(CGPoint(x: rect.maxX - r3, y: rect.maxY - r3), radius: r3, startAngle: right, endAngle: down,  clockwise: true)
 addArcWithCenter(CGPoint(x: rect.minX + r4, y: rect.maxY - r4), radius: r4, startAngle: down,  endAngle: left,  clockwise: true)
 closePath()
 }
 }
 
 let path = UIBezierPath(roundedRect: rectangle, topLeftRadius: 30, topRightRadius: 10, bottomRightRadius: 15, bottomLeftRadius: 5)
 
 -
 */
