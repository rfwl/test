import Foundation

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
    /*
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
 
 */


