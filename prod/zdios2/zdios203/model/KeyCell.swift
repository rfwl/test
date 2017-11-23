import Foundation
import UIKit

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
	
  
    var textView:UIView? = nil
    var imageView:UIImageView? = nil
    
    var cellView : UIView {
    	get {
    		return self.imageView ?? textView!
    	}
    }
        
    func buildCellViews(){
        if let imgName = self.image {
        	if let img = ImageLibrary.buildUIImage(imgName) {
                let iv:UIImageView = UIImageView(image: img) //UIImageView is said to be fast
                iv.contentMode = UIViewContentMode.scaleAspectFit
                iv.backgroundColor = UIColor.brown
                self.textView = nil
                self.imageView = iv
            }
        } else { 
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
            self.textView = lbl
            self.imageView = nil            
        }
    } //end of func
    

   

    //======================================================
    
} // end of class

