import Foundation
import UIKit

class KeyboardKey : Codable {
 
    //================================================
   	// Properties
   	var name:String
    var text:String?    
   	var mainCellArray:[KeyCell]
   	
 	var secondaryCellArray:[KeyCell]? = nil
 	var popUpCellArray:[KeyCell]? = nil    
    var widthInRowUnit:Int = 1
    
  	enum CodingKeys: String, CodingKey {
        case name 
        case text
        case mainCellArray
        case secondaryCellArray
        case popUpCellArray
        case widthInRowUnit
     
    }
    //================================================
   	// Inits
   	init(_ char:String) {
		self.name = ""
		self.text = ""
		let cell = KeyCell(char)        
		self.mainCellArray = [cell]        
    }
    
    init(_ name:String, text:String, width: Int=1) {
		self.name = ""
		self.text = ""
		let cell = KeyCell(name: name, text: text)        
		self.mainCellArray = [cell]
        self.widthInRowUnit = width
    }    
  
	init(_ name:String, image:String, width: Int=1) {
		self.name = ""
		self.text = ""
		let cell = KeyCell(name: name, image: image)        
		self.mainCellArray = [cell]
        self.widthInRowUnit = width
    }
       	
   	init(_ char1:String, char2:String) {
		self.name = ""
		self.text = ""
		let cell1 = KeyCell(char1)       
		let cell2 = KeyCell(char2)
        cell2.fontSize = Settings.Secondary_Cell_Font_Size
		self.mainCellArray = [cell1]
		self.secondaryCellArray = [cell2]        
    }
    
    //================================================
   	// 	
    var hasSecondaryCells:Bool {
        get {
            return secondaryCellArray != nil && secondaryCellArray!.count>0
        }
    }
    
    var hasPopUpCells:Bool {
        get {
            return popUpCellArray != nil && popUpCellArray!.count>0
        }
    }
    
    //================================================
    //
    var frame:CGRect = CGRect.zero
    var pageFrame:CGRect = CGRect.zero
    var keyView:KeyView? = nil
    //================================================
   	// Secondary Cell Location
 	var secondaryCell_HeightScale = CGFloat(0.4);
    var secondaryCell_WidthScale = CGFloat(0.6); 	
 	var secodaryCellLocation:EnumSecondaryCellLocation = EnumSecondaryCellLocation.BottomRight
 	    
    enum EnumSecondaryCellLocation : String {
    	case TopLeft
    	case TopRight
    	case BottomLeft
        case BottomRight    
    } 
    
    //================================================
   	// Cell Frames
    // There are four frames required for a key: mainCellFrame_KeySurface secondaryCellFrame_KeySurface, mainCellPopUpFrame_PopUp, and popUpCellFrame_PopUp.
    //
    var mainCellFrame:CGRect = CGRect.zero
    var secondaryCellFrame:CGRect = CGRect.zero
    
    var mainCell_PopUpFrame:CGRect = CGRect.zero
    var popUpCells_PopUpFrame:CGRect = CGRect.zero
    
    // Must be called after self.frame is set.
    func calculateCellFrames(){
        mainCellFrame = calculateMainCellFrame()
        secondaryCellFrame = calculateSecondaryCellFrame()
        mainCell_PopUpFrame = calculateMainCellPopUpFrame()
        popUpCells_PopUpFrame = calculatePopUpCellFrame()

    } //end of func
    
    private func calculateMainCellFrame() -> CGRect {
        var rect = CGRect.zero
        if self.hasSecondaryCells {
            let w = self.frame.width
            let sh = self.frame.height * self.secondaryCell_HeightScale
            let h = self.frame.height - sh
            switch self.secodaryCellLocation {
            case .TopLeft, .TopRight:
                rect = CGRect(x: 0, y: sh, width: w, height: h )
            case .BottomLeft, .BottomRight:
                rect = CGRect(x: 0, y: 0, width: w, height: h)
            }
        } else {
            rect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }
        return rect
    }
    
    private func calculateSecondaryCellFrame() -> CGRect {
    	let w = self.frame.width * self.secondaryCell_WidthScale
    	let h = self.frame.height * self.secondaryCell_HeightScale
        var rect = CGRect.zero
        if self.hasSecondaryCells {
            switch self.secodaryCellLocation {
            case .TopLeft:
                rect = CGRect(x: 0, y: 0, width: w, height: h)
            case .TopRight:
                rect = CGRect(x: self.frame.width-w, y: 0, width: w, height: h)
            case .BottomLeft:
                rect = CGRect(x: 0, y: self.frame.height-h, width: w, height: h)
            case .BottomRight:
                rect = CGRect(x: self.frame.width-w, y: self.frame.height-h, width: w, height: h)
            }
        }
        return rect
    }
    
    private func calculateMainCellPopUpFrame() -> CGRect {
        var rect = CGRect.zero
        var askedWidth = CGFloat(0)
        askedWidth = self.frame.width + 2 * PopUpSettings.minDelta
        rect = calculatePopUpRectForAskedWidth(askedWidth)
        return rect
    }
    
    private func calculatePopUpCellFrame() -> CGRect {
        var rect = CGRect.zero
        var askedWidth = CGFloat(0)
        if self.hasPopUpCells {
            for cell:KeyCell in self.popUpCellArray! {
                askedWidth += cell.widthInPopUpUnit * PopUpSettings.popUpUnitWidth + PopUpSettings.popUpCellGap
            }
            rect = calculatePopUpRectForAskedWidth(askedWidth)
        }
        return rect
    }
    
