//
//  PopUpContainerView.swift
//  zdios202
//
//  Created by Wanlou Feng on 11/10/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class PopUpSettings {
  
    static var popUpBorderWidth = CGFloat(3.0)
    static var popUpBorderColor:UIColor = UIColor.gray
    static var popUpGap = CGFloat(10.0) // The gap below popup and above the KeyView will be used as corner radius between pop-up and self.frame
    static var popUpCornerRadius = CGFloat(5.0)
    static var popUpHeight = CGFloat(40.0)
    static var heightAboveKeyboardView:CGFloat {
        get {
            return popUpHeight + popUpGap + popUpBorderWidth
        }
    }
} //end of class

struct ArcAngles {
    static let left  = CGFloat(Double.pi)
    static let up    = CGFloat(1.5*Double.pi)
    static let down  = CGFloat(0.5 * Double.pi)
    static let right = CGFloat(0.0)
}

class PopUpContainerView: UIView {
    
    //=====================================================================
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        self.isOpaque = false
        Commander.popUpContainerView = self
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //=====================================================================
    // Overrides
    public override func draw(_ frame: CGRect) {
        if let kv = self.popUpKeyView {
            let ctx = UIGraphicsGetCurrentContext()
            ctx?.saveGState()
            ctx?.translateBy(x: 0, y: PopUpSettings.heightAboveKeyboardView)
            drawPopUpPathForKeyView(kv,width: 200)
            ctx?.restoreGState()
        }
        
    } //end of func
    
   
    //=====================================================================
    // Pop-up
    
