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
    
   	var view:UIView?
    
    //================================================
   	//
} // end of class
 
 
 
