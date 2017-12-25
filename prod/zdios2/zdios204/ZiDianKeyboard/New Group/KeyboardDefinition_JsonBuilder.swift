import Foundation

class KeyboardDefinition_JsonBuilder {
    
        
        //============================================
        // Letter key has Upper, Lower and a secondary cell
        let template_LetterKey = """
        {
        "name" : "Key_L_*",
        "text" : "Letter *",
        "widthInRowUnit" : 1,
        "mainCellArray" : [{"name":"L_*","text":"*", "widthInPopUpUnit":1},{"name":"#","text":"#", "widthInPopUpUnit":1}],
        "secondaryCellArray" : [{"name":"S_@","text":"@", "widthInPopUpUnit":1}],
        }
        """
        
        func buildLetterKey(_ letter:String, char2:Character) -> String {
            return template_LetterKey.replacingOccurrences(of: "*", with: letter)
                .replacingOccurrences(of: "#", with: letter.uppercased())
                .replacingOccurrences(of: "@", with: jsonEscapeCharacter(char2))
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
        // Symbol Key has one main cell, or another secondary cell.
        let template_SymbolKey1 = """
        {
        "name" : "Key_S_*",
        "text" : "Symbol *",
        "widthInRowUnit" : 1,
        "mainCellArray" : [{"name":"S_*","text":"*", "widthInPopUpUnit":1}]
        }
        """
        
        let template_SymbolKey2 = """
        {
        "name" : "Key_S_*_#",
        "text" : "Symbol * and #",
        "widthInRowUnit" : 1,
        "mainCellArray" : [{"name":"S_*","text":"*", "widthInPopUpUnit":1}],
        "secondaryCellArray" : [{"name":"S_#","text":"#", "widthInPopUpUnit":1}],
        }
        """
        
        func buildOneSymbolKey(_ char1:Character ) -> String {
            return template_SymbolKey1.replacingOccurrences(of: "*", with: jsonEscapeCharacter(char1))
        }
        
        func buildTwoSymbolKey(_ char1:Character, char2:Character) -> String {
            return template_SymbolKey2.replacingOccurrences(of: "*", with: jsonEscapeCharacter(char1)).replacingOccurrences(of: "#", with: jsonEscapeCharacter(char2))
        }
        
        
        /*
         Quotation mark (")    \"
         Backslash (\)    \\
         Slash (/)    \/
         Backspace    \b
         Form feed    \f
         New line    \n
         Carriage return    \r
         Horizontal tab    \t
         
         
         let syms = "@#$%&*\"\\"
         func jsonEscape(_ char:Character) -> String {
         if char == "\"" { return "SC_DOUBLEQUOTE"}
         else if char == "\\" { return "SC_BACKSLASH"}
         else { return String(char) }
         }
         for i in 0 ..< syms.count {
         let idx = syms.index(syms.startIndex, offsetBy: i)
         let c = syms[idx]
         print(jsonEscape(c))
         }
         
         
         */
        //============================================
        // Build multiple key definitions from Strings
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
                def += buildLetterKey(String(c1),char2: c2)
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
                def += buildTwoSymbolKey(c1,char2: c2)
            }
            return def
        }
        
        func buildOneSymbolKeys(_ char1s:String) -> String {
            
            var def = ""
            for c in char1s {
                if def.count>0 {
                    def += ", \n"
                }
                def += buildOneSymbolKey(c)
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
        // Build Action Keys
        let template_ActionKey_OneMainCell = """
        {
        "name" : "Key_A_*",
        "text" : "Action * ",
        "widthInRowUnit" : {WIDTH},
        "mainCellArray" : [{"name":"A_*","text":"*", "widthInPopUpUnit":1}]
        }
        """
        let template_ActionKey_TwoMainCells = """
        {
        "name" : "Key_A_*_#",
        "text" : "Action * and #",
        "widthInRowUnit" : {WIDTH},
        "mainCellArray" : [{"name":"A_*","text":"*", "widthInPopUpUnit":1},{"name":"A_#","text":"#", "widthInPopUpUnit":1}]
        }
        """
        
        func buildActionKey_OneMainCell(_ char1:String, width:Int=1 ) -> String {
            return template_ActionKey_OneMainCell.replacingOccurrences(of: "*", with: char1).replacingOccurrences(of: "{WIDTH}", with: String(width))
        }
        
        func buildActionKey_TwoMainCells(_ char1:String, char2:String, width:Int=1 ) -> String {
            return template_ActionKey_TwoMainCells.replacingOccurrences(of: "*", with: char1).replacingOccurrences(of: "#", with: char2).replacingOccurrences(of: "{WIDTH}", with: String(width))
        }
        
        //============================================
        // Specific Action Keys
        // Caps/Shift
        // Space
        // Enter
        // Backspace
        // SwitchPage
        //
        func buildActionKey_Shift() -> String {
            return buildActionKey_TwoMainCells("Up",char2: "Low", width: 1)
        }
        
        func buildActionKey_SwitchPage() -> String {
            return buildActionKey_TwoMainCells("abc", char2: "12#",width: 2)
        }
        
        func buildActionKey_Backspace() -> String {
            return buildActionKey_OneMainCell("Bksp",width: 1)
        }
        
        func buildActionKey_Space() -> String {
            return buildActionKey_OneMainCell("Space",width: 4)
        }
        
        func buildActionKey_Enter() -> String {
            return buildActionKey_OneMainCell("Enter",width: 2)
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
        // Page 1
        
        let p1r1m = "qwertyuiop"
        let p1r1s = "1234567890"
        // Shift key
        let p1r2m = "asdfghjkl"
        let p1r2s = "@#$%^&*()"
        
        // buildTwoSymbolKey("<",",")
        let p1r3m = "zxcvbnm"
        let p1r3s = "!:;\"'?-"
        // buildTwoSymbolKey(">",".")
        // Bksp key
        // rwo 4: SwitchPage 2,space 4, Enter 4
        
        // Page 2
        //buildOneSymbolKey `  +  {  }  \  /  buildDigitKeys 789+
        let p2r1 = "`+{}\\/"
        //buildOneSymbolKey ~  =  [  ]  |  _  buildDigitKeys 456-
        let p2r2 = "~=[]|_"
        //buildOneSymbolKey x  x  x  x  x  x  buildDigitKeys 123*
        let p2r3 = "xxxxxx"
        //Switch 2 Space 4
        //buildDigitKeys 0.=/
        
        //============================================
        //
        func buildDefaultKeyboard_2Pages() -> String {
            
            var kbd:String = ""
            kbd += startKeyboard("default2", text: "Default Keyboard 2")
            
            //----------------------------------------
            // Page 1
            kbd += startPage("page1", text: "Page 1")
            //--------------------- Page 1 Row 1
            kbd += startRow("row11", text: "Page 1 Row 1")
            kbd += buildLetterKeys(p1r1m, char2s:p1r1s)
            kbd += endArrayAndObject()
            kbd += separator()
            //--------------------- Page 1 Row 2
            kbd += startRow("row12", text: "Page 1 Row 2")
            kbd += buildActionKey_Shift()
            kbd += separator()
            kbd += buildLetterKeys(p1r2m, char2s:p1r2s)
            kbd += endArrayAndObject()
            kbd += separator()
            //--------------------- Page 1 Row 3
            kbd += startRow("row13", text: "Page 1 Row 3")
            kbd += buildLetterKeys(p1r3m, char2s:p1r3s)
            kbd += separator()
            kbd += buildActionKey_Backspace()
            kbd += endArrayAndObject()
            kbd += separator()
            //--------------------- Page 1 Row 4
            kbd += startRow("row14", text: "Page 1 Row 4")
            kbd += buildActionKey_SwitchPage()
            kbd += separator()
            kbd += buildOneSymbolKey(",")
            kbd += separator()
            kbd += buildActionKey_Space()
            kbd += separator()
            kbd += buildOneSymbolKey(".")
            kbd += separator()
            kbd += buildActionKey_Enter()
            kbd += endArrayAndObject()
            //---------------------
            kbd += endArrayAndObject()
            //----------------------------------------
            kbd += separator()
            //----------------------------------------
            // Page 2
            kbd += startPage("page2", text: "Page 2")
            //--------------------- Page 2 Row 1
            kbd += startRow("row21", text: "Page 2 Row 1")
            kbd += buildOneSymbolKeys(p2r1)
            kbd += separator()
            kbd += buildDigitKeys("789+")
            kbd += endArrayAndObject()
            kbd += separator()
            //--------------------- Page 2 Row 2
            kbd += startRow("row22", text: "Page 2 Row 2")
            kbd += buildOneSymbolKeys(p2r2)
            kbd += separator()
            kbd += buildDigitKeys("456-")
            kbd += endArrayAndObject()
            kbd += separator()
            //--------------------- Page 2 Row 3
            kbd += startRow("row23", text: "Page 2 Row 3")
            kbd += buildOneSymbolKeys(p2r3)
            kbd += separator()
            kbd += buildDigitKeys("123*")
            kbd += endArrayAndObject()
            kbd += separator()
            //--------------------- Page 2 Row 4
            kbd += startRow("row24", text: "Page 2 Row 4")
            kbd += buildActionKey_SwitchPage()
            kbd += separator()
            kbd += buildActionKey_Space()
            kbd += separator()
            kbd += buildDigitKeys("0.=/")
            kbd += endArrayAndObject()
            //---------------------
            kbd += endArrayAndObject();
            //----------------------------------------
            
            kbd += endArrayAndObject();
            return kbd
            
        } //end of func
        //============================================
        
        
} // end of class

/*
	let bldr = Keyboard2JsonBuilder()
	let kbd = bldr.buildDefaultKeyboard2()
	print(kbd)
*/


