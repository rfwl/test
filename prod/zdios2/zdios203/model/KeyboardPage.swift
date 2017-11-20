
class KeyboardPage {
    
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
        self.rows = rows        
    }
    
    //================================================
    //
    var frame:CGRect = CGRect.zero // Set from KeyboardPage
    
    // Assign frame and height scale to each row  
    func layoutRows() { 
        if(self.frame.height==0) { return }        
        var totalSpecifiedHeight : CGFloat = 0
        for row in self.rows {
            totalSpecifiedHeight += row.paddingTop + row.height + row.paddingBottom
        }
        let heightScale = self.frame.height / totalSpecifiedHeight
        if(heightScale==0) {return}
        
        var yOffset:CGFloat = 0
        for row in page.rows {
            row.frame.origin.x = 0
            row.frame.size.width = self.frame.width
            row.frame.origin.y = yOffset + row.paddingTop * heightScale
            row.frame.size.height = row.height * heightScale
            row.heightScale: heightScale)
            yOffset += row.frame.height
        }
    }   
    //================================================
    
} //end of class
