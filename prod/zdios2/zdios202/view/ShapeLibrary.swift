//
//  ShapeLibrary.swift
//  zdios202
//
//  Created by Wanlou Feng on 2/10/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit
class ShapeLibrary {
    
    //======================================================================
    static func drawShape(_ shape:String, bounds: CGRect, color: UIColor) { 
        if shape.caseInsensitiveCompare("Backspace") == ComparisonResult.orderedSame {
            drawBackspace(bounds, color: color)
        } else if shape.caseInsensitiveCompare("Next") == ComparisonResult.orderedSame {
            drawGlobe(bounds, color: color)
        }
        
    }
    
    static func drawBackspace(_ bounds: CGRect, color: UIColor) {
        let factors = getFactors(CGSize(width:44, height:32), toRect: bounds)
        let xScalingFactor = factors.xScalingFactor
        let yScalingFactor = factors.yScalingFactor
        let lineWidthScalingFactor = factors.lineWidthScalingFactor
        
        centerShape(fromSize: CGSize(width:44 * xScalingFactor, height:32 * yScalingFactor), toRect: bounds)
    
        //// Color Declarations
        let color = color
        let color2 = UIColor.gray
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 16 * xScalingFactor, y: 32 * yScalingFactor))
        bezierPath.addLine(to: CGPoint(x: 38 * xScalingFactor, y: 32 * yScalingFactor))
        bezierPath.addCurve(to: CGPoint(x: 44 * xScalingFactor, y: 26 * yScalingFactor),
                            controlPoint1: CGPoint(x: 38 * xScalingFactor, y: 32 * yScalingFactor),
                            controlPoint2: CGPoint(x: 44 * xScalingFactor, y: 32 * yScalingFactor))
        bezierPath.addCurve(to: CGPoint(x: 44 * xScalingFactor, y: 6 * yScalingFactor),
                            controlPoint1: CGPoint(x: 44 * xScalingFactor, y: 22 * yScalingFactor),
                            controlPoint2: CGPoint(x: 44 * xScalingFactor, y: 6 * yScalingFactor))
        bezierPath.addCurve(to: CGPoint(x: 36 * xScalingFactor, y: 0 * yScalingFactor),
                            controlPoint1: CGPoint(x: 44 * xScalingFactor, y: 6 * yScalingFactor),
                            controlPoint2: CGPoint(x: 44 * xScalingFactor, y: 0 * yScalingFactor))
        bezierPath.addCurve(to: CGPoint(x: 16 * xScalingFactor, y: 0 * yScalingFactor),
                            controlPoint1: CGPoint(x: 32 * xScalingFactor, y: 0 * yScalingFactor),
                            controlPoint2: CGPoint(x: 16 * xScalingFactor, y: 0 * yScalingFactor))
        bezierPath.addLine(to: CGPoint(x: 0 * xScalingFactor, y: 18 * yScalingFactor))
        bezierPath.addLine(to: CGPoint(x: 16 * xScalingFactor, y: 32 * yScalingFactor))
        bezierPath.close()
        color.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 20 * xScalingFactor, y: 10 * yScalingFactor))
        bezier2Path.addLine(to: CGPoint(x: 34 * xScalingFactor, y: 22 * yScalingFactor))
        bezier2Path.addLine(to: CGPoint(x: 20 * xScalingFactor, y: 10 * yScalingFactor))
        bezier2Path.close()
        UIColor.gray.setFill()
        bezier2Path.fill()
        color2.setStroke()
        bezier2Path.lineWidth = 2.5 * lineWidthScalingFactor
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 20 * xScalingFactor, y: 22 * yScalingFactor))
        bezier3Path.addLine(to: CGPoint(x: 34 * xScalingFactor, y: 10 * yScalingFactor))
        bezier3Path.addLine(to: CGPoint(x: 20 * xScalingFactor, y: 22 * yScalingFactor))
        bezier3Path.close()
        UIColor.red.setFill()
        bezier3Path.fill()
        color2.setStroke()
        bezier3Path.lineWidth = 2.5 * lineWidthScalingFactor
        bezier3Path.stroke()
        
        endCenter()
        
    } //end of func
    
    
    
    static func drawGlobe(_ bounds: CGRect, color: UIColor) {
        
        let factors = getFactors(CGSize(width: 41, height: 40), toRect: bounds)
        let xScalingFactor = factors.xScalingFactor
        let yScalingFactor = factors.yScalingFactor
        let lineWidthScalingFactor = factors.lineWidthScalingFactor
        
        centerShape(fromSize: CGSize(width: 41 * xScalingFactor, height: 40 * yScalingFactor), toRect: bounds)
        
        
        //// Color Declarations
        let color = color
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0 * xScalingFactor, y: 0 * yScalingFactor, width: 40 * xScalingFactor, height: 40 * yScalingFactor))
        color.setStroke()
        ovalPath.lineWidth = 1 * lineWidthScalingFactor
        ovalPath.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 20 * xScalingFactor, y: -0 * yScalingFactor))
        bezierPath.addLine(to: CGPoint(x: 20 * xScalingFactor, y: 40 * yScalingFactor))
        bezierPath.addLine(to: CGPoint(x: 20 * xScalingFactor, y: -0 * yScalingFactor))
        bezierPath.close()
        color.setStroke()
        bezierPath.lineWidth = 1 * lineWidthScalingFactor
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 0.5 * xScalingFactor, y: 19.5 * yScalingFactor))
        bezier2Path.addLine(to: CGPoint(x: 39.5 * xScalingFactor, y: 19.5 * yScalingFactor))
        bezier2Path.addLine(to: CGPoint(x: 0.5 * xScalingFactor, y: 19.5 * yScalingFactor))
        bezier2Path.close()
        color.setStroke()
        bezier2Path.lineWidth = 1 * lineWidthScalingFactor
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 21.63 * xScalingFactor, y: 0.42 * yScalingFactor))
        bezier3Path.addCurve(to: CGPoint(x: 21.63 * xScalingFactor, y: 39.6 * yScalingFactor),
                             controlPoint1: CGPoint(x: 21.63 * xScalingFactor, y: 0.42 * yScalingFactor),
                             controlPoint2: CGPoint(x: 41 * xScalingFactor, y: 19 * yScalingFactor))
        bezier3Path.lineCapStyle = .round
        
        color.setStroke()
        bezier3Path.lineWidth = 1 * lineWidthScalingFactor
        bezier3Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 17.76 * xScalingFactor, y: 0.74 * yScalingFactor))
        bezier4Path.addCurve(to: CGPoint(x: 18.72 * xScalingFactor, y: 39.6 * yScalingFactor),
                             controlPoint1: CGPoint(x: 17.76 * xScalingFactor, y: 0.74 * yScalingFactor),
                             controlPoint2: CGPoint(x: -2.5 * xScalingFactor, y: 19.04 * yScalingFactor))
        bezier4Path.lineCapStyle = .round
        
        color.setStroke()
        bezier4Path.lineWidth = 1 * lineWidthScalingFactor
        bezier4Path.stroke()
        
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: 6 * xScalingFactor, y: 7 * yScalingFactor))
        bezier5Path.addCurve(to: CGPoint(x: 34 * xScalingFactor, y: 7 * yScalingFactor),
                             controlPoint1: CGPoint(x: 6 * xScalingFactor, y: 7 * yScalingFactor),
                             controlPoint2: CGPoint(x: 19 * xScalingFactor, y: 21 * yScalingFactor))
        bezier5Path.lineCapStyle = .round
        
        color.setStroke()
        bezier5Path.lineWidth = 1 * lineWidthScalingFactor
        bezier5Path.stroke()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.move(to: CGPoint(x: 6 * xScalingFactor, y: 33 * yScalingFactor))
        bezier6Path.addCurve(to: CGPoint(x: 34 * xScalingFactor, y: 33 * yScalingFactor),
                             controlPoint1: CGPoint(x: 6 * xScalingFactor, y: 33 * yScalingFactor),
                             controlPoint2: CGPoint(x: 19 * xScalingFactor, y: 22 * yScalingFactor))
        bezier6Path.lineCapStyle = .round
        
        color.setStroke()
        bezier6Path.lineWidth = 1 * lineWidthScalingFactor
        bezier6Path.stroke()
        
        endCenter()
    } // end of func

    //====================================================================================
    // Helper
    static func getFactors(_ fromSize: CGSize, toRect: CGRect) -> (xScalingFactor: CGFloat, yScalingFactor: CGFloat, lineWidthScalingFactor: CGFloat, fillIsHorizontal: Bool, offset: CGFloat) {
            
            let xSize = { () -> CGFloat in
                let scaledSize = (fromSize.width / CGFloat(2))
                if scaledSize > toRect.width {
                    return (toRect.width / scaledSize) / CGFloat(2)
                }
                else {
                    return CGFloat(0.5)
                }
            }()
            
            let ySize = { () -> CGFloat in
                let scaledSize = (fromSize.height / CGFloat(2))
                if scaledSize > toRect.height {
                    return (toRect.height / scaledSize) / CGFloat(2)
                }
                else {
                    return CGFloat(0.5)
                }
            }()
            
            let actualSize = min(xSize, ySize)
            
            return (actualSize, actualSize, actualSize, false, 0)
        } //end of func

      static func centerShape(fromSize: CGSize, toRect: CGRect) {
            let xOffset = (toRect.width - fromSize.width) / CGFloat(2)
            let yOffset = (toRect.height - fromSize.height) / CGFloat(2)
            
            let ctx = UIGraphicsGetCurrentContext()
            ctx?.saveGState()
            ctx?.translateBy(x: xOffset, y: yOffset)

      } //end of func

      static func endCenter() {
            let ctx = UIGraphicsGetCurrentContext()
            ctx?.restoreGState()
      } //end of func

    
    
} // end of class