    private func calculatePopUpRectForAskedWidth(_ askedWidth:CGFloat) -> CGRect {
        let maxX = pageFrame.width - PopUpSettings.popUpBorderWidth/2
        let maxWidth = pageFrame.width - 2 * PopUpSettings.popUpBorderWidth
        let minWidth = self.frame.width
        
        // Calculate available width
        var availableWidth = askedWidth
        if availableWidth < 0 {
            availableWidth = 0
        }
        if availableWidth > maxWidth { // Limit the needed width so some cells will not be added into pop up rect for avoiding going beyond.
            availableWidth = maxWidth
        } else if availableWidth < minWidth {
            availableWidth = minWidth
        }
        // calculate delta - shift from the horizontal center of the key, like center-offset.
        var delta = (availableWidth - self.frame.width)/2
        if delta < PopUpSettings.minDelta { delta = 0 }
        
        // calculate x = minX of the target popup rect
        var x = PopUpSettings.popUpBorderWidth/2
        
        if self.frame.minX < PopUpSettings.minDelta { // Possible first key
            x = self.frame.minX
        } else if self.frame.maxX > maxX - PopUpSettings.minDelta {
            x = self.frame.maxX - availableWidth
        } else {
            x = self.frame.minX - delta
            if x<PopUpSettings.popUpBorderWidth/2 { // beyond left side view border
                x = PopUpSettings.popUpBorderWidth/2
            } else if x+availableWidth+PopUpSettings.popUpBorderWidth/2  > maxX { // beyond right view border
                x -= x+availableWidth+PopUpSettings.popUpBorderWidth/2 - maxX
            }
        }
        // Calculate y
        let y = self.frame.minY - PopUpSettings.popUpGap - PopUpSettings.popUpHeight + PopUpSettings.heightAboveKeyboardView
        // KeyView's Pop-Up Rect's Coordinates in PopUpContainerView.
        let popUpFrame:CGRect = CGRect(x:x,y:y,width:availableWidth,height: PopUpSettings.popUpHeight)
        
        return popUpFrame
        
    } //end of func
    //======================================================
    // PopUp Border Path : There are two border path: main cell and popup cells.
    var mainCell_PopUpBorderPath_Upper:UIBezierPath? = nil
    var mainCell_PopUpBorderPath_Lower:UIBezierPath? = nil
    var popUpCells_PopUpBorderPath_Upper:UIBezierPath? = nil
    var popUpCells_PopUpBorderPath_Lower:UIBezierPath? = nil
    
    func buildPopUpBorderPaths() {
        var frm = self.mainCell_PopUpFrame
        let pathPair = buildPopUpBorderPathPair(frm)
        mainCell_PopUpBorderPath_Upper = pathPair.upper
        mainCell_PopUpBorderPath_Lower = pathPair.lower
        if self.hasPopUpCells {
            frm = self.popUpCells_PopUpFrame
            let pathPair1 = buildPopUpBorderPathPair(frm)
            popUpCells_PopUpBorderPath_Upper = pathPair1.upper
            popUpCells_PopUpBorderPath_Lower = pathPair1.lower
        }
    }
    
    
    func buildPopUpBorderPathPair(_ frm :CGRect) -> (upper:UIBezierPath, lower:UIBezierPath){
        //-------------------------------------------------
        // useful points and values
        let x1 = frm.minX
        let x2 = self.frame.minX
        let x3 = self.frame.maxX
        let x4 = frm.maxX
        
        let y1 = frm.minY
        let y2 = frm.maxY
        //keyView.frame is relative to KeyView's Surface
        let y3 = self.frame.minY + PopUpSettings.heightAboveKeyboardView
        let y4 = self.frame.maxY + PopUpSettings.heightAboveKeyboardView
        
        let r1 = PopUpSettings.popUpCornerRadius
        let r2 = PopUpSettings.popUpGap
        let r3 = PopUpSettings.popUpCornerRadius
        
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
        //-------------------------------------------------
        let path1:UIBezierPath = UIBezierPath()
        path1.lineWidth = PopUpSettings.popUpBorderWidth
        path1.move(to:q1)
        
        path1.addLine(to:q3a)
        path1.addArc(withCenter: q3c, radius: r3, startAngle: ArcAngles.left, endAngle: ArcAngles.down, clockwise: false)
        
        path1.addLine(to:q4a)
        path1.addArc(withCenter: q4c, radius: r3, startAngle: ArcAngles.down, endAngle: ArcAngles.right, clockwise: false)
        path1.addLine(to:q2)
        //-------------------------------------------------
        return (upper: path, lower: path1)
        
    } //end of func
    
    //======================================================
    // view components
    // There are four types of cell views: main cell view on surface, secondary cell view on surface, main cell view in main cell PopUp, and popUp cell views in PopUp
    // Main cell surface view and secodary cell view will be sub view of the KeyView.
    
  
    
    // Must be called after calculateCellFrames
    func buildCellViews(){
        for cl in self.mainCellArray{
            cl.buildCellViews()
            cl.cellView.frame = self.mainCellFrame
        }
        if self.hasSecondaryCells {
            for cl in self.secondaryCellArray!{
                cl.buildCellViews()
                cl.cellView.frame = self.secondaryCellFrame
            }
        }
        if self.hasPopUpCells {
            for cl in self.popUpCellArray!{
                cl.buildCellViews()
                //cl.cellView.frame = self.secondaryCellFrame
            }
        }
    } //end of func
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //======================================================
    
} // end of class

