class KeyCell : Codable {
    
    var name:String
    var text:String?
    var image:String?
    var widthInPopUpUnit:CGFloat = CGFloat(1)
    var fontSize:CGFloat = Settings.Main_Cell_Font_Size
    
    enum CodingKeys: String, CodingKey {
        case name 
        case text
        case image  
		case widthInPopUpUnit	
    }
    //======================================================
    //
    init(_ char:String) {
        self.name = char
        self.text = char
        self.image = nil
    }
    
    init(name:String, text:String) {
        self.name = name
        self.text = text
        self.image = nil
    }
    
    init(name:String, image:String) {
        self.name = name
        self.text = nil
        self.image = image
    }
    //======================================================
    //
	
    /*
    var textView:UIView {
        get {
            let lbl:UILabel = UILabel()
            lbl.textAlignment = NSTextAlignment.center
            lbl.baselineAdjustment = UIBaselineAdjustment.alignCenters
            lbl.font = lbl.font.withSize(self.fontSize)
            lbl.adjustsFontSizeToFitWidth = true
            lbl.minimumScaleFactor = CGFloat(0.1)
            lbl.isUserInteractionEnabled = false
            lbl.numberOfLines = 1
            lbl.text = self.text
            lbl.backgroundColor = UIColor.brown
            return lbl
        }
    }
    
    var imageView:UIImageView? {
        get {
            if let img = ImageLibrary.buildUIImage(self.image!) {
                let iv:UIImageView = UIImageView(image: img) //UIImageView is said to be fast
                iv.contentMode = UIViewContentMode.scaleAspectFit
                iv.backgroundColor = UIColor.brown
                return iv
            }
            return nil
        }
    }

    */
   

    //======================================================
    
} // end of class

