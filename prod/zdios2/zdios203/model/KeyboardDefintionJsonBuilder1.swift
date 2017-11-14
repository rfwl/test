//============================================
let kbd = """
{
	"name" : "DefaultKeyboardDefinition",
	"text" : "English Keyboard",
	"pages" : 
	[ 
"""
let array_object_close = """
	]
}
"""
//============================================
let p1 = """
 		{
 			"name" : "P1",
 			"text" : "Page Uppercase",
 			"rows" : [
"""
let p2 = """
 		{
 			"name" : "P2",
 			"text" : "Page Lowercase",
 			"rows" : [
"""
let p3 = """
 		{
 			"name" : "P3",
 			"text" : "Page Number",
 			"rows" : [
"""
let p4 = """
 		{
 			"name" : "P4",
 			"text" : "Page Symbol",
 			"rows" : [
"""
//============================================
let p1r1 = """
 		{
 			"name" : "P1R1",
 			"text" : "Page 1 Row 1",
 			"keys" : [
"""
let p1r2 = """
 		{
 			"name" : "P1R2",
 			"text" : "Page 1 Row 2",
 			"keys" : [
"""
let p1r3 = """
 		{
 			"name" : "P1R3",
 			"text" : "Page 1 Row 3",
 			"keys" : [
"""
let p1r4 = """
 		{
 			"name" : "P1R4",
 			"text" : "Page 1 Row 4",
 			"keys" : [
"""
//============================================

let p2r1 = """
 		{
 			"name" : "P2R1",
 			"text" : "Page 2 Row 1",
 			"keys" : [
"""
let p2r2 = """
 		{
 			"name" : "P2R2",
 			"text" : "Page 2 Row 2",
 			"keys" : [
"""
let p2r3 = """
 		{
 			"name" : "P2R3",
 			"text" : "Page 2 Row 3",
 			"keys" : [
"""
let p2r4 = """
 		{
 			"name" : "P2R4",
 			"text" : "Page 2 Row 4",
 			"keys" : [
"""
//============================================
let p3r1 = """
 		{
 			"name" : "P3R1",
 			"text" : "Page 3 Row 1",
 			"keys" : [
"""
let p3r2 = """
 		{
 			"name" : "P3R2",
 			"text" : "Page 3 Row 2",
 			"keys" : [
"""
let p3r3 = """
 		{
 			"name" : "P3R3",
 			"text" : "Page 3 Row 3",
 			"keys" : [
"""
let p3r4 = """
 		{
 			"name" : "P3R4",
 			"text" : "Page 3 Row 4",
 			"keys" : [
"""
//============================================
let p4r1 = """
 		{
 			"name" : "P4R1",
 			"text" : "Page 4 Row 1",
 			"keys" : [
"""
let p4r2 = """
 		{
 			"name" : "P4R2",
 			"text" : "Page 4 Row 2",
 			"keys" : [
"""
let p4r3 = """
 		{
 			"name" : "P4R3",
 			"text" : "Page 4 Row 3",
 			"keys" : [
"""
let p4r4 = """
 		{
 			"name" : "P4R4",
 			"text" : "Page 4 Row 4",
 			"keys" : [
"""
//============================================
let template_keyDefChar1 = """
{
"name" : "Key*",
"text" : "Key *",
"widthInRowUnit" : 1,
"mainCellArray" : [{"name":"*","text":"*"}],
"secondaryCellArray" : [{"name":"*0","text":"*0"}],
"popUpCellArray" : [{"name":"*1","text":"*1"},{"name":"*2","text":"*2"},{"name":"*3","text":"*3"},{"name":"*4","text":"*4"},{"name":"*5","text":"*5"}]
}
"""

let template_keyDefChar2 = """
{
"name" : "Key*#",
"text" : "Key * and #",
"widthInRowUnit" : 1,
"mainCellArray" : [{"name":"*","text":"*"}],
"secondaryCellArray" : [{"name":"#","text":"#"}],
"popUpCellArray" : [{"name":"*1","text":"*1"},{"name":"*2","text":"*2"},{"name":"*3","text":"*3"},{"name":"*4","text":"*4"},{"name":"*5","text":"*5"}]
}
"""

func keyDef(_ char1:String) -> String {
    return template_keyDefChar1.replacingOccurrences(of: "*", with: char1)
}

func keyDef(_ char1:String, char2:String) -> String {
    return template_keyDefChar2.replacingOccurrences(of: "*", with: char1).replacingOccurrences(of: "#", with: char2)
}

func rowDef(_ char1s:String) -> String {
    var def = ""
    for c in char1s {
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
        let c2 = char1s[idx2]
        def += keyDef(String(c1),char2: String(c2))
    }
    return def
}

//============================================


//============================================


//============================================


//============================================



























//============================================



//============================================



//============================================














