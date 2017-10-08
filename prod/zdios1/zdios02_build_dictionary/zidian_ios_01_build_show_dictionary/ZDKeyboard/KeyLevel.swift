
class KeyLevel {	 	
	
	init(){}
    
    var text:String=""
    var content:String=""
    var level:Int = 0   
	var parentLevel:KeyLevel?     
	var mFavorChildren:[KeyLevel]? 				   
	var mChildren:[KeyLevel]? 			      
	//===================================================
	// Location on Canvas and Pick Child from location
	lazy var x : CGFloat = 0.0
    lazy var y : CGFloat = 0.0
    lazy var width : CGFloat = 0.0
    lazy var height : CGFloat = 0.0
	func pickChildKeyLevel(x:CGFloat,y:CGFloat) -> KeyLevel? {
        if let children = mChildren {
        	if children.count < 1 {return nil}
			for i in 0..<children.count{
				var lvl:KeyLevel = children[i]
				if x>=lvl.x && x<=lvl.x+lvl.width && y>=lvl.y && y<=lvl.y+lvl.height {
					return lvl
				}
			}
		}		
		return nil
	}
	func pickFavorChildKeyLevel(x:CGFloat,y:CGFloat) -> KeyLevel? {
        if let children = mFavorChildren {
        	if children.count < 1 {return nil}
			for i in 0..<children.count{
				var lvl:KeyLevel = children[i]
				if x>=lvl.x && x<=lvl.x+lvl.width && y>=lvl.y && y<=lvl.y+lvl.height {
					return lvl
				}
			}
		}		
		return nil
	}
    //===================================================
	// Helper methods
	func toStringLines() -> String {
		var sb:String = ""
		let preTabs = String(repeating:"  ", count:level)
		sb = preTabs + text + "\n"
		if let children = mChildren {
			for lvl in children {						
				sb += lvl.toStringLines()   
			}
		}	
		return sb; 
	}	
	func getLongStringOfChildTexts() -> String {
		var sb:String = ""
		if let children = mChildren {
			for lvl in children {						
				sb.append(lvl.text + " ")						
			}
		}	
		return sb; 
	}	
    //===================================================
    
} //end of class