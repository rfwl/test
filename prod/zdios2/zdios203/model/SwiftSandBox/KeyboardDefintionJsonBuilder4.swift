import Foundation
//============================================
class KeyCell : Codable {
    
    var name:String    
    var text:String?
    var image:String?
    var widthInPopUpUnit:CGFloat = CGFloat(1)
}

class KeyboardKey : Codable {
 
    var name:String    
    var text:String?
   	var mainCellArray:[KeyCell]
 	var secondaryCellArray:[KeyCell]? = nil
 	var popUpCellArray:[KeyCell]? = nil    
    var widthInRowUnit:Int = 1
    
}   

class KeyboardRow : Codable {
    var name:String    
    var text:String?
    var keys:[KeyboardKey]

}

class KeyboardPage : Codable {
    var name:String    
    var text:String?
    var rows:[KeyboardRow]

}

class KeyboardDefinition : Codable {
    var name:String    
    var text:String?
    var pages:[KeyboardPage]

}

//============================================
// Letter key has Upper, Lower and 2nd Character
let template_LetterKey = """
{
"name" : "Key_L_*",
"text" : "Letter *",
"widthInRowUnit" : 1,
"mainCellArray" : [{"name":"L_*","text":"*", "widthInPopUpUnit":1},{"name":"#","text":"#", "widthInPopUpUnit":1}],
"secondaryCellArray" : [{"name":"S_@","text":"@", "widthInPopUpUnit":1}],
}
"""

func buildLetterKey(_ letter:String, char2:String){
	 return template_LetterKey.replacingOccurrences(of: "*", with: letter)
	 .replacingOccurrences(of: "*", with: letter)
	 .replacingOccurrences(of: "@", with: char2)		
}
//============================================
// Digit key has one main cell only
let template_DigitKey = """
{
"name" : "Key_D_*",
"text" : "Digit *",
"widthInRowUnit" : 1,
"mainCellArray" : [{"name":"D_*","text":"*", "widthInPopUpUnit":1}]
}
"""
func buildDigitKey(_ digit:String) -> String {
    return template_DigitKey.replacingOccurrences(of: "*", with: digit)
}

//============================================
// Symbol Key has one main cell, or  another secondary cell.
let template_SymbolKey1 = """
{
"name" : "Key_S_#",
"text" : "Symbol * and #",
"widthInRowUnit" : 1,
"mainCellArray" : [{"name":"S_*","text":"*", "widthInPopUpUnit":1}]
}
"""

let template_SymbolKey2 = """
{
"name" : "Key_S_#",
"text" : "Symbol * and #",
"widthInRowUnit" : 1,
"mainCellArray" : [{"name":"S_*","text":"*", "widthInPopUpUnit":1}],
"secondaryCellArray" : [{"name":"S_#","text":"#", "widthInPopUpUnit":1}],
}
"""

func buildOneSymbolKey(_ char1:String ) -> String {
    return template_SymbolKey1.replacingOccurrences(of: "*", with: char1).replacingOccurrences(of: "#", with: char2)
}

func buildTwoSymbolKey(_ char1:String, char2:String) -> String {
    return template_SymbolKey2.replacingOccurrences(of: "*", with: char1).replacingOccurrences(of: "#", with: char2)
}
//============================================
// Build Action Keys
let template_ActionKey1 = """
{
"name" : "Key_A_#",
"text" : "Action * and #",
"widthInRowUnit" : 1,
"mainCellArray" : [{"name":"A_*","text":"*", "widthInPopUpUnit":1}]
}
"""
let template_ActionKey2 = """
{
"name" : "Key_A_#",
"text" : "Action * and #",
"widthInRowUnit" : 1,
"mainCellArray" : [{"name":"A_*","text":"*", "widthInPopUpUnit":1}],
"secondaryCellArray" : [{"name":"A_#","text":"#", "widthInPopUpUnit":1}],
}
"""

func buildOneActionKey(_ char1:String ) -> String {
    return template_ActionKey1.replacingOccurrences(of: "*", with: char1).replacingOccurrences(of: "#", with: char2)
}

func buildTwoActionKey(_ char1:String, char2:String) -> String {
    return template_ActionKey2.replacingOccurrences(of: "*", with: char1).replacingOccurrences(of: "#", with: char2)
}
//============================================
// Specific Action Keys
// Caps/Shift
// Space
// Enter
// Backspace
// SwitchPage
//  

 
//============================================
// Build multiple key definitions
func buildLetterKeys(_ char1s:String, char2s:String) -> String {
    var def = "" 
    for i in 0 ..< min(char1s.count, char2s.count) {
        let idx1 = char1s.index(char1s.startIndex, offsetBy: i)
        let idx2 = char2s.index(char2s.startIndex, offsetBy: i)
        let c1 = char1s[idx1]
		if String(c1)==" " { continue}
        let c2 = char2s[idx2]
		if String(c2)==" " { continue}
		if def.count>0 {
			def += ", \n"
		}
        def += buildLetter(String(c1),char2: String(c2))
    }
    return def
}

