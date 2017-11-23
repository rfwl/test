import Foundation
import UIKit

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
        //for c in charString.characters {
        //    let k = KeyboardKey(String(c))
        //    self.keyArray.append(k)
        //}
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
            key.frame.size.width = (CGFloat(key.widthInRowUnit) + CGFloat((rowWidthInUnit-1)) * self.gap) * oneUnitWidth
            xOffset += key.frame.width + self.gap * oneUnitWidth
        }
    }

    //================================================
    //
    
} //end of class


