import Foundation
	
class KeyboardDefinitionJsonBuilder {
	
	//============================================
	// Key Level: Only Main Cell
	static let template_keyDefChar1 = """
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
	static func keyDef(_ char1:String) -> String {
	    return template_keyDefChar1.replacingOccurrences(of: "*", with: char1)
	}
	
	//============================================
	// Key Level: Only Main Cell
	static let template_keyDefChar2 = """
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
	
	static func keyDef(_ char1:String, char2:String) -> String {
	    if String(char1)==" " { return " "} 
	    if String(char2)==" " {
	    	return template_keyDefChar1.replacingOccurrences(of: "*", with: char1)
	    } else {
	    	return template_keyDefChar2.replacingOccurrences(of: "*", with: char1).replacingOccurrences(of: "#", with: char2)
	    }
	}
	
	//============================================
	// Row Level: Main Cell Only
	static let template_close = """
		]
	}
	"""
	static let template_rowDef = """
	{
	"name" : "{NAME}",
	"text" : "{TEXT}",
	"keyArray" : [
	"""
	static let str1 = row1 + rowDef(upLetterPageR0, char2s:upLetterPageR0S) + close
	
	static func rowDef(_ char1s:String, name: String, text: String) -> String {
	    var strKeys = ""
	    for c in char1s {
			if strKeys.count>0 {
				strKeys += ", \n"
			}
	        strKeys += keyDef(String(c)) 
	    }
	    var temp1 = template_rowDef.replacingOccurrences(of: "{NAME}", with: name)
	    var temp2 = temp1.replacingOccurrences(of: "{TEXT}", with: text)
	    return temp2 + "\n" + strKeys + "\n" + template_close  	    
	}

	static func rowDef(_ char1s:String,char2s:String, name: String, text: String) -> String {
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
	    var temp1 = template_rowDef.replacingOccurrences(of: "{NAME}", with: name)
	    var temp2 = temp1.replacingOccurrences(of: "{TEXT}", with: text)
	    return temp2 + "\n" + strKeys + "\n" + template_close  
	}
	
	//============================================
	// Page Level
	static let template_pageDef = """
	{
	"name" : "{NAME}",
	"text" : "{TEXT}",
	"rowArray" : [
	"""
	static func pageDef(_ strRows:String, name: String, text: String) -> String {
	    var temp1 = template_rowDef.replacingOccurrences(of: "{NAME}", with: name)
	    var temp2 = temp1.replacingOccurrences(of: "{TEXT}", with: text)
	    return temp2 + "\n" + strRows + "\n" + template_close  
	}
	
	//============================================
	// Keyboard Level
	static let template_keyboardDef = """
	{
	"name" : "{NAME}",
	"text" : "{TEXT}",
	"pageArray" : [
	"""
	
	static func keyboardDef(_ strPages:String, name: String, text: String) -> String {
	    var temp1 = template_rowDef.replacingOccurrences(of: "{NAME}", with: name)
	    var temp2 = temp1.replacingOccurrences(of: "{TEXT}", with: text)
	    return temp2 + "\n" + strPages + "\n" + template_close  
	}
	
	//============================================
	//
	static let p1r1m = "qwertyuiop"
	static let p1r1s = "1234567890"
	static let p1r2m = "asdfghjkl"
	static let p1r2s = "-+*/"':;?"
	static let p1r3m = "zxcvbnm,."
	static let p1r3s = "()[]{}<>"
	
	static let p2r1m = "QWERTYUIOP"
	static let p2r1s = "1234567890"
	static let p2r2m = "ASDFGHJKL"
	static let p2r2s = "-+*/"':;?"
	static let p2r3m = "ZXCVBNM,."
	static let p2r3s = "()[]{}<>"
	
	static let p3r1m = "1234567890"
	static let p3r2m = "-+*/"':;?"
	static let p3r3m = "()[]{}<>"
	
	static let p4r1m = "!@#$%^&*()"
	static let p4r2m = "-+*/"':;?"
	static let p4r3m = "()[]{}<>"
	
    
	//============================================
	// 
	static func buildDefaultKeyboard() {
		let p1r1 = rowDef(p1r1m,p1r1s, name: "p1r1", text: "Page 1 Row 1")
		let p1r2 = rowDef(p1r2m,p1r2s, name: "p1r2", text: "Page 1 Row 2")
		let p1r3 = rowDef(p1r3m,p1r3s, name: "p1r3", text: "Page 1 Row 3")
		let p1r4 = rowDef(p1r4m,p1r4s, name: "p1r4", text: "Page 1 Row 4")
		let p1 = pageDef(p1r1 + "\n" + p1r2 + "\n" + p1r3 + "\n" +p1r4 + "\n", name: "p1", text: "Page 1")
		
		let p2r1 = rowDef(p2r1m,p2r1s, name: "p2r1", text: "Page 2 Row 1")
		let p2r2 = rowDef(p2r2m,p2r2s, name: "p2r2", text: "Page 2 Row 2")
		let p2r3 = rowDef(p2r3m,p2r3s, name: "p2r3", text: "Page 2 Row 3")
		let p2r4 = rowDef(p2r4m,p2r4s, name: "p2r4", text: "Page 2 Row 4")
		let p2 = pageDef(p2r1 + "\n" + p2r2 + "\n" + p2r3 + "\n" +p2r4 + "\n", name: "p2", text: "Page 2")
		
		let p3r1 = rowDef(p3r1m,p3r1s, name: "p3r1", text: "Page 3 Row 1")
		let p3r2 = rowDef(p3r2m,p3r2s, name: "p3r2", text: "Page 3 Row 2")
		let p3r3 = rowDef(p3r3m,p3r3s, name: "p3r3", text: "Page 3 Row 3")
		let p3r4 = rowDef(p3r4m,p3r4s, name: "p3r4", text: "Page 3 Row 4")
		let p3 = pageDef(p3r1 + "\n" + p3r2 + "\n" + p3r3 + "\n" +p3r4 + "\n", name: "p3", text: "Page 3")
		
		let p4r1 = rowDef(p4r1m,p4r1s, name: "p4r1", text: "Page 4 Row 1")
		let p4r2 = rowDef(p4r2m,p4r2s, name: "p4r2", text: "Page 4 Row 2")
		let p4r3 = rowDef(p4r3m,p4r3s, name: "p4r3", text: "Page 4 Row 3")
		let p4r4 = rowDef(p4r4m,p4r4s, name: "p4r4", text: "Page 4 Row 4")
		let p4 = pageDef(p4r1 + "\n" + p4r2 + "\n" + p4r3 + "\n" +p4r4 + "\n", name: "p4", text: "Page 4")
		
		let kbd = keyboardDef(p1 + "\n" + p2 + "\n" + p3 + "\n" +p4 + "\n", name: "kbd", text: "Keyboard")
		
		let obj = try JSONDecoder().decode(Keyboard.self, from: kbd)
							
		let jsonEncoder = JSONEncoder()
		do {
		    let jsonData = try jsonEncoder.encode(obj)
		    let jsonString = String(data: jsonData, encoding: .utf8) 
		    print("JSON String : " + jsonString! + "\n\n")	
		}
		catch {
		}
	
	} //end of func
	//============================================
	
	
	
	
	
	
} // end of class