func buildTwoSymbolKeys(_ char1s:String, char2s:String) -> String {
    var def = "" 
    for i in 0 ..< min(char1s.count, char2s.count) {
        let idx1 = char1s.index(char1s.startIndex, offsetBy: i)
        let idx2 = char2s.index(char2s.startIndex, offsetBy: i)
        let c1 = char1s[idx1]
		if String(c1)==" " { continue}
        let c2 = char2s[idx2]
		if String(c2)==" " { continue}
		if def.count>0 {
			def += ", \n"
		}
        def += buildTwoSymbolKey(String(c1),char2: String(c2))
    }
    return def
}

func buildOneSymbolKeys(_ char1s:String) -> String {

    var def = ""
    for c in char1s {
		if def.count>0 {
			def += ", \n"
		}
        def += buildOneSymbolKey(String(c)) 
    }
    return def
}

func buildDigitKeys(_ char1s:String) -> String {

    var def = ""
    for c in char1s {
		if def.count>0 {
			def += ", \n"
		}
        def += buildDigitKey(String(c)) 
    }
    return def
}
//============================================
// Row, Page and KBD level

func separator() -> String {
	return "\n,\n"
}

let closeArrayAndObject = """
	]
}
"""
func endArrayAndObject() -> String {
	return closeArrayAndObject
}

let template_Row = """
{
"name" : "{name}",
"text" : "{text}",
"keyArray" : [
"""
func startRow(_ name: String, text:String) -> String {
	return template_Row.replacingOccurrences(of: "{name}", with: name).replacingOccurrences(of: "{text}", with: text)
}

let template_Page = """
{
"name" : "{name}",
"text" : "{text}",
"rowArray" : [
"""
func startPage(_ name: String, text:String) -> String {
	return template_Page.replacingOccurrences(of: "{name}", with: name).replacingOccurrences(of: "{text}", with: text)
}

let template_Keyboard = """
{
"name" : "{name}",
"text" : "{text}",
"pageArray" : [
"""
func startKeyboard(_ name: String, text:String) -> String {
	return template_Keyboard.replacingOccurrences(of: "{name}", with: name).replacingOccurrences(of: "{text}", with: text)
}

//============================================

//============================================
// 

    let p1r1m = "qwertyuiop"
    let p1r1s = "1234567890"
    let p1r2m = "asdfghjkl"
    let p1r2s = "\-(:)&#*\""
    let p1r3m = "zxcvbnm"
    let p1r3s = "@/-'!?;"
        
   

 
//============================================
//
func buildDefaultKeyboard2() -> String {

	var kbd:String =""
	kbd += startKeyboard("default2", text: "Default Keyboard 2") 
	//----------------------------------------
	// Page 1
	kbd += startPage("page1", text: "Page 1") 
	//--------------------- Page 1 Row 1
	kbd += startRow("row11", text: "Page 1 Row 1")
	kbd += buildLetterKeys(_ char1s:p1r1m, char2s:p1r1s) 
	kbd += endArrayAndObject();
	kbd += separator();
	//--------------------- Page 1 Row 2
	kbd += startRow("row12", text: "Page 1 Row 2")
	kbd += buildLetterKeys(_ char1s:p1r2m, char2s:p1r2s)
	kbd += endArrayAndObject();
	kbd += separator();
	//--------------------- Page 1 Row 3
	kbd += startRow("row13", text: "Page 1 Row 3")
	kbd += buildLetterKeys(_ char1s:p1r2m, char2s:p1r2s)
	kbd += endArrayAndObject();
	kbd += separator();
	//--------------------- Page 1 Row 4
	kbd += startRow("row14", text: "Page 1 Row 4")
	
	
	kbd += endArrayAndObject();
	//---------------------
	kbd += endArrayAndObject();
	kbd += separator(); 
	//----------------------------------------
	// Page 2
	kbd += startKeyboard("page2", text: "Page 2")
	//--------------------- Page 2 Row 1
	kbd += startRow("row11", text: "Page 2 Row 1")
	kbd += buildDigitKeys(_ char1s:"123"), char2s:p1r1s) 
	kbd += separator();
	
	kbd += endArrayAndObject();
	kbd += separator();
	
	
	
	kbd += endArrayAndObject();
	//----------------------------------------
	kbd += endArrayAndObject();
	return kbd

} //end of func
//============================================


