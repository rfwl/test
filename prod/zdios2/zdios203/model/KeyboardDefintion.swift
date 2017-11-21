class KeyboardDefinition : Codable {
    
    //================================================
    // Data
    var name:String
    var text:String?  
    var pageArray: [KeyboardPage]
    
    //================================================
    // Init    
    init(_ pages:[KeyboardPage]){
		self.name = ""
		self.text = ""
		
        self.pageArray = pages        
    }
    
    //================================================
} //end of class

