import Foundation
//============================================
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
// "secondaryCellArray" : [{"name":"*0","text":"*0", "widthInPopUpUnit":1}], Removed.

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

func keyDef(_ char1:String) -> String {
    return template_keyDefChar1.replacingOccurrences(of: "*", with: char1)
}

func keyDef(_ char1:String, char2:String) -> String {
    if String(char1)==" " { return " "} 
    if String(char2)==" " {
    	return template_keyDefChar1.replacingOccurrences(of: "*", with: char1)
    } else {
    	return template_keyDefChar2.replacingOccurrences(of: "*", with: char1).replacingOccurrences(of: "#", with: char2)
    }
}

func rowDef(_ char1s:String) -> String {
    var def = ""
    for c in char1s {
		if def.count>0 {
			def += ", \n"
		}
        def += keyDef(String(c)) 
    }
    return def
}

func rowDef(_ char1s:String,char2s:String) -> String {
    var def = "" 
    for i in 0 ..< min(char1s.count, char2s.count) {
        let idx1 = char1s.index(char1s.startIndex, offsetBy: i)
        let idx2 = char2s.index(char2s.startIndex, offsetBy: i)
        let c1 = char1s[idx1]
        let c2 = char2s[idx2]
		if def.count>0 {
			def += ", \n"
		}
        def += keyDef(String(c1),char2: String(c2))
    }
    return def
}
//============================================
// Cell level
/*
let str1 = """
  {"name":"P1A","text":"A", "widthInPopUpUnit":1}
"""

let json1 = str1.data(using: .utf8)!
let rowObj1 = try JSONDecoder().decode(KeyCell.self, from: json1)
dump(rowObj1)
				

let jsonEncoder = JSONEncoder()
do {
    let jsonData = try jsonEncoder.encode(rowObj1)
    let jsonString = String(data: jsonData, encoding: .utf8) 
    print("JSON String : " + jsonString! + "\n\n")
	
}
catch {
}
*/
//============================================
// Key level
/*
let str1 = """
{ 	"name" : "Key1",
 	"text" : "Key 1",
	"widthInRowUnits" : 1,
	"mainCellArray" : [
{"name":"P1A","text":"A", "widthInPopUpUnit":1},
{"name":"P1B","text":"B", "widthInPopUpUnit":1}
]
}
"""
 
let str1 = keyDef("Q")

let str1 = keyDef("Q", char2:"@")
print(str1)


let json1 = str1.data(using: .utf8)!
let rowObj1 = try JSONDecoder().decode(KeyboardKey.self, from: json1)
dump(rowObj1)
let jsonEncoder = JSONEncoder()
do {
    let jsonData = try jsonEncoder.encode(rowObj1)
    let jsonString = String(data: jsonData, encoding: .utf8) 
    print("JSON String : " + jsonString! + "\n\n")	
}catch {}
*/
//============================================
// Row level
let close = """
	]
}
"""
let row1 = """
{
"name" : "Row1",
"text" : "Row 1",
"keyArray" : [
"""

let upLetterPageR0 = "QWERTYUIOP"
let upLetterPageR0S = "1234567890"
let str1 = row1 + rowDef(upLetterPageR0, char2s:upLetterPageR0S) + close
print(str1)
		
let json1 = str1.data(using: .utf8)!

let rowObj1 = try JSONDecoder().decode(KeyboardRow.self, from: json1)
dump(rowObj1)
				

let jsonEncoder = JSONEncoder()
do {
    let jsonData = try jsonEncoder.encode(rowObj1)
    let jsonString = String(data: jsonData, encoding: .utf8) 
    print("JSON String : " + jsonString! + "\n\n")
	
}
catch {
}

  
//============================================