/*
 // TODO: these shapes were traced and as such are erratic and inaccurate; should redo as SVG or PDF
 
 ///////////////////
 // SHAPE OBJECTS //
 ///////////////////
 
 class BackspaceShape: Shape {
 override func drawCall(_ color: UIColor) {
 drawBackspace(self.bounds, color: color)
 }
 }
 
 class ShiftShape: Shape {
 var withLock: Bool = false {
 didSet {
 self.overflowCanvas.setNeedsDisplay()
 }
 }
 
 override func drawCall(_ color: UIColor) {
 drawShift(self.bounds, color: color, withRect: self.withLock)
 }
 }
 
 class GlobeShape: Shape {
 override func drawCall(_ color: UIColor) {
 drawGlobe(self.bounds, color: color)
 }
 }
 
 class Shape: UIView {
 var color: UIColor? {
 didSet {
 if let _ = self.color {
 self.overflowCanvas.setNeedsDisplay()
 }
 }
 }
 
 // in case shapes draw out of bounds, we still want them to show
 var overflowCanvas: OverflowCanvas!
 
 convenience init() {
 self.init(frame: CGRect.zero)
 }
 
 override required init(frame: CGRect) {
 super.init(frame: frame)
 
 self.isOpaque = false
 self.clipsToBounds = false
 
 self.overflowCanvas = OverflowCanvas(shape: self)
 self.addSubview(self.overflowCanvas)
 }
 
 required init(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 var oldBounds: CGRect?
 override func layoutSubviews() {
 if self.bounds.width == 0 || self.bounds.height == 0 {
 return
 }
 if oldBounds != nil && self.bounds.equalTo(oldBounds!) {
 return
 }
 oldBounds = self.bounds
 
 super.layoutSubviews()
 
 let overflowCanvasSizeRatio = CGFloat(1.25)
 let overflowCanvasSize = CGSize(width: self.bounds.width * overflowCanvasSizeRatio, height: self.bounds.height * overflowCanvasSizeRatio)
 
 self.overflowCanvas.frame = CGRect(
 x: CGFloat((self.bounds.width - overflowCanvasSize.width) / 2.0),
 y: CGFloat((self.bounds.height - overflowCanvasSize.height) / 2.0),
 width: overflowCanvasSize.width,
 height: overflowCanvasSize.height)
 self.overflowCanvas.setNeedsDisplay()
 }
 
 func drawCall(_ color: UIColor) { /* override me! */ }
 
 class OverflowCanvas: UIView {
 unowned var shape: Shape
 
 init(shape: Shape) {
 self.shape = shape
 
 super.init(frame: CGRect.zero)
 
 self.isOpaque = false
 }
 
 required init(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 override func draw(_ rect: CGRect) {
 let ctx = UIGraphicsGetCurrentContext()
 CGColorSpaceCreateDeviceRGB()
 ctx?.saveGState()  //CGContextSaveGState(ctx?)
 
 let xOffset = (self.bounds.width - self.shape.bounds.width) / CGFloat(2)
 let yOffset = (self.bounds.height - self.shape.bounds.height) / CGFloat(2)
 ctx?.translateBy(x: xOffset, y: yOffset) //CGContextTranslateCTM(ctx?, xOffset, yOffset)
 
 self.shape.drawCall(shape.color != nil ? shape.color! : UIColor.black)
 
 ctx?.restoreGState()  //CGContextRestoreGState(ctx?)
 }
 }
 }
 
 
 func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
 UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
 
 imageView.image?.draw(in: view.bounds)
 
 let context = UIGraphicsGetCurrentContext()
 
 context?.move(to: fromPoint)
 context?.addLine(to: toPoint)
 
 context?.setLineCap(CGLineCap.round)
 context?.setLineWidth(brushWidth)
 context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
 context?.setBlendMode(CGBlendMode.normal)
 context?.strokePath()
 
 imageView.image = UIGraphicsGetImageFromCurrentImageContext()
 imageView.alpha = opacity
 UIGraphicsEndImageContext()
 }
 
 /////////////////////
 // SHAPE FUNCTIONS //
 /////////////////////
 */


