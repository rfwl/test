import Foundation
import UIKit

class KeyboardKey {
 
    var frame:CGRect = CGRect.zero
    var widthInCells:Int
    
   	//================================================
   	// Cell Configurations 
 	var keyCellArray:[KeyCell]
 	
    var hasSecondaryCell:Bool {
        get {
            return keyCellArray.count>1
        }
    }
 	var secondaryCell_HeightScale = CGFloat(0.4);
    var secondaryCell_WidthScale = CGFloat(0.6);
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
    
     func getSecondaryCells() -> ArraySlice<KeyCell>? {
     	if keyCellArray.count>0 {
     		return keyCellArray.dropFirst()
     	} else {
     		return nil
     	}
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
        cell2.fontSize = KeyCell.Secondary_Cell_Font_Size
		self.keyCellArray = [cell1,cell2]
        widthInCells = 1
    }
    
    //================================================
   	// Transient Properties
    var view:KeyView?
    
    //================================================
   	// Cells 
    var mainCellFrame:CGRect = CGRect.zero
    var secondaryCellFrame:CGRect = CGRect.zero
   	func setMainAndSecondaryFrames(){
        mainCellFrame = CGRect.zero
        secondaryCellFrame = CGRect.zero
   		switch self.cellConfiguration {
   		case .SingleCell,.SingleCellPlusPopUpCells:
   			mainCellFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
   			secondaryCellFrame = CGRect.zero
   		case .SecondaryCell, .SecondarCellPlusPopUpCells:
   			calculateMainCellFrame()
  			calculateSecondaryCellFrame()
   		//default:
   			//mainCellFrame = CGRect.zero
    		//secondaryCellFrame = CGRect.zero
   		}
    } //end of func
   	
   	 func calculateSecondaryCellFrame(){
    	let w = self.frame.width * self.secondaryCell_WidthScale
    	let h = self.frame.height * self.secondaryCell_HeightScale
        self.secondaryCellFrame = CGRect.zero
    	switch self.secodaryCellLocation {
    	case .TopLeft:
    		self.secondaryCellFrame = CGRect(x: 0, y: 0, width: w, height: h)
    	case .TopRight:
    		self.secondaryCellFrame = CGRect(x: self.frame.width-w, y: 0, width: w, height: h)
    	case .BottomLeft:
    		self.secondaryCellFrame = CGRect(x: 0, y: self.frame.height-h, width: w, height: h)
        case .BottomRight:
    		self.secondaryCellFrame = CGRect(x: self.frame.width-w, y: self.frame.height-h, width: w, height: h)
        //default:
        	//self.secondaryCellFrame = CGRect.zero
        }
    }
    
    func calculateMainCellFrame(){
    	let w = self.frame.width 
    	let sh = self.frame.height * self.secondaryCell_HeightScale
    	let h = self.frame.height - sh
        self.mainCellFrame = CGRect.zero
    	switch self.secodaryCellLocation {
    	case .TopLeft, .TopRight:
    		self.mainCellFrame = CGRect(x: 0, y: sh, width: w, height: h )
    	case .BottomLeft, .BottomRight:
    		self.mainCellFrame = CGRect(x: 0, y: 0, width: w, height: h)
        //default:
        	//self.mainCellFrame = CGRect.zero
        }
    }
    
    
    //================================================
   	//
} // end of class
 



 
