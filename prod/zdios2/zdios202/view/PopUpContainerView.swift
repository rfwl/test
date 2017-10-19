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
    
    static var popUpUnitWidth = CGFloat(30.0)
    static var popUpCellGap = CGFloat(3.0)
    
    static var heightAboveKeyboardView:CGFloat {
        get {
            return popUpHeight + popUpGap + popUpBorderWidth
        }
    }
 
    static var minDelta:CGFloat {
        get {
            return popUpCornerRadius + popUpGap + popUpBorderWidth
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
            //ctx?.translateBy(x: 0, y: PopUpSettings.heightAboveKeyboardView)
            isPopUpForMainCell ? drawInPopUp_MainCell(kv) : drawInPopUp_SecondaryCells(kv)
            ctx?.restoreGState()
        }
        
    } //end of func
    
    //=====================================================================
    // Pop-up
    
    var popUpKeyView : KeyView?
    var isPopUpForMainCell : Bool = false
    
    func hidePopUp(){
        popUpKeyView = nil
        self.setNeedsDisplay()
    }
    
     func buildPopUpRectForKeyView(_ keyView:KeyView) {
        let maxX = self.frame.width - PopUpSettings.popUpBorderWidth/2
        let maxWidth = self.frame.width - 2 * PopUpSettings.popUpBorderWidth
        let minWidth = keyView.frame.width
        //--------------------------------------------------------------
        var neededWidth = CGFloat(0) + PopUpSettings.popUpCellGap
        if isPopUpForMainCell {
			neededWidth = keyView.frame.width + 2 * PopUpSettings.minDelta
		} else {
			if let ky = keyView.keyDefinition, let cells = ky.getSecondaryCells() {
				//let cntCells = ky.keyCellArray.count - 1
				//neededWidth = CGFloat(cntCells) * (PopUpSettings.popUpUnitWidth + PopUpSettings.popUpCellGap) - PopUpSettings.popUpCellGap
				
				for cell:KeyCell in cells {
					neededWidth += cell.widthInPopUpUnit * PopUpSettings.popUpUnitWidth + PopUpSettings.popUpCellGap
				}
				if neededWidth < 0 {
					neededWidth = 0
				}  
			}	 
		}
		if neededWidth > maxWidth { // Limit the needed width so some cells will not be added into pop up rect for avoiding going beyond.
			neededWidth = maxWidth		
		} else if neededWidth < minWidth {
			neededWidth = minWidth
		}
		
		// calculate delta
        var delta = (neededWidth - keyView.frame.width)/2
        if delta < PopUpSettings.minDelta { delta = 0 }
        
        // calculate x = minX of the target popup rect
        var x = PopUpSettings.popUpBorderWidth/2
        keyView.isLeftMostInPopUp = false
        keyView.isRightMostInPopUp = false
        
        if keyView.frame.minX < PopUpSettings.minDelta { // Possible first key
            keyView.isLeftMostInPopUp = true
            x = keyView.frame.minX
        } else if keyView.frame.maxX > maxX - PopUpSettings.minDelta {
            keyView.isRightMostInPopUp = true
            x = keyView.frame.maxX - neededWidth           
        } else {
            x = keyView.frame.minX - delta
            if x<PopUpSettings.popUpBorderWidth/2 { // beyond left side view border
                x = PopUpSettings.popUpBorderWidth/2
            } else if x+neededWidth+PopUpSettings.popUpBorderWidth/2  > maxX { // beyond right view border
                x -= x+neededWidth+PopUpSettings.popUpBorderWidth/2 - maxX
            }
        }
        // Calculate y
        let y = keyView.frame.minY - PopUpSettings.popUpGap - PopUpSettings.popUpHeight + PopUpSettings.heightAboveKeyboardView
        // KeyView's Pop-Up Rect's Coordinates in PopUpContainerView.
        let popUpFrame:CGRect = CGRect(x:x,y:y,width:neededWidth,height: PopUpSettings.popUpHeight)
        if isPopUpForMainCell {
        	keyView.popUpFrame_MainCell = popUpFrame
        } else {
        	keyView.popUpFrame_SecondaryCells = popUpFrame
        }
        
        
    } //end of func
    
    
    func drawPopUpBorderPath(_ keyView:KeyView) {
        //-------------------------------------------------
        let strokeColor:UIColor = PopUpSettings.popUpBorderColor
        strokeColor.set()
        var frm = keyView.popUpFrame_MainCell
        if !isPopUpForMainCell {
            frm = keyView.popUpFrame_SecondaryCells
        }
        let x1 = frm.minX
        let x2 = keyView.frame.minX
        let x3 = keyView.frame.maxX
        let x4 = frm.maxX
        
        let y1 = frm.minY
        let y2 = frm.maxY
        let y3 = keyView.frame.minY + PopUpSettings.heightAboveKeyboardView //keyView.frame is relative to KeyView's Surface
        let y4 = keyView.frame.maxY + PopUpSettings.heightAboveKeyboardView
        
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
        path.stroke()
        
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
    
    //=====================================================================
    // Pop-up for Main Cell

    func showPopUp_MainCell(_ keyView:KeyView){
        if let _ = keyView.keyDefinition {
            popUpKeyView = keyView
            isPopUpForMainCell = true
            // Calculate width
            buildPopUpRectForKeyView(keyView)
            addToPopUp_MainCell(keyView)
            self.setNeedsDisplay()
        }
    }
    
   
    func addToPopUp_MainCell(_ keyView:KeyView) {
        
        // Draw pop up border path
        // Clear sub views
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
        // Add sub views from cell
        if let kc = keyView.keyDefinition?.getMainCell() {
            kc.addToView(self, frame: keyView.popUpFrame_MainCell)
        }
    }
    
    func drawInPopUp_MainCell(_ keyView:KeyView) {
        drawPopUpBorderPath(keyView)
        if let kc = keyView.keyDefinition?.getMainCell() {
            kc.drawInView(self, frame: keyView.popUpFrame_MainCell) // This is useless if KeyCellType = Shape is removed
        }
    }
    
    //=====================================================================
    // Pop-up for Secondary Cells
    var addedSecondaryCellViews:[UIView] = [UIView]()
        
    func showPopUp_SecondaryCells(_ keyView:KeyView, touchDownX : CGFloat){
        if let _ = keyView.keyDefinition {
            popUpKeyView = keyView
            isPopUpForMainCell = false
            buildPopUpRectForKeyView(keyView)
            addToPopUp_SecondaryCells(keyView,touchDownX:touchDownX)
            self.setNeedsDisplay()
        }
    }
    
    
    var leftMax:CGFloat = CGFloat(0)
 	var leftMin:CGFloat = CGFloat(0)
    var rightMax:CGFloat = CGFloat(0)
    var rightMin:CGFloat = CGFloat(0)
    var addedAtLeft : Bool = false        
    
    func addToPopUp_SecondaryCells(_ keyView:KeyView , touchDownX : CGFloat) {
        // Clear sub views
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
        addedSecondaryCellViews.removeAll()  
        
        if let ky = keyView.keyDefinition, let cells = ky.getSecondaryCells() {
            if cells.count < 1 { return }
            let cell1 = cells[cells.startIndex]
            let popUpRect = keyView.popUpFrame_SecondaryCells
            
            //-------------------------------------------------------------
            // This part decided where in pop up width to start adding cell views, that is where to put the first cell view. 
         	// The first cell will added as close as possible to downX  
         	let cell1NeededWidth =  CGFloat(cell1.widthInPopUpUnit) * PopUpSettings.popUpUnitWidth
         	self.leftMax = popUpRect.minX
         	self.leftMin = touchDownX + cell1NeededWidth/2
            if self.leftMin > popUpRect.maxX - PopUpSettings.popUpCellGap {
               self.leftMin = popUpRect.maxX - PopUpSettings.popUpCellGap
            }
            self.rightMin = touchDownX - cell1NeededWidth/2
            if self.rightMin < popUpRect.minX + PopUpSettings.popUpCellGap {
                self.rightMin = popUpRect.minX + PopUpSettings.popUpCellGap
            }
            
            self.rightMax = popUpRect.maxX
            print("\nAdd from \(self.leftMax) to \(self.rightMax ) start at \(touchDownX)")
            //-------------------------------------------------------------          
            for cell : KeyCell in cells {
            	let cellNeededWidth =  CGFloat(cell.widthInPopUpUnit) * PopUpSettings.popUpUnitWidth
                if let cellView = cell.buildView() {
                    
                    if addedAtLeft {
                        if tryAdd_Right(cellView,width:cellNeededWidth, y: popUpRect.minY, height: popUpRect.height) { continue }
                        let _ = tryAdd_Left(cellView,width:cellNeededWidth, y: popUpRect.minY, height: popUpRect.height)
                    } else {
                        if tryAdd_Left(cellView,width:cellNeededWidth, y: popUpRect.minY, height: popUpRect.height) { continue }
                        let _ = tryAdd_Right(cellView,width:cellNeededWidth, y: popUpRect.minY, height: popUpRect.height)
                    }
        
                }
            	// Here the current cell cannot be added in - no enough width - and so ignored.            	            		        	            
            } //end of for
            
            //-------------------------------------------------------------
        } // end of if let _ = keyView.keyDefinition             
    }
    
    func tryAdd_Left(_ cellView:UIView, width:CGFloat, y: CGFloat, height: CGFloat)->Bool {
    	let leftRemainingWidth = self.leftMin - self.leftMax
    	if leftRemainingWidth>width{
            print("Add at Left at \(self.leftMin - width) to \(self.leftMin)")
    		let rt = CGRect(x:self.leftMin - width, y:y, width:width, height: height)
    		cellView.frame = rt
    		self.addSubview(cellView)
    		addedSecondaryCellViews.append(cellView)
            if self.leftMin>self.rightMin { self.rightMin = self.leftMin }
    		self.leftMin -= width + PopUpSettings.popUpCellGap
            
    		addedAtLeft = true           		
    		return true
    	} else {
    		return false
    	} 
    }  
    
    func tryAdd_Right(_ cellView:UIView, width:CGFloat, y:CGFloat, height: CGFloat)->Bool {
    	
    	let rightRemainingWidth = self.rightMax - self.rightMin
    	if rightRemainingWidth>width {
            print("Add at Right at \(self.rightMin) to \(self.rightMin + width)")
    		let rt = CGRect(x:self.rightMin, y:y, width:width, height: height)
    		cellView.frame = rt
    		self.addSubview(cellView)
    		addedSecondaryCellViews.append(cellView)
    		if self.leftMin>self.rightMin { self.leftMin = self.rightMin }
    		self.rightMin += width + PopUpSettings.popUpCellGap
    		
    		addedAtLeft = false   
    		return true
    	} else {
    		return false
    	} 
    
    }
 
    
    
   
    func drawInPopUp_SecondaryCells(_ keyView:KeyView) {
        drawPopUpBorderPath(keyView)
        
    }
    
    //=====================================================================
    //
     
    //=====================================================================
    //
   
    
} //end of class

