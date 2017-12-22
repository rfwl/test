import Foundation
import UIKit

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

    // Assign frame and height scale to each row  
    func layoutRows() { 
        if(self.frame.height==0) { return }        
        var totalSpecifiedHeight : CGFloat = 0
        for row in self.rowArray {
            totalSpecifiedHeight += row.height //row.paddingTop + row.height + row.paddingBottom
        }
        let heightScale = self.frame.height / totalSpecifiedHeight
        if(heightScale==0) {return}
        
        var yOffset:CGFloat = 0
        for row in self.rowArray {
            row.frame.origin.x = 0
            row.frame.size.width = self.frame.width
            row.frame.origin.y = yOffset //+ row.paddingTop * heightScale
            row.frame.size.height = row.height * heightScale
            row.heightScale = heightScale
            yOffset += row.frame.height
        }
    } 

    //================================================
    
} //end of class