    var popUpKeyView : KeyView?
    func showPopUp(_ kv:KeyView){
        if let _ = kv.keyDefinition {
            popUpKeyView = kv
            self.setNeedsDisplay()
        }
    }
    func hidePopUp(){
        popUpKeyView = nil
        self.setNeedsDisplay()
    }
    
  
    
    
    

    
    func drawPopUpPathForKeyView(_ keyView:KeyView, width:CGFloat) {
        //-------------------------------------------------
        // ------ calculate maxW
        let minDelta =  PopUpSettings.popUpCornerRadius + PopUpSettings.popUpGap
        var maxW = self.frame.width
        if self.frame.minX < minDelta {maxW -= self.frame.minX}
        if self.frame.width - keyView.frame.maxX < minDelta {maxW -= self.frame.width - keyView.frame.maxX}
        let minW = keyView.frame.width + 2*minDelta
        // ------- calculate target width
        var targetW = width
        if targetW > maxW {
            targetW = maxW
        }
        if targetW < minW {
            targetW = minW
        }
        
        var delta = (targetW - keyView.frame.width)/2
        if delta < minDelta { delta = 0 }
        var x = keyView.frame.minX - delta
        if x<0 {
            x = 0
        } else if x+targetW > maxW {
            x -= x+targetW - maxW
        }
        let y = keyView.frame.minY - PopUpSettings.popUpGap - PopUpSettings.popUpHeight
        
        let popUpFrame:CGRect = CGRect(x:x,y:y,width:targetW,height: PopUpSettings.popUpHeight)
     
        //-------------------------------------------------
        let strokeColor:UIColor = PopUpSettings.popUpBorderColor
        strokeColor.set()
        
        let x1 = popUpFrame.minX
        let x2 = keyView.frame.minX
        let x3 = keyView.frame.minX + keyView.frame.width
        let x4 = popUpFrame.minX + popUpFrame.width
        
        let y1 = popUpFrame.minY
        let y2 = popUpFrame.minY + popUpFrame.height
        let y3 = keyView.frame.minY
        let y4 = keyView.frame.minY + keyView.frame.height
        
        let r1 = PopUpSettings.popUpCornerRadius
        let r2 = PopUpSettings.popUpGap
        let r3 = keyView.layer.cornerRadius
        
        let p1 = CGPoint(x:x1, y:y1), p2 = CGPoint(x:x4, y:y1), p3 = CGPoint(x:x1, y:y2), p4 = CGPoint(x:x4, y:y2)
        let p1c = p1.shift(x:r1, y:r1), p2c = p2.shift(x:-r1, y:r1), p3c = p3.shift(x:r1, y:-r1), p4c = p4.shift(x:-r1, y:-r1)
        let p1a = p1.shift(x:r1, y:0), p2a = p2.shift(x:0, y:r1), p3a = p3.shift(x:0, y:-r1), p4a = p4.shift(x:-r1, y:0)
        
        let q1 = CGPoint(x:x2, y:y3), q2 = CGPoint(x:x3, y:y3)
        let q3 = CGPoint(x:x2, y:y4), q4 = CGPoint(x:x3, y:y4)
        //let q1c = q1.shift(x:r2, y:r2),
        //let q2c = q2.shift(x:-r2, y:r2),
        let q3c = q3.shift(x:r3, y:-r3), q4c = q4.shift(x:-r3, y:-r3)
        //let q1a = q1.shift(x:r2, y:0),
        //let q2a = q2.shift(x:0, y:r2),
        let q3a = q3.shift(x:0, y:-r3), q4a = q4.shift(x:-r3, y:0)
        
        let s1 = CGPoint(x:x2, y:y2), s2 = CGPoint(x:x3, y:y2)
        let s1c = s1.shift(x:-r2,y:r2), s2c = s2.shift(x:r2,y:r2)
        let s1a = s1.shift(x:-r2,y:0), s2a = s2.shift(x:0,y:r2)
        
        //-------------------------------------------------
        let path:UIBezierPath = UIBezierPath()
        path.lineWidth = PopUpSettings.popUpBorderWidth
        path.move(to: p1a)
        path.addArc(withCenter: p1c, radius: r1, startAngle: ArcAngles.up, endAngle: ArcAngles.left, clockwise: false)
        
        if abs(x1-x2) > r1+r2 {
            path.addLine(to:p3a)
            path.addArc(withCenter: p3c, radius: r1, startAngle: ArcAngles.left, endAngle: ArcAngles.down, clockwise: false)
            
            path.addLine(to:s1a)
            path.addArc(withCenter: s1c, radius: r2, startAngle: ArcAngles.up, endAngle: ArcAngles.right, clockwise: true)
        } else {
            path.addLine(to:q1)
        }

        if abs(x3-x4) > r1+r2 {
            path.addLine(to:s2a)
            path.addArc(withCenter: s2c, radius: r2, startAngle: ArcAngles.left, endAngle: ArcAngles.up, clockwise: true)
            
            path.addLine(to:p4a)
            path.addArc(withCenter: p4c, radius: r1, startAngle: ArcAngles.down, endAngle: ArcAngles.right, clockwise: false)
        } else {
            path.addLine(to:q2)
        }
        path.addLine(to:p2a)
        path.addArc(withCenter: p2c, radius: r1, startAngle: ArcAngles.right, endAngle: ArcAngles.up, clockwise: false)
        
        path.close()
        
        path.fill()
        
        //-------------------------------------------------
        let path1:UIBezierPath = UIBezierPath()
        path1.lineWidth = PopUpSettings.popUpBorderWidth
        path1.move(to:q1)
        
        path1.addLine(to:q3a)
        path1.addArc(withCenter: q3c, radius: r3, startAngle: ArcAngles.left, endAngle: ArcAngles.down, clockwise: false)
        
        path1.addLine(to:q4a)
        path1.addArc(withCenter: q4c, radius: r3, startAngle: ArcAngles.down, endAngle: ArcAngles.right, clockwise: false)
        path1.addLine(to:q2)
       
        path1.stroke()
        
    } //end of func
    
    
    
    
    
    
    //
    
} //end of class

extension CGPoint {
    func shift(x:CGFloat, y:CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y:self.y + y)
    }
}


