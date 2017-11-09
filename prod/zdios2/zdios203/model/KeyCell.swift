//
//  KeyCell.swift
//  zdios203
//
//  Created by Wanlou Feng on 27/9/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit

class KeyCell : Codable {
    var name:String
    
    var text:String?
    var image:String?    
    var labelingType:EnumLabelingType
    
    var widthInPopUpUnit:CGFloat = CGFloat(1)
        
    enum EnumLabelingType {
        case Text
        case image
    }    
    
    //======================================================
    //
    init(_ char:String) {
        self.name = char
        self.text = char
        self.image = nil
        self.labelingType = EnumLabelingType.Text
        self.fontSize = Settings.KeyCell.Main_Cell_Font_Size
    }
    
    init(name:String, text:String) {
        self.name = name
        self.text = text
        self.image = nil
        self.labelingType = EnumLabelingType.Text
        self.fontSize = Settings.KeyCell.Main_Cell_Font_Size
    }
    
    init(name:String, image:String) {
        self.name = name
        self.text = nil
        self.image = image
        self.labelingType = EnumLabelingType.image
        self.fontSize = Settings.KeyCell.Main_Cell_Font_Size
    }
    //======================================================
    //
    func buildView()->UIView? {
        if self.labelingType == .Text {
            return self.buildView_Text()
        } else if self.labelingType == .image {
 			return self.buildView_image()
        }
        return nil
    }
    
    func buildView_Text()->UIView {
        let lbl:UILabel = UILabel()
        lbl.textAlignment = NSTextAlignment.center
        lbl.baselineAdjustment = UIBaselineAdjustment.alignCenters
        lbl.font = lbl.font.withSize(self.fontSize!)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = CGFloat(0.1)
        lbl.isUserInteractionEnabled = false
        lbl.numberOfLines = 1
        lbl.text = self.text
        lbl.backgroundColor = UIColor.brown
        return lbl
      
    }
    
    func buildView_image()->UIView? {
        if let img = ImageLibrary.buildUIImage(self.image!) {
            let iv:UIImageView = UIImageView(image: img) //UIImageView is said to be fast            
            iv.contentMode = UIViewContentMode.scaleAspectFit
            iv.backgroundColor = UIColor.brown
            return iv
        }
        return nil
    }    
    //======================================================
    // Transient Properties
    var keyCellView : UIView? 
    
    //======================================================
    
} // end of class
