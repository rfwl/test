import UIKit

class KeyboardKey {
 
   	//================================================
   	// Data set from the outside only 
    var name: String?
   	var label: String?
   	var output: String?   	
   	var width:Int = 1 //Key width in cells
    var type : EnumKeyType = .Character
    
    //================================================
   	// Init
    init(_ keyType:EnumKeyType) {
    	self.type = keyType
    	self.frame = .zero
        self.view = nil
    }
    
    convenience init(char:Character) {   
        self.init(.Character)
        label = String(char)
        output = String(char)
    }
    //================================================
   	// Key Type       	
   	enum EnumKeyType {
        case Character
        case SpecialCharacter
        case Backspace
        case PageChangeUpper
        case PageChangeLower
        case PageChangeNumber
        case PageChangeSymbol
        case KeyboardChange
        case Period
        case Space
        case Return
        case Settings
        case Other
    }
    //================================================
   	//
   	var frame:CGRect
   	var view:UIView?
    
} // end of class
 
 
class KeyboardRow {
 
   	//================================================
   	// Data
    var cellTotal:CGFloat=10
   	var height:CGFloat = 1
   	var paddingTop:CGFloat = 0.1
   	var paddingBottom:CGFloat = 0.1
   	var paddingLeft:CGFloat = 0.1
   	var paddingRight:CGFloat = 0.1
   	var gap:CGFloat = 0.1
   	var keys:[KeyboardKey]!
    

   	//================================================
   	// Init 
   	
   	init() {
   		self.keys = [KeyboardKey]()
   		self.frame = .zero
   	}
   	
   	convenience init(charArray: [Character]){
	   self.init()
	   for c in charArray {
		   let k = KeyboardKey(char: c)
		   self.keys.append(k)	
	   }  	
   	}   	
   	convenience init(charString: String){
	   self.init()
        for c in charString.characters {
		   let k = KeyboardKey(char: c)
		   self.keys.append(k)	
	   }  	
   	}
   	
    func addFirstKey(_ key: KeyboardKey) {
       self.keys.insert(key,at: 0);
    }
   	
   	func addLastKey(_ key: KeyboardKey) {
       self.keys.append(key);
    }
   	
   	//================================================
   	//
   	var frame:CGRect 
   	
   	
 } //end of class

class KeyboardPage {
 
   	//================================================
   	// Data   	
   	var rows: [KeyboardRow]
   	//================================================
   	// Init    	   
    
   	init(_ keyboardRows:[KeyboardRow]){
    	self.rows = keyboardRows
    	
    }
        
   	//================================================
   	
 } //end of class

class KeyboardDefinition {
 
   	//================================================
   	// Data
   	var pages: [KeyboardPage]
    
    //================================================
   	// Init      	 	       
   	init(_ keyboardPages:[KeyboardPage]){
    	self.pages = keyboardPages
    	
    }
        
