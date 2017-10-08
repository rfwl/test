//
//  CenterCALayer.swift
//  Popover1
//
//  Created by Richard Feng on 4/12/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class CenterCATextLayer : CATextLayer {
    
    // REF: http://lists.apple.com/archives/quartz-dev/2008/Aug/msg00016.html
    // CREDIT: David Hoerl - https://github.com/dhoerl
    // USAGE: To fix the vertical alignment issue that currently exists within the CATextLayer class. Change made to the yDiff calculation.
    
    override init() {
        super.init()
    }
    
    //override init!(layer: AnyObject!) {
    //    super.init(layer: layer)
    //}
    
    required init(coder aDecoder: NSCoder) {
        super.init(layer: aDecoder)
    }
    
    override func draw(in ctx: CGContext) {
        let height = self.bounds.size.height
        let fontSize = self.fontSize
        let yDiff = (height-fontSize)/2 - fontSize/10
        
        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: yDiff)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
    
} //end of class
