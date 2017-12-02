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
    var frame:CGRect = CGRect.zero
    var pageFrame:CGRect = CGRect.zero
    
    var mainCellFrame:CGRect = CGRect.zero
    var secondaryCellFrame:CGRect = CGRect.zero
    
    var mainCellPopUpFrame:CGRect = CGRect.zero
    var popUpCellFrame:CGRect = CGRect.zero
    
    // Must be called after self.frame is set.
    func calculateCellFrames(){
        mainCellFrame = calculateMainCellFrame()
        secondaryCellFrame = calculateSecondaryCellFrame()
        mainCellPopUpFrame = calculateMainCellPopUpFrame()
        popUpCellFrame = calculatePopUpCellFrame()

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
    // view components
    // There are four types of cell views: main cell view on surface, secondary cell view on surface, main cell view in main cell PopUp, and popUp cell views in PopUp
    
    var keyView:KeyView? = nil
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

