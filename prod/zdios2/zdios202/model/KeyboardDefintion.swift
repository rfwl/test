//
//  KeyboardDefintion.swift
//  zdios202
//
//  Created by Wanlou Feng on 30/9/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit

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
        addCharArray(charArray)
    }
    convenience init(charString: String){
        self.init()
        addCharString(charString)
    }
    
    convenience init(keys:[KeyboardKey]){
        self.init()
        self.keys = keys
    }
    
    func addCharArray(_ charArray: [Character]){
        for c in charArray {
            let k = KeyboardKey(String(c))
            self.keys.append(k)
        }
    }
    func addCharString(_ charString: String){
        for c in charString.characters {
            let k = KeyboardKey(String(c))
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
    
   
    
//    let keyUppercase = KeyboardKey("ABC", output: "VK_Uppercase", width: 2)
//    let keyLowercase = KeyboardKey("abc", output: "VK_Lowercase", width: 2)
//    let keyNumber = KeyboardKey("123", output: "VK_Numeric", width: 2)
//    let keySymbol = KeyboardKey("#+=", output: "VK_Symbol", width: 2)
//    let keyNext = KeyboardKey("NEXT", output: "VK_Next", width: 2)
//    //let keyClose = KeyboardKey("Close", output: "VK_Clos", width: 2)
//    let keySettings = KeyboardKey("Settings", output: "VK_Settings", width: 2)
//
//    let keyBackspace = KeyboardKey("Backspace", output: "VK_Backspace", width: 2)
//    let keySpace = KeyboardKey("Space", output: "VK_Space", width: 2)
//    let keyReturn = KeyboardKey("Return", output: "VK_Return", width: 2)
    //-----------------------------------------------------
    // Uppercase Page
    let upLetterPageR0 = KeyboardRow(charString: "QWERTYUIOP")
    let upLetterPageR1 = KeyboardRow(charString: "ASDFGHJKL")
    upLetterPageR1.addLastKey(KeyboardKey(shape: "Backspace", output: "VK_Backspace", width: 1))
    let upLetterPageR2 = KeyboardRow(charString: "ZXCVBNM")
    upLetterPageR2.addFirstKey(KeyboardKey("abc", output: "VK_Lowercase", width: 2))
    
    let upLetterPageR3 = KeyboardRow()
    upLetterPageR3.addLastKey(KeyboardKey("123", output: "VK_Numeric", width: 2));
    upLetterPageR3.addLastKey(KeyboardKey(shape: "NEXT", output: "VK_Next", width: 2));
    upLetterPageR3.addLastKey(KeyboardKey("Settings", output: "VK_Settings", width: 2));
    upLetterPageR3.addLastKey(KeyboardKey("Space", output: "VK_Space", width: 2));
    upLetterPageR3.addLastKey(KeyboardKey("Return", output: "VK_Return", width: 2));
    
    let uppercasePage = KeyboardPage([upLetterPageR0,upLetterPageR1,upLetterPageR2,upLetterPageR3])
    
    //-----------------------------------------------------
    // Lowercase Page
    let lowerLetterPageR0 = KeyboardRow(charString: "qwertyuiop")
    let lowerLetterPageR1 = KeyboardRow(charString: "asdfghjkl")
    lowerLetterPageR1.addLastKey(KeyboardKey(shape: "Backspace", output: "VK_Backspace", width: 1))
    let lowerLetterPageR2 = KeyboardRow(charString: "zxcvbnm")
    lowerLetterPageR2.addFirstKey(KeyboardKey("ABC", output: "VK_Uppercase", width: 2))
    
    let lowerLetterPageR3 = KeyboardRow()
    lowerLetterPageR3.addLastKey(KeyboardKey("123", output: "VK_Numeric", width: 2));
    lowerLetterPageR3.addLastKey(KeyboardKey(shape: "NEXT", output: "VK_Next", width: 2));
    lowerLetterPageR3.addLastKey(KeyboardKey("Settings", output: "VK_Settings", width: 2));
    lowerLetterPageR3.addLastKey(KeyboardKey(icon: "Space", output: "VK_Space", width: 2));
    lowerLetterPageR3.addLastKey(KeyboardKey(icon: "Return", output: "VK_Return", width: 2));
    
    let lowercasePage = KeyboardPage([lowerLetterPageR0,lowerLetterPageR1,lowerLetterPageR2,lowerLetterPageR3])
    //-----------------------------------------------------
    // Number Page
    let numberPageR0 = KeyboardRow(charString: "1234567890")
    let numberPageR1 = KeyboardRow(charArray: ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""])
    let numberPageR2 = KeyboardRow(charArray: [".", ",", "?", "!", "'"])
    numberPageR2.addFirstKey(KeyboardKey("abc", output: "VK_Lowercase", width: 2))
    numberPageR2.addLastKey(KeyboardKey(shape: "Backspace", output: "VK_Backspace", width: 1))
    
    let numberSymbolPageR3 = KeyboardRow()
    numberSymbolPageR3.addLastKey(KeyboardKey("ABC", output: "VK_Uppercase", width: 2))
    numberSymbolPageR3.addLastKey(KeyboardKey(shape: "NEXT", output: "VK_Next", width: 2));
    numberSymbolPageR3.addLastKey(KeyboardKey("Settings", output: "VK_Settings", width: 2));
    numberSymbolPageR3.addLastKey(KeyboardKey(icon: "Space", output: "VK_Space", width: 2));
    numberSymbolPageR3.addLastKey(KeyboardKey(icon: "Return", output: "VK_Return", width: 2));
    
    let numberPage = KeyboardPage([numberPageR0,numberPageR1,numberPageR2,numberSymbolPageR3])
    //-----------------------------------------------------
    // Symbol Page
    let symbolPageR0 = KeyboardRow(charArray: ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="])
    let symbolPageR1 = KeyboardRow(charArray: ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"])
    let symbolPageR2 = KeyboardRow(charArray: [".", ",", "?", "!", "'"])
    symbolPageR2.addFirstKey(KeyboardKey("#+=", output: "VK_Symbol", width: 2))
    symbolPageR2.addLastKey(KeyboardKey(shape: "Backspace", output: "VK_Backspace", width: 2))
    
    let symbolPageR3 = KeyboardRow()
    symbolPageR3.addLastKey(KeyboardKey("ABC", output: "VK_Uppercase", width: 2))
    symbolPageR3.addLastKey(KeyboardKey(shape: "NEXT", output: "VK_Next", width: 2));
    symbolPageR3.addLastKey(KeyboardKey("Settings", output: "VK_Settings", width: 2));
    symbolPageR3.addLastKey(KeyboardKey(icon: "Space", output: "VK_Space", width: 2));
    symbolPageR3.addLastKey(KeyboardKey(icon: "Return", output: "VK_Return", width: 2));
    
    
    
    let symbolPage = KeyboardPage([symbolPageR0,symbolPageR1,symbolPageR2,symbolPageR3])
    //-----------------------------------------------------
    //
  
    for ky:KeyboardKey in upLetterPageR0.keys {
        let kc1 = KeyCell("1")
        let kc2 = KeyCell("2")
        let kc3 = KeyCell("3")
        let kc4 = KeyCell("study")
        kc4.widthInPopUpUnit = 2
        let kc5 = KeyCell("t")
        kc5.widthInPopUpUnit = 3
        let kc6 = KeyCell("will")
        kc6.widthInPopUpUnit = 4
        ky.keyCellArray.append(kc1)
        ky.keyCellArray.append(kc2)
        ky.keyCellArray.append(kc3)
        ky.keyCellArray.append(kc4)
        ky.keyCellArray.append(kc5)
        ky.keyCellArray.append(kc6)
        
    }
    
    //-----------------------------------------------------
    //
    let  defaultKeyboard = KeyboardDefinition([uppercasePage,lowercasePage,numberPage,symbolPage])
    return defaultKeyboard
    
} // end of func




