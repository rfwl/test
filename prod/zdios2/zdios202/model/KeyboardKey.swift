import Foundation
import UIKit

class KeyboardKey {
 
    var frame:CGRect = CGRect.zero
    var widthInCells:Int
   	//================================================
   	// Cell Configurations 
 	var keyCellArray:[KeyCell]
 	
 	var hasSecondaryCell:Bool = false;
 	var secondaryCellSizeScale = CGFloat(0.25);
 	var cellConfiguration:EnumCellConfiguration = EnumCellConfiguration.SingleCell
 	var secodaryCellLocation:EnumSecondaryCellLocation = EnumSecondaryCellLocation.BottomRight
 	
    enum EnumCellConfiguration {
    	case SingleCell
    	case SingleCellPlusPopUpCells
    	case SecondaryCell
        case SecondarCellPlusPopUpCells
    
    }
    
    enum EnumSecondaryCellLocation {
    	case TopLeft
    	case TopRight
    	case BottomLeft
        case BottomRight    
    } 
    
    func getMainCell() -> KeyCell {
        return keyCellArray[0]
    }
    
    
   
    //================================================
   	// Inits
   	init(_ char:String) {
		let cell = KeyCell(char)
		self.keyCellArray = [cell]
        widthInCells = 1
    }
    
    init(_ text:String, output:String, width: Int=1) {
		let cell = KeyCell(text: text, output: output)
		self.keyCellArray = [cell]
        self.widthInCells = width
    }    
     
    init(shape:String, output:String, width: Int=1) {
		let cell = KeyCell(shape: shape, output: output)
		self.keyCellArray = [cell]
        self.widthInCells = width
    }
	
	init(icon:String, output:String, width: Int=1) {
		let cell = KeyCell(icon: icon, output: output)
		self.keyCellArray = [cell]
        self.widthInCells = width
    }
   	
   	init(_ char1:String, char2:String) {
		let cell1 = KeyCell(char1)
		let cell2 = KeyCell(char2)
		self.keyCellArray = [cell1,cell2]
		self.hasSecondaryCell = true
        widthInCells = 1
    }
    
    //================================================
   	// Transient Properties
    var keyView:KeyView?
    
    //================================================
   	// Cells 
    var mainCellFrame:CGRect = CGRect.zero
    var secondaryCellFrame:CGRect = CGRect.zero
   	func setMainAndSecondaryFrames(){
   		switch self.cellConfiguration {
   		case .SingleCell:
   		case .SingleCellPlusPopUpCells:
   			mainCellFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
   			secondaryCellFrame = CGRect.zero
   		break
   		case .SecondaryCell:
   		case .SecondarCellPlusPopUpCells:
   			calculateMainCellFrame()
  			calculateSecondaryCellFrame()		
   		break
   		default:
   			mainCellFrame = CGRect.zero
    		secondaryCellFrame = CGRect.zero
   		break
   		}
    } //end of func
   	
   	 func calculateSecondaryCellFrame(){
    	let w = self.frame.width * self.secondaryCellSizeScale
    	let h = self.frame.height * self.secondaryCellSizeScale
    	switch self.secodaryCellLocation {
    	case TopLeft:
    		self.secondaryCellFrame = CGRect(x: 0, y: 0, width: w, height: h)
    		break
    	case TopRight:
    		self.secondaryCellFrame = CGRect(x: self.frame.width-w, y: 0, width: w, height: h)
    		break
    	case BottomLeft:
    		self.secondaryCellFrame = CGRect(x: 0, y: self.frame.height-h, width: w, height: h)
    		break
        case BottomRight:    
    		self.secondaryCellFrame = CGRect(x: self.frame.width, y: self.frame.height-h, width: w, height: h)
    		break
        default:
        	self.secondaryCellFrame = CGRect.zero
        break
        }
    }
    
    func calculateMainCellFrame(){
    	let w = self.frame.width 
    	let sh = self.frame.height * self.mainCellSizeScale
    	let h = self.frame.height - sh 
    	switch self.secodaryCellLocation {
    	case TopLeft:
    	case TopRight:
    		self.mainCellFrame = CGRect(x: 0, y: sh, width: w, height: h )
 			break
    	case BottomLeft:
        case BottomRight:    
    		self.mainCellFrame = CGRect(x: 0, y: 0, width: w, height: h)
    		break
        default:
        	self.mainCellFrame = CGRect.zero
        break
        }
    }
   	//================================================
   	// Pop-up
   	
   	
   	
   	    
    //================================================
   	//
} // end of class
 
 
 
