//
//  KeyCell.swift
//  zdios202
//
//  Created by Wanlou Feng on 27/9/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit

class KeyCell {
    var output:String
    var labelingType:EnumLabelingType
    
    var text:String?
    var shape:String?
    var icon:String?
    
    enum EnumLabelingType {
        case Text
        case Shape
        case Icon
    }
    //======================================================
    //
    init(_ char:String) {
        self.output = char
        self.text = char
        self.shape = nil
        self.icon = nil
        self.labelingType = EnumLabelingType.Text
    }
    
    init(text:String, output:String) {
        self.output = output
        self.text = text
        self.shape = nil
        self.icon = nil
        self.labelingType = EnumLabelingType.Text
    }
    
    init(shape:String, output:String) {
        self.output = output
        self.text = nil
        self.shape = shape
        self.icon = nil
        self.labelingType = EnumLabelingType.Shape
    }
    
    init(icon:String, output:String) {
        self.output = output
        self.text = nil
        self.shape = nil
        self.icon = icon
        self.labelingType = EnumLabelingType.Icon
    }
    //======================================================
    //
    
    func drawInView(_ view:UIView, frame: CGRect) {
        if self.labelingType == .Shape {
            if let shapeName = self.shape {
                ShapeLibrary.drawShape(shapeName, bounds: frame, color: UIColor.blue)
            }
        }
    }
        
    func addToView(_ view :UIView, frame: CGRect) {
        if self.labelingType == .Text {
            self.addToView_Text(view, frame: frame)
        } else if self.labelingType == .Icon {
            self.addToView_Image(view, frame: frame)
        }
    }
    func addToView_Text(_ view:UIView, frame: CGRect) {
        let lbl:UILabel = UILabel()
        let labelInset: CGFloat = 2
        lbl.frame = CGRect(x: labelInset, y: labelInset, width: frame.width - labelInset * 2, height: frame.height - labelInset * 2)
        lbl.textAlignment = NSTextAlignment.center
        lbl.baselineAdjustment = UIBaselineAdjustment.alignCenters
        lbl.font = lbl.font.withSize(22)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = CGFloat(0.1)
        lbl.isUserInteractionEnabled = false
        lbl.numberOfLines = 1
        lbl.text = self.text
        view.addSubview(lbl)
    }
    
    func addToView_Image(_ view:UIView, frame: CGRect) {
        //FWL20171005: Using UIImageView as sub view.
        if let img = ImageLibrary.buildUIImage(self.icon!) {
            let iv:UIImageView = UIImageView(image: img) //UIImageView is said to be fast
            iv.frame = frame
            iv.contentMode = UIViewContentMode.scaleAspectFit
            view.addSubview(iv)
        }
    }
    
    func addToView_Image1(_ view:UIView, frame: CGRect) {
        //FWL20171005: From web post, only using img as patternImage to backgroundColor will not show the image out.
        // So have to draw and trhen to set the background color in pattern image.
        // This way using background color in pattern image is slower than using UIImageView as sub view.
        if let img = ImageLibrary.buildUIImage(self.icon!) {
            UIGraphicsBeginImageContext(view.frame.size)
            img.draw(in: frame)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            view.backgroundColor = UIColor(patternImage: image)
        }
    }
    //======================================================
    
} // end of class