   	//================================================
 } //end of class
 
 
 func defaultKeyboard() -> KeyboardDefinition {
 	
 	//-----------------------------------------------------
 	// Special Keys
 	 	 	
 	let backspaceKey = KeyboardKey(.Backspace);
 	 	
 	let pageChangeUpperKey = KeyboardKey(.PageChangeUpper)
    pageChangeUpperKey.label = "ABC"   
    pageChangeUpperKey.width = 2
    
    let pageChangeLowerKey = KeyboardKey(.PageChangeLower)
    pageChangeLowerKey.label = "abc"
    pageChangeLowerKey.width = 2
 	
    let pageChangeNumberKey = KeyboardKey(.PageChangeNumber)
    pageChangeNumberKey.label = "123"   
    pageChangeNumberKey.width = 2
    
    let pageChangeSymbolKey = KeyboardKey(.PageChangeSymbol)
    pageChangeSymbolKey.label = "#+="   
    pageChangeSymbolKey.width = 3
    
    let keyboardChangeKey = KeyboardKey(.KeyboardChange)
    keyboardChangeKey.label = "Next"   
    keyboardChangeKey.width = 2
    
    let settingsKey = KeyboardKey(.Settings)
    settingsKey.label = "Settings"   
    settingsKey.width = 1
    
    let spaceKey = KeyboardKey(.Space)
    spaceKey.label = "Space"
    spaceKey.output = " "
    spaceKey.width = 3
    
    let returnKey = KeyboardKey(.Return)
    returnKey.label = "Return"
    returnKey.output = "\n"
    returnKey.width = 1
    
 	//-----------------------------------------------------
 	// Uppercase Page
 	let upLetterPageR0 = KeyboardRow(charString: "QWERTYUIOP")
 	let upLetterPageR1 = KeyboardRow(charString: "ASDFGHJKL")
 	let upLetterPageR2 = KeyboardRow(charString: "ZXCVBNM")
 	upLetterPageR2.addFirstKey(pageChangeLowerKey) 
 	upLetterPageR2.addLastKey(backspaceKey)
 	
 	let upLetterPageR3 = KeyboardRow()
    upLetterPageR3.addLastKey(pageChangeNumberKey);
    upLetterPageR3.addLastKey(keyboardChangeKey);
    upLetterPageR3.addLastKey(settingsKey);
    upLetterPageR3.addLastKey(spaceKey);
    upLetterPageR3.addLastKey(returnKey);
    
    let uppercasePage = KeyboardPage([upLetterPageR0,upLetterPageR1,upLetterPageR2,upLetterPageR3])
          
    //-----------------------------------------------------
 	// Lowercase Page
 	let lowerLetterPageR0 = KeyboardRow(charString: "qwertyuiop")
 	let lowerLetterPageR1 = KeyboardRow(charString: "asdfghjkl")
 	let lowerLetterPageR2 = KeyboardRow(charString: "zxcvbnm")
 	lowerLetterPageR2.addFirstKey(pageChangeUpperKey) 
 	lowerLetterPageR2.addLastKey(backspaceKey)
    
    let lowerLetterPageR3 = KeyboardRow()
    lowerLetterPageR3.addLastKey(pageChangeNumberKey);
    lowerLetterPageR3.addLastKey(keyboardChangeKey);
    lowerLetterPageR3.addLastKey(settingsKey);
    lowerLetterPageR3.addLastKey(spaceKey);
    lowerLetterPageR3.addLastKey(returnKey);
    
 	let lowercasePage = KeyboardPage([lowerLetterPageR0,lowerLetterPageR1,lowerLetterPageR2,lowerLetterPageR3])
    //-----------------------------------------------------
 	// Number Page 
    let numberPageR0 = KeyboardRow(charString: "1234567890")
    let numberPageR1 = KeyboardRow(charArray: ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""])
    let numberPageR2 = KeyboardRow(charArray: [".", ",", "?", "!", "'"])
    numberPageR2.addFirstKey(pageChangeSymbolKey) 
 	numberPageR2.addLastKey(backspaceKey)
    
    let numberSymbolPageR3 = KeyboardRow()
    numberSymbolPageR3.addLastKey(pageChangeUpperKey)
    numberSymbolPageR3.addLastKey(keyboardChangeKey)
    numberSymbolPageR3.addLastKey(settingsKey)
    numberSymbolPageR3.addLastKey(spaceKey)
    numberSymbolPageR3.addLastKey(returnKey)
     
    let numberPage = KeyboardPage([numberPageR0,numberPageR1,numberPageR2,numberSymbolPageR3])
    //-----------------------------------------------------
 	// Symbol Page
    let symbolPageR0 = KeyboardRow(charArray: ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="])
    let symbolPageR1 = KeyboardRow(charArray: ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"])
    let symbolPageR2 = KeyboardRow(charArray: [".", ",", "?", "!", "'"])
    symbolPageR2.addFirstKey(pageChangeNumberKey)
    symbolPageR2.addLastKey(backspaceKey)
    
    let symbolPage = KeyboardPage([symbolPageR0,symbolPageR1,symbolPageR2,numberSymbolPageR3])    
    //-----------------------------------------------------
 	// 
    let  defaultKeyboard = KeyboardDefinition([uppercasePage,lowercasePage,numberPage,symbolPage])
    return defaultKeyboard
    
} // end of func


 
 
