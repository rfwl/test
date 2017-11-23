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
            return secondaryCellArray != nil && secondaryCellArray!.count>1
        }
    }
    
    var hasPopUpCells:Bool {
        get {
            return popUpCellArray != nil && popUpCellArray!.count>1
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
    var frame:CGRect = CGRect.zero    
    var mainCellFrame:CGRect = CGRect.zero
    var secondaryCellFrame:CGRect = CGRect.zero
   
   	 private func calculateSecondaryCellFrame(){ 
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
        }
    }
    
    private func calculateMainCellFrame(){
    	let w = self.frame.width 
    	let sh = self.frame.height * self.secondaryCell_HeightScale
    	let h = self.frame.height - sh
        self.mainCellFrame = CGRect.zero
    	switch self.secodaryCellLocation {
    	case .TopLeft, .TopRight:
    		self.mainCellFrame = CGRect(x: 0, y: sh, width: w, height: h )
    	case .BottomLeft, .BottomRight:
    		self.mainCellFrame = CGRect(x: 0, y: 0, width: w, height: h)
        }
    }
    
    func setMainAndSecondaryFrames(){
        mainCellFrame = CGRect.zero
        secondaryCellFrame = CGRect.zero
        if self.hasSecondaryCells {
            calculateMainCellFrame()
            calculateSecondaryCellFrame()
        } else {
            mainCellFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            secondaryCellFrame = CGRect.zero
        }
    } //end of func
    //======================================================
    //
    var keyView:KeyView? = nil
    //======================================================
    
} // end of class

