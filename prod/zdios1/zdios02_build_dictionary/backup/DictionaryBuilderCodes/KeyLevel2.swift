import Foundation

class KeyLevel {	 	
	
	init(){}    
    
	var text:String=""
    var content:String=""
    var level:Int = 0   
	var parentLevel:KeyLevel?     
	var mFavorChildren:[KeyLevel]? 				   
	var mChildren:[KeyLevel]? 			      
	//=========================================================================
	// Location on Canvas and Pick Child from location
	lazy var x : Double = 0.0
    lazy var y : Double = 0.0
    lazy var width : Double = 0.0
    lazy var height : Double = 0.0
	
	func pickChildKeyLevel(x:Double,y:Double) -> KeyLevel? {
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

	func pickFavorChildKeyLevel(x:Double,y:Double) -> KeyLevel? {
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
	//=========================================================================
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

} // end of class
	//=========================================================================
	// 
	func buildKeyLevelHierarchy(_ dictionaryDefinition:String) -> KeyLevel  {
	  	print("pos1")
		// Create top key level
		var lvl = KeyLevel();
		lvl.level = 0;
		lvl.text = "Dictionary" 		
		if dictionaryDefinition.characters.count < 1 {			
			return lvl;
		}
					
		// Create memory for selected key levels		
		var selKeyLevels = [KeyLevel]()
		selKeyLevels.append(lvl);

		// Scan dictionary definition string
		var depth:Int = 0
		var childText:String = ""
		var nu:KeyLevel	= KeyLevel() // Compiler forced to initialize here		
        //for i in 0..<dictionaryDefinition.characters.count {			
 		//	var cur = dictionaryDefinition(dictionaryDefinition.index(dictionaryDefinition.startIndex, offsetBy: i))
		for cur in dictionaryDefinition.characters {
            if cur=="(" {
				nu.text = childText
				print("Got Level: " + nu.text)
				childText = ""
				depth+=1	
			} else if cur==")" {				
				depth-=1
			} else if childText.characters.count<1 {
				nu = KeyLevel()
				var parentLevel = selKeyLevels[depth]
				if parentLevel.mChildren == nil {
					parentLevel.mChildren = [nu]
				} else {
					parentLevel.mChildren?.append(nu)
				}					
			} else {
				childText.append(cur)
			}
		}
		return lvl;

	} //end of func
	//=========================================================================

//let str = "a[aa[aaa[aaaaa]ab[aba]]]b[b1[b11[b111]b12[b121]]]c[c1[c1a[c1a1]c2[c2a]c3[c3a]]]d[]"
print("pos2")
var lvl = buildKeyLevelHierarchy(str)
print("pos3")
print(lvl.toStringLines())

	
	