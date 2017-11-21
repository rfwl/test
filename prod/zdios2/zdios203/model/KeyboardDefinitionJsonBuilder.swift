import Foundation

class Settings {
   
    static let Main_Cell_Font_Size:CGFloat = CGFloat(22)
    static let Secondary_Cell_Font_Size:CGFloat = CGFloat(10)
    static let PopUp_Cell_Font_Size:CGFloat = CGFloat(16)
    
    //======================================================
    
        
    //======================================================
    
} // end of class

class KeyCell : Codable {
    
    var name:String
    var text:String?
    var image:String?
    var widthInPopUpUnit:CGFloat = CGFloat(1)
    var fontSize:CGFloat = Settings.Main_Cell_Font_Size
    
    enum CodingKeys: String, CodingKey {
        case name 
        case text
        case image  
		case widthInPopUpUnit	
    }
    //======================================================
    //
    init(_ char:String) {
        self.name = char
        self.text = char
        self.image = nil
    }
    
    init(name:String, text:String) {
        self.name = name
        self.text = text
        self.image = nil
    }
    
    init(name:String, image:String) {
        self.name = name
        self.text = nil
        self.image = image
    }
    //======================================================
    //
	/*
    var textView:UIView {
        get {
            let lbl:UILabel = UILabel()
            lbl.textAlignment = NSTextAlignment.center
            lbl.baselineAdjustment = UIBaselineAdjustment.alignCenters
            lbl.font = lbl.font.withSize(self.fontSize)
            lbl.adjustsFontSizeToFitWidth = true
            lbl.minimumScaleFactor = CGFloat(0.1)
            lbl.isUserInteractionEnabled = false
            lbl.numberOfLines = 1
            lbl.text = self.text
            lbl.backgroundColor = UIColor.brown
            return lbl
        }
    }
    
    var imageView:UIImageView? {
        get {
            if let img = ImageLibrary.buildUIImage(self.image!) {
                let iv:UIImageView = UIImageView(image: img) //UIImageView is said to be fast
                iv.contentMode = UIViewContentMode.scaleAspectFit
                iv.backgroundColor = UIColor.brown
                return iv
            }
            return nil
        }
    }
    */
   

    //======================================================
    
} // end of class


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
   	/*
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
	*/
    //======================================================
    //
    
    //======================================================
    
} // end of class


class KeyboardRow : Codable {
    
    //================================================
    // Data
    var name:String
    var text:String?  
    var keyArray:[KeyboardKey]
    
    var rowUnitTotal:CGFloat=10
    var height:CGFloat = 1
    
    var paddingTop:CGFloat = 0.1
    var paddingBottom:CGFloat = 0.1
    var paddingLeft:CGFloat = 0.1
    var paddingRight:CGFloat = 0.1
    var gap:CGFloat = 0.1
    
    enum CodingKeys: String, CodingKey {
        case name 
        case text
        case keyArray  
        //case rowUnitTotal
        //case height
        //case paddingTop
        //case paddingBottom
        //case paddingLeft
        //case paddingRight
        //case gap
           
    }
    //================================================
    // Init
    init() {
		self.name = ""
		self.text = ""
        self.keyArray = [KeyboardKey]()
        self.frame = .zero
    }
    
    convenience init(charArray: [Character]){
        self.init()
        addCharArray(charArray)
    }
    convenience init(charString: String){
        self.init()
        addCharString(charString)
    }
    
    convenience init(keys:[KeyboardKey]){
        self.init()
        self.keyArray = keys
    }
    
    func addCharArray(_ charArray: [Character]){
        for c in charArray {
            let k = KeyboardKey(String(c))
            self.keyArray.append(k)
        }
    }
    func addCharString(_ charString: String){
        for c in charString.characters {
            let k = KeyboardKey(String(c))
            self.keyArray.append(k)
        }
    }
    func addFirstKey(_ key: KeyboardKey) {
        self.keyArray.insert(key,at: 0);
    }
    
    func addLastKey(_ key: KeyboardKey) {
        self.keyArray.append(key);
    }
    
    //================================================
    //
    var frame:CGRect = CGRect.zero // Set from KeyboardPage
    var heightScale:CGFloat = CGFloat(1.0)
    /*
    func layoutKeys() { 
    	if(self.frame.width==0) {return}
        let rowWidthInUnit = self.rowUnitTotal + self.paddingLeft + self.paddingRight + ( self.rowUnitTotal - CGFloat(1.0) ) * self.gap
        let oneUnitWidth = self.frame.width / rowWidthInUnit
        if(oneUnitWidth==0) {return}
        var xOffset:CGFloat = self.paddingLeft * oneUnitWidth
        for key in self.keyArray {
            key.frame.origin.y = self.frame.origin.y + self.paddingTop * self.heightScale
            key.frame.size.height = self.frame.height - (self.paddingTop + self.paddingBottom) * self.heightScale
            key.frame.origin.x = xOffset
            key.frame.size.width = (CGFloat(key.widthInUnit) + CGFloat((key.rowWidthInUnit-1)) * self.gap) * oneUnitWidth
            xOffset += key.frame.width + self.gap * oneUnitWidth
        }
    }
    */
    //================================================
    //
    
} //end of class



class KeyboardPage : Codable {
    
    //================================================
    // Data
    var name:String
    var text:String?  
    var rowArray: [KeyboardRow]
    
    enum CodingKeys: String, CodingKey {
        case name 
        case text
        case rowArray  
    }
    //================================================
    // Init    
    init(_ rows:[KeyboardRow]){
		self.name = ""
		self.text = ""
        self.rowArray = rows        
    }
    
    //================================================
    //
    var frame:CGRect = CGRect.zero // Set from KeyboardPage
    /*
    // Assign frame and height scale to each row  
    func layoutRows() { 
        if(self.frame.height==0) { return }        
        var totalSpecifiedHeight : CGFloat = 0
        for row in self.rowArray {
            totalSpecifiedHeight += row.paddingTop + row.height + row.paddingBottom
        }
        let heightScale = self.frame.height / totalSpecifiedHeight
        if(heightScale==0) {return}
        
        var yOffset:CGFloat = 0
        for row in self.rowArray {
            row.frame.origin.x = 0
            row.frame.size.width = self.frame.width
            row.frame.origin.y = yOffset + row.paddingTop * heightScale
            row.frame.size.height = row.height * heightScale
            row.heightScale = heightScale
            yOffset += row.frame.height
        }
    } 
	*/
    //================================================
    
} //end of class


class KeyboardDefinition : Codable {
    
    //================================================
    // Data
    var name:String
    var text:String?  
    var pageArray: [KeyboardPage]
    
    //================================================
    // Init    
    init(_ pages:[KeyboardPage]){
		self.name = ""
		self.text = ""
		
        self.pageArray = pages        
    }
    
    //================================================
} //end of class

	
class KeyboardDefinitionJsonBuilder {
	
	//============================================
	// Key Level: Only Main Cell
	let template_keyDefChar1 = """
	{
	"name" : "Key*",
	"text" : "Key *",
	"widthInRowUnit" : 1,
	"mainCellArray" : [{"name":"*","text":"*", "widthInPopUpUnit":1}],
	"popUpCellArray" : [
	{"name":"*1","text":"*1", "widthInPopUpUnit" : 1},
	{"name":"*2","text":"*2", "widthInPopUpUnit" : 1},
	{"name":"*3","text":"*3", "widthInPopUpUnit" : 1},
	{"name":"*4","text":"*4", "widthInPopUpUnit" : 1},
	{"name":"*5","text":"*5", "widthInPopUpUnit" : 1}
	]
	}
	"""
	func keyDef(_ char1:String) -> String {
	    return template_keyDefChar1.replacingOccurrences(of: "*", with: char1)
	}
	
	//============================================
	// Key Level: Only Main Cell
	let template_keyDefChar2 = """
	{
	"name" : "Key*#",
	"text" : "Key * and #",
	"widthInRowUnit" : 1,
	"mainCellArray" : [{"name":"*","text":"*", "widthInPopUpUnit":1}],
	"secondaryCellArray" : [{"name":"#","text":"#", "widthInPopUpUnit":1}],
	"popUpCellArray" : [
	{"name":"*1","text":"*1", "widthInPopUpUnit" : 1},
	{"name":"*2","text":"*2", "widthInPopUpUnit" : 1},
	{"name":"*3","text":"*3", "widthInPopUpUnit" : 1},
	{"name":"*4","text":"*4", "widthInPopUpUnit" : 1},
	{"name":"*5","text":"*5", "widthInPopUpUnit" : 1}
	]
	}
	"""
	
	func keyDef(_ char1:String, char2:String) -> String {
	    if String(char1)==" " { return " "} 
	    if String(char2)==" " {
	    	return template_keyDefChar1.replacingOccurrences(of: "*", with: char1)
	    } else {
	    	return template_keyDefChar2.replacingOccurrences(of: "*", with: char1).replacingOccurrences(of: "#", with: char2)
	    }
	}
	
	//============================================
	// Row Level: Main Cell Only
	let template_close = """
		]
	}
	"""
	let template_rowDef = """
	{
	"name" : "{NAME}",
	"text" : "{TEXT}",
	"keyArray" : [
	"""	
	
	func rowDef(_ char1s:String, name: String, text: String) -> String {
	    var strKeys = ""
	    for c in char1s {
			if strKeys.count>0 {
				strKeys += ", \n"
			}
	        strKeys += keyDef(String(c)) 
	    }
	    let temp1 = template_rowDef.replacingOccurrences(of: "{NAME}", with: name)
	    let temp2 = temp1.replacingOccurrences(of: "{TEXT}", with: text)
	    return temp2 + "\n" + strKeys + "\n" + template_close  	    
	}

	func rowDef(_ char1s:String,char2s:String, name: String, text: String) -> String {
	    var strKeys = "" 
	    for i in 0 ..< min(char1s.count, char2s.count) {
	        let idx1 = char1s.index(char1s.startIndex, offsetBy: i)
	        let idx2 = char2s.index(char2s.startIndex, offsetBy: i)
	        let c1 = char1s[idx1]
	        let c2 = char2s[idx2]
			if strKeys.count>0 {
				strKeys += ", \n"
			}
	        strKeys += keyDef(String(c1),char2: String(c2))
	    }
	    let temp1 = template_rowDef.replacingOccurrences(of: "{NAME}", with: name)
	    let temp2 = temp1.replacingOccurrences(of: "{TEXT}", with: text)
	    return temp2 + "\n" + strKeys + "\n" + template_close  
	}
	
	//============================================
	// Page Level
	let template_pageDef = """
	{
	"name" : "{NAME}",
	"text" : "{TEXT}",
	"rowArray" : [
	"""
	func pageDef(_ strRows:String, name: String, text: String) -> String {
	    let temp1 = template_pageDef.replacingOccurrences(of: "{NAME}", with: name)
	    let temp2 = temp1.replacingOccurrences(of: "{TEXT}", with: text)
	    return temp2 + "\n" + strRows + "\n" + template_close  
	}
	
	//============================================
	// Keyboard Level
	let template_keyboardDef = """
	{
	"name" : "{NAME}",
	"text" : "{TEXT}",
	"pageArray" : [
	"""
	
	func keyboardDef(_ strPages:String, name: String, text: String) -> String {
	    let temp1 = template_keyboardDef.replacingOccurrences(of: "{NAME}", with: name)
	    let temp2 = temp1.replacingOccurrences(of: "{TEXT}", with: text)
	    return temp2 + "\n" + strPages + "\n" + template_close  
	}
	
	//============================================
	// CAUTION: DOUBLE QUOTE Character can not be included in the strings.
	let p1r1m = "qwertyuiop"
	let p1r1s = "1234567890"
	let p1r2m = "asdfghjkl"
	let p1r2s = "-+*/':;?"
	let p1r3m = "zxcvbnm,."
	let p1r3s = "()[]{}<>"
	
	let p2r1m = "QWERTYUIOP"
	let p2r1s = "1234567890"
	let p2r2m = "ASDFGHJKL"
	let p2r2s = "-+*/':;?"
	let p2r3m = "ZXCVBNM,."
	let p2r3s = "()[]{}<>"
	
	let p3r1m = "1234567890"
	let p3r2m = "-+*/':;?"
	let p3r3m = "()[]{}<>"
	
	let p4r1m = "!@#$%^&*()"
	let p4r2m = "-+*/':;?"
	let p4r3m = "()[]{}<>"
	
    
	//============================================
	// 
	func buildDefaultKeyboardRow() -> String {
		let p1r1 = rowDef(p1r1m,char2s: p1r1s, name: "p1r1", text: "Page 1 Row 1")
		return p1r1
	}
	