extension CGPoint {
    func shift(x:CGFloat, y:CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y:self.y + y)
    }
}

/*

  func buildPopUpRectForKeyView_SecondaryCells(_ keyView:KeyView, width:CGFloat) {
        //-------------------------------------------------
        // calculate maxW
        let minDelta =  PopUpSettings.popUpCornerRadius + PopUpSettings.popUpGap
        var maxW = self.frame.width
        if self.frame.minX < minDelta {maxW -= self.frame.minX}
        if self.frame.width - keyView.frame.maxX < minDelta {maxW -= self.frame.width - keyView.frame.maxX}
        let minW = keyView.frame.width
        // calculate target width
        var targetW = width
        if targetW > maxW {
            targetW = maxW
        }
        if targetW < minW {
            targetW = minW
        }
        // calculate delta
        var delta = (targetW - keyView.frame.width)/2
        if delta < minDelta { delta = 0 }
        // calculate x = minX of the target popup rect
        var x = PopUpSettings.popUpBorderWidth/2
        if keyView.frame.minX < minDelta { // Possible first key
            x = keyView.frame.minX
        } else if keyView.frame.maxX > maxW - minDelta {
            x = keyView.frame.maxX - targetW
        } else {
            x = keyView.frame.minX - delta
            if x<PopUpSettings.popUpBorderWidth/2 { // beyond left side view border
                x = PopUpSettings.popUpBorderWidth/2
            } else if x+targetW+PopUpSettings.popUpBorderWidth/2  > maxW { // beyond right view border
                x -= x+targetW+PopUpSettings.popUpBorderWidth/2 - maxW
            }
        }
        // Calculate y
        let y = keyView.frame.minY - PopUpSettings.popUpGap - PopUpSettings.popUpHeight
        // KeyView's Pop-Up Rect's Coordinates in PopUpContainerView.
        let popUpFrame:CGRect = CGRect(x:x,y:y,width:targetW,height: PopUpSettings.popUpHeight)
        keyView.popUpFrame = popUpFrame
    }

*/
