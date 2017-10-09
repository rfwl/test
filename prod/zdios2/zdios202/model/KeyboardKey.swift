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
    	let w = self.frame.width * self.secondaryCellSizeScale
    	let h = self.frame.height * self.secondaryCellSizeScale
        self.secondaryCellFrame = CGRect.zero
    	switch self.secodaryCellLocation {
    	case .TopLeft:
    		self.secondaryCellFrame = CGRect(x: 0, y: 0, width: w, height: h)
    	case .TopRight:
    		self.secondaryCellFrame = CGRect(x: self.frame.width-w, y: 0, width: w, height: h)
    	case .BottomLeft:
    		self.secondaryCellFrame = CGRect(x: 0, y: self.frame.height-h, width: w, height: h)
        case .BottomRight:
    		self.secondaryCellFrame = CGRect(x: self.frame.width, y: self.frame.height-h, width: w, height: h)
        //default:
        	//self.secondaryCellFrame = CGRect.zero
        }
    }
    
    func calculateMainCellFrame(){
    	let w = self.frame.width 
    	let sh = self.frame.height * self.secondaryCellSizeScale
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
   	// Pop-up
   	
   	func drawPopUpPath(_ popUpFrame:CGRect) {
                
        let x1 = popUpFrame.minX
        let x2 = self.frame.minX
        let x3 = self.frame.minX + self.frame.width
        let x4 = popUpFrame.minX + popUpFrame.width
        
        let y1 = popUpFrame.minY
        let y2 = popUpFrame.minY + popUpFrame.height
        let y3 = self.frame.minY
        let y4 = self.frame.minY + self.frame.height
        
        let r1 = CGFloat(10.0) 
        let r2 = CGFloat(5.0) 
        let r3 = CGFloat(30.0)
        
        let p1 = CGPoint(x:x1, y:y1), p2 = CGPoint(x:x4, y:y1), p3 = CGPoint(x:x1, y:y2), p4 = CGPoint(x:x4, y:y2)
        let p1c = p1.shift(x:r1, y:r1), p2c = p2.shift(x:-r1, y:r1), p3c = p3.shift(x:r1, y:-r1), p4c = p4.shift(x:-r1, y:-r1)
        let p1a = p1.shift(x:r1, y:0), p2a = p2.shift(x:0, y:r1), p3a = p3.shift(x:0, y:-r1)  //, p4a = p4.shift(x:-r1, y:0)
        
        let left  = CGFloat(Double.pi)
        let up    = CGFloat(1.5*Double.pi)
        let down  = CGFloat(0.5 * Double.pi)
        let right = CGFloat(0.0)
        let color1:UIColor = UIColor.green
        color1.set()
        
        let path4:UIBezierPath = UIBezierPath()
        path4.move(to: p1a)
        path4.addArc(withCenter: p1c, radius: r1, startAngle: up, endAngle: left, clockwise: false)
        
        path4.addLine(to:p3a)
        path4.addArc(withCenter: p3c, radius: r1, startAngle: left, endAngle: down, clockwise: false)
        
        //path4.addLine(to:p4a)
        path4.addArc(withCenter: p4c, radius: r1, startAngle: down, endAngle: right, clockwise: false)
        
        path4.addLine(to:p2a)
        path4.addArc(withCenter: p2c, radius: r1, startAngle: right, endAngle: up, clockwise: false)
        
        path4.addLine(to:p1a)
        //path4.close()
        path4.lineWidth = 3
        path4.stroke()
        
        let q1 = CGPoint(x:x2, y:y3), q2 = CGPoint(x:x3, y:y3), q3 = CGPoint(x:x2, y:y4), q4 = CGPoint(x:x3, y:y4)
        let q1c = q1.shift(x:r2, y:r2), q2c = q2.shift(x:-r2, y:r2), q3c = q3.shift(x:r2, y:-r2), q4c = q4.shift(x:-r2, y:-r2)
        let q1a = q1.shift(x:r2, y:0), q2a = q2.shift(x:0, y:r2), q3a = q3.shift(x:0, y:-r2), q4a = q4.shift(x:-r2, y:0)
                
        let path5:UIBezierPath = UIBezierPath()
        path5.move(to: q1a)
        path5.addArc(withCenter: q1c, radius: r2, startAngle: up, endAngle: left, clockwise: false)
        
        path5.addLine(to:q3a)
        path5.addArc(withCenter: q3c, radius: r2, startAngle: left, endAngle: down, clockwise: false)
        
        path5.addLine(to:q4a)
        path5.addArc(withCenter: q4c, radius: r2, startAngle: down, endAngle: right, clockwise: false)
        
        path5.addLine(to:q2a)
        path5.addArc(withCenter: q2c, radius: r2, startAngle: right, endAngle: up, clockwise: false)
        
        //path5.addLine(to:q1a)
        //path5.close()
        path5.lineWidth = 3
        path5.stroke()
        
        let s1 = CGPoint(x:x2, y:y2), s2 = CGPoint(x:x3, y:y2)
        let s1c = s1.shift(x:-r3,y:r3), s2c = s2.shift(x:r3,y:r3)
        let s1a = s1.shift(x:-r3,y:0), s2a = s2.shift(x:0,y:r3)
        
        let path6:UIBezierPath = UIBezierPath()
        path6.move(to: s1a)
        path6.addArc(withCenter: s1c, radius: r3, startAngle: up, endAngle: right, clockwise: true)
        
        path6.move(to: s2a)
        path6.addArc(withCenter: s2c, radius: r3, startAngle: left, endAngle: up, clockwise: true)
        //path6.close()
        path6.lineWidth = 3
        path6.stroke()
    } //end of func
    
        
        
   	
   	
   	    
    //================================================
   	//
} // end of class
 

extension CGPoint {
    func shift(x:CGFloat, y:CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y:self.y + y)
    }
}

 