/*
func drawShift(_ bounds: CGRect, color: UIColor, withRect: Bool) {
    let factors = getFactors(CGSize(width: 38, height: (withRect ? 34 + 4 : 32)), toRect: bounds)
    let xScalingFactor = factors.xScalingFactor
    let yScalingFactor = factors.yScalingFactor - factors.lineWidthScalingFactor
     
     centerShape(CGSizeMake(38 * xScalingFactor, (withRect ? 34 + 4 : 32) * yScalingFactor), toRect: bounds)
     
     
     //// Color Declarations
     let color2 = color
     
     //// Bezier Drawing
     let bezierPath = UIBezierPath()
     bezierPath.moveToPoint(CGPointMake(28 * xScalingFactor, 18 * yScalingFactor))
     bezierPath.addLineToPoint(CGPointMake(38 * xScalingFactor, 18 * yScalingFactor))
     bezierPath.addLineToPoint(CGPointMake(38 * xScalingFactor, 18 * yScalingFactor))
     bezierPath.addLineToPoint(CGPointMake(19 * xScalingFactor, 0 * yScalingFactor))
     bezierPath.addLineToPoint(CGPointMake(0 * xScalingFactor, 18 * yScalingFactor))
     bezierPath.addLineToPoint(CGPointMake(0 * xScalingFactor, 18 * yScalingFactor))
     bezierPath.addLineToPoint(CGPointMake(10 * xScalingFactor, 18 * yScalingFactor))
     bezierPath.addLineToPoint(CGPointMake(10 * xScalingFactor, 28 * yScalingFactor))
     bezierPath.addCurveToPoint(CGPointMake(14 * xScalingFactor, 32 * yScalingFactor), controlPoint1: CGPointMake(10 * xScalingFactor, 28 * yScalingFactor), controlPoint2: CGPointMake(10 * xScalingFactor, 32 * yScalingFactor))
     bezierPath.addCurveToPoint(CGPointMake(24 * xScalingFactor, 32 * yScalingFactor), controlPoint1: CGPointMake(16 * xScalingFactor, 32 * yScalingFactor), controlPoint2: CGPointMake(24 * xScalingFactor, 32 * yScalingFactor))
     bezierPath.addCurveToPoint(CGPointMake(28 * xScalingFactor, 28 * yScalingFactor), controlPoint1: CGPointMake(24 * xScalingFactor, 32 * yScalingFactor), controlPoint2: CGPointMake(28 * xScalingFactor, 32 * yScalingFactor))
     bezierPath.addCurveToPoint(CGPointMake(28 * xScalingFactor, 18 * yScalingFactor), controlPoint1: CGPointMake(28 * xScalingFactor, 26 * yScalingFactor), controlPoint2: CGPointMake(28 * xScalingFactor, 18 * yScalingFactor))
     bezierPath.closePath()
     color2.setFill()
     bezierPath.fill()
     
     
     if withRect {
     //// Rectangle Drawing
     let rectanglePath = UIBezierPath(rect: CGRectMake(10 * xScalingFactor, 34 * yScalingFactor, 18 * xScalingFactor, 4 * yScalingFactor))
     color2.setFill()
     rectanglePath.fill()
     }
     
     endCenter()
    
} //end of func

func drawGlobe(_ bounds: CGRect, color: UIColor) {
    
     let factors = getFactors(CGSizeMake(41, 40), toRect: bounds)
     let xScalingFactor = factors.xScalingFactor
     let yScalingFactor = factors.yScalingFactor
     let lineWidthScalingFactor = factors.lineWidthScalingFactor
     
     centerShape(CGSizeMake(41 * xScalingFactor, 40 * yScalingFactor), toRect: bounds)
     
     
     //// Color Declarations
     let color = color
     
     //// Oval Drawing
     let ovalPath = UIBezierPath(ovalInRect: CGRectMake(0 * xScalingFactor, 0 * yScalingFactor, 40 * xScalingFactor, 40 * yScalingFactor))
     color.setStroke()
     ovalPath.lineWidth = 1 * lineWidthScalingFactor
     ovalPath.stroke()
     
     
     //// Bezier Drawing
     let bezierPath = UIBezierPath()
     bezierPath.moveToPoint(CGPointMake(20 * xScalingFactor, -0 * yScalingFactor))
     bezierPath.addLineToPoint(CGPointMake(20 * xScalingFactor, 40 * yScalingFactor))
     bezierPath.addLineToPoint(CGPointMake(20 * xScalingFactor, -0 * yScalingFactor))
     bezierPath.closePath()
     color.setStroke()
     bezierPath.lineWidth = 1 * lineWidthScalingFactor
     bezierPath.stroke()
     
     
     //// Bezier 2 Drawing
     let bezier2Path = UIBezierPath()
     bezier2Path.moveToPoint(CGPointMake(0.5 * xScalingFactor, 19.5 * yScalingFactor))
     bezier2Path.addLineToPoint(CGPointMake(39.5 * xScalingFactor, 19.5 * yScalingFactor))
     bezier2Path.addLineToPoint(CGPointMake(0.5 * xScalingFactor, 19.5 * yScalingFactor))
     bezier2Path.closePath()
     color.setStroke()
     bezier2Path.lineWidth = 1 * lineWidthScalingFactor
     bezier2Path.stroke()
     
     
     //// Bezier 3 Drawing
     let bezier3Path = UIBezierPath()
     bezier3Path.moveToPoint(CGPointMake(21.63 * xScalingFactor, 0.42 * yScalingFactor))
     bezier3Path.addCurveToPoint(CGPointMake(21.63 * xScalingFactor, 39.6 * yScalingFactor), controlPoint1: CGPointMake(21.63 * xScalingFactor, 0.42 * yScalingFactor), controlPoint2: CGPointMake(41 * xScalingFactor, 19 * yScalingFactor))
     bezier3Path.lineCapStyle = .round
     
     color.setStroke()
     bezier3Path.lineWidth = 1 * lineWidthScalingFactor
     bezier3Path.stroke()
     
     
     //// Bezier 4 Drawing
     let bezier4Path = UIBezierPath()
     bezier4Path.moveToPoint(CGPointMake(17.76 * xScalingFactor, 0.74 * yScalingFactor))
     bezier4Path.addCurveToPoint(CGPointMake(18.72 * xScalingFactor, 39.6 * yScalingFactor), controlPoint1: CGPointMake(17.76 * xScalingFactor, 0.74 * yScalingFactor), controlPoint2: CGPointMake(-2.5 * xScalingFactor, 19.04 * yScalingFactor))
     bezier4Path.lineCapStyle = .round
     
     color.setStroke()
     bezier4Path.lineWidth = 1 * lineWidthScalingFactor
     bezier4Path.stroke()
     
     
     //// Bezier 5 Drawing
     let bezier5Path = UIBezierPath()
     bezier5Path.moveToPoint(CGPointMake(6 * xScalingFactor, 7 * yScalingFactor))
     bezier5Path.addCurveToPoint(CGPointMake(34 * xScalingFactor, 7 * yScalingFactor), controlPoint1: CGPointMake(6 * xScalingFactor, 7 * yScalingFactor), controlPoint2: CGPointMake(19 * xScalingFactor, 21 * yScalingFactor))
     bezier5Path.lineCapStyle = .round
     
     color.setStroke()
     bezier5Path.lineWidth = 1 * lineWidthScalingFactor
     bezier5Path.stroke()
     
     
     //// Bezier 6 Drawing
     let bezier6Path = UIBezierPath()
     bezier6Path.moveToPoint(CGPointMake(6 * xScalingFactor, 33 * yScalingFactor))
     bezier6Path.addCurveToPoint(CGPointMake(34 * xScalingFactor, 33 * yScalingFactor), controlPoint1: CGPointMake(6 * xScalingFactor, 33 * yScalingFactor), controlPoint2: CGPointMake(19 * xScalingFactor, 22 * yScalingFactor))
     bezier6Path.lineCapStyle = .round
     
     color.setStroke()
     bezier6Path.lineWidth = 1 * lineWidthScalingFactor
     bezier6Path.stroke()
 
    endCenter()
} // end of func
*/
