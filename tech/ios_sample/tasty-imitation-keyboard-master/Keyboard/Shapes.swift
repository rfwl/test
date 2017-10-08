//
//  Shapes.swift
//  TastyImitationKeyboard
//
//  Created by Alexei Baboulevitch on 10/5/14.
//  Copyright (c) 2014 Alexei Baboulevitch ("Archagon"). All rights reserved.
//

import UIKit

// TODO: these shapes were traced and as such are erratic and inaccurate; should redo as SVG or PDF

///////////////////
// SHAPE OBJECTS //
///////////////////

class BackspaceShape: Shape {
    override func drawCall(color: UIColor) {
        drawBackspace(self.bounds, color: color)
    }
}

class ShiftShape: Shape {
    var withLock: Bool = false {
        didSet {
            self.overflowCanvas.setNeedsDisplay()
        }
    }
    
    override func drawCall(color: UIColor) {
        drawShift(self.bounds, color: color, withRect: self.withLock)
    }
}

class GlobeShape: Shape {
    override func drawCall(color: UIColor) {
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
        self.init(frame: CGRectZero)
    }
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        
        self.opaque = false
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
        if oldBounds != nil && CGRectEqualToRect(self.bounds, oldBounds!) {
            return
        }
        oldBounds = self.bounds
        
        super.layoutSubviews()
        
        let overflowCanvasSizeRatio = CGFloat(1.25)
        let overflowCanvasSize = CGSizeMake(self.bounds.width * overflowCanvasSizeRatio, self.bounds.height * overflowCanvasSizeRatio)
        
        self.overflowCanvas.frame = CGRectMake(
            CGFloat((self.bounds.width - overflowCanvasSize.width) / 2.0),
            CGFloat((self.bounds.height - overflowCanvasSize.height) / 2.0),
            overflowCanvasSize.width,
            overflowCanvasSize.height)
        self.overflowCanvas.setNeedsDisplay()
    }
    
    func drawCall(color: UIColor) { /* override me! */ }
    
    class OverflowCanvas: UIView {
        unowned var shape: Shape
        
        init(shape: Shape) {
            self.shape = shape
            
            super.init(frame: CGRectZero)
            
            self.opaque = false
        }

        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func drawRect(rect: CGRect) {
            let ctx = UIGraphicsGetCurrentContext()
            CGColorSpaceCreateDeviceRGB()
            
            CGContextSaveGState(ctx)
            
            let xOffset = (self.bounds.width - self.shape.bounds.width) / CGFloat(2)
            let yOffset = (self.bounds.height - self.shape.bounds.height) / CGFloat(2)
            CGContextTranslateCTM(ctx, xOffset, yOffset)
            
            self.shape.drawCall(shape.color != nil ? shape.color! : UIColor.blackColor())
            
            CGContextRestoreGState(ctx)
        }
    }
}


