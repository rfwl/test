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
    // Cell View : cell could have two views for the mainCell of a Key, one for surface and another for PopUp.
    var textView:UIView? = nil
    var imageView:UIImageView? = nil
    
    var cellView : UIView {
    	get {
    		return self.imageView ?? textView!
    	}
    }
        
    func buildCellViews(){
        self.textView = buildTextView()
        self.imageView = buildImageView()
    }
    
    var textView_PopUp:UIView? = nil
    var imageView_PopUp:UIImageView? = nil
    
    var cellView_PopUp : UIView {
        get {
            return self.imageView_PopUp ?? textView_PopUp!
        }
    }
    
    func buildCellViews_PopUp(){
        self.textView_PopUp = buildTextView()
        self.imageView_PopUp = buildImageView()
    }
    
    private func buildTextView() -> UILabel? {
        // FWL: Removed the nex two line to Ensure there is a view anyway
        //guard let txt = self.text else {return nil}
        //guard txt.count > 0 else {return nil}
        var txt = ""
        if let txt1 = self.text {
            txt = txt1
        }
        let lbl:UILabel = UILabel()
        lbl.textAlignment = NSTextAlignment.center
        lbl.baselineAdjustment = UIBaselineAdjustment.alignCenters
        lbl.font = lbl.font.withSize(self.fontSize)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = CGFloat(0.1)
        lbl.isUserInteractionEnabled = false
        lbl.numberOfLines = 1
        lbl.text = txt
        lbl.backgroundColor = UIColor.brown
        return lbl
    }
    private func buildImageView() -> UIImageView? {
        guard let imgName = self.image else { return nil }
        guard let img = ImageLibrary.buildUIImage(imgName) else { return nil }
        let iv:UIImageView = UIImageView(image: img) //UIImageView is said to be fast
        iv.contentMode = UIViewContentMode.scaleAspectFit
        iv.backgroundColor = UIColor.brown
        return iv
    }
   

    //======================================================
    
} // end of class