	func buildDefaultKeyboardPage() -> String {
		let p1r1 = rowDef(p1r1m,char2s: p1r1s, name: "p1r1", text: "Page 1 Row 1")
		let p1r2 = rowDef(p1r2m,char2s: p1r2s, name: "p1r2", text: "Page 1 Row 2")
		let p1r3 = rowDef(p1r3m,char2s: p1r3s, name: "p1r3", text: "Page 1 Row 3")
		//let p1r4 = rowDef(p1r4m,char2s: p1r4s, name: "p1r4", text: "Page 1 Row 4")
		let p1 = pageDef(p1r1 + ",\n\n" + p1r2 + ",\n\n" + p1r3 + "\n\n" + "\n", name: "p1", text: "Page 1")
		return p1
	}
	
	func buildDefaultKeyboard() -> String {
		let p1r1 = rowDef(p1r1m,char2s: p1r1s, name: "p1r1", text: "Page 1 Row 1")
		let p1r2 = rowDef(p1r2m,char2s: p1r2s, name: "p1r2", text: "Page 1 Row 2")
		let p1r3 = rowDef(p1r3m,char2s: p1r3s, name: "p1r3", text: "Page 1 Row 3")
		//let p1r4 = rowDef(p1r4m,char2s: p1r4s, name: "p1r4", text: "Page 1 Row 4")
		let p1 = pageDef(p1r1 + ",\n\n" + p1r2 + ",\n\n" + p1r3 + "\n\n" + "\n", name: "p1", text: "Page 1")
		
		let p2r1 = rowDef(p2r1m,char2s: p2r1s, name: "p2r1", text: "Page 2 Row 1")
		let p2r2 = rowDef(p2r2m,char2s: p2r2s, name: "p2r2", text: "Page 2 Row 2")
		let p2r3 = rowDef(p2r3m,char2s: p2r3s, name: "p2r3", text: "Page 2 Row 3")
		//let p2r4 = rowDef(p2r4m,char2s: p2r4s, name: "p2r4", text: "Page 2 Row 4")
		let p2 = pageDef(p2r1 + ",\n\n" + p2r2 + ",\n\n" + p2r3 + "\n\n" + "\n", name: "p2", text: "Page 2")
		
		let p3r1 = rowDef(p3r1m, name: "p3r1", text: "Page 3 Row 1")
		let p3r2 = rowDef(p3r2m, name: "p3r2", text: "Page 3 Row 2")
		let p3r3 = rowDef(p3r3m, name: "p3r3", text: "Page 3 Row 3")
		//let p3r4 = rowDef(p3r4m, name: "p3r4", text: "Page 3 Row 4")
		let p3 = pageDef(p3r1 + ",\n\n" + p3r2 + ",\n\n" + p3r3 + "\n\n" + "\n", name: "p3", text: "Page 3")
		
		let p4r1 = rowDef(p4r1m, name: "p4r1", text: "Page 4 Row 1")
		let p4r2 = rowDef(p4r2m, name: "p4r2", text: "Page 4 Row 2")
		let p4r3 = rowDef(p4r3m, name: "p4r3", text: "Page 4 Row 3")
		//let p4r4 = rowDef(p4r4m, name: "p4r4", text: "Page 4 Row 4")
		let p4 = pageDef(p4r1 + ",\n\n" + p4r2 + ",\n\n" + p4r3 + "\n\n" + "\n", name: "p4", text: "Page 4")
		
		let kbd = keyboardDef(p1 + ",\n\n\n" + p2 + ",\n\n\n" + p3 + ",\n\n\n" + p4 + "\n\n", name: "kbd", text: "Keyboard")
		
		return kbd
	
	
	} //end of func
	//============================================
	
		
} // end of class
		
	let bldr = KeyboardDefinitionJsonBuilder()
	
	//let strRow = bldr.buildDefaultKeyboardRow()	
	//print(strRow)	
	//let obj = try JSONDecoder().decode(KeyboardRow.self, from: strRow.data(using: .utf8)! )
	// Test Passed 
	
	//let strPage = bldr.buildDefaultKeyboardPage()	
	//print(strPage)	
	//let obj = try JSONDecoder().decode(KeyboardPage.self, from: strPage.data(using: .utf8)! )
	// Test Passed 	
	let strKBD = bldr.buildDefaultKeyboard()
	print(strKBD)	
	
	let obj = try JSONDecoder().decode(KeyboardDefinition.self, from: strKBD.data(using: .utf8)! )
	
	let jsonEncoder = JSONEncoder()
	do {
		let jsonData = try jsonEncoder.encode(obj)
		let jsonString = String(data: jsonData, encoding: .utf8) 
		print("JSON String : " + jsonString! + "\n\n")	
	}
	catch {
	}
	
		
		
		
		










