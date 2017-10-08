//
//  KeyboardKey.swift
//  zdios202
//
//  Created by Wanlou Feng on 1/10/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

//
//  AKeyView.swift
//  zdios201
//
//  Created by Wanlou Feng on 25/9/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit

class KeyView: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.cyan.cgColor
        self.isOpaque = false
        self.backgroundColor = UIColor.brown
        self.isUserInteractionEnabled = false
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //=====================================================================
    // ocerrides
    public override func draw(_ frame: CGRect) {
        if let ky = self.keyDefinition {
            if ky.hasSecondaryCell { return }
            let mainCell = ky.getMainCell()
            if mainCell.labelingType == .Shape {
                if let shapeName = mainCell.shape {
                    ShapeLibrary.drawShape(shapeName, bounds: frame, color: UIColor.blue)
                }
            } else if mainCell.labelingType == .Icon {
                
            } else {
                
            }
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true // self.bounds.contains(point)
    }
  
    //=====================================================================
    // KeyDefinition
    var keyDefinition:KeyboardKey? = nil {
        didSet {
            if let ky = self.keyDefinition {
                if ky.hasSecondaryCell {
                    // Key has 2nd cell
                } else {
                    // Key has no secondary cell
                    let mainCell = ky.getMainCell()
                    if mainCell.labelingType == .Text {
                        drawKeyCell_Text(keyCell: mainCell, bounds: self.bounds)
                    } else if mainCell.labelingType == .Icon {
                        drawKeyCell_Image(keyCell: mainCell, bounds: self.bounds)
                    }
                }
                self.setNeedsDisplay()
            }
        }
    }
    
    func drawKeyCell_Text(keyCell: KeyCell, bounds: CGRect) {
        let lbl:UILabel = UILabel()
        let labelInset: CGFloat = 2
        lbl.frame = CGRect(x: labelInset, y: labelInset, width: bounds.width - labelInset * 2, height: bounds.height - labelInset * 2)
        lbl.textAlignment = NSTextAlignment.center
        lbl.baselineAdjustment = UIBaselineAdjustment.alignCenters
        lbl.font = lbl.font.withSize(22)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = CGFloat(0.1)
        lbl.isUserInteractionEnabled = false
        lbl.numberOfLines = 1
        lbl.text = keyCell.text
        self.addSubview(lbl)
    }
    func drawKeyCell_Image(keyCell: KeyCell, bounds: CGRect) {
        //FWL20171005: Using UIImageView as sub view.
        if let img = ImageLibrary.buildUIImage(keyCell.icon!) {
            let iv:UIImageView = UIImageView(image: img) //UIImageView is said to be fast s
            iv.frame = self.bounds
            iv.contentMode = UIViewContentMode.scaleAspectFit
            self.addSubview(iv)
        }
    }
    func drawKeyCell_Image1(keyCell: KeyCell, bounds: CGRect) {
        //FWL20171005: From web post, only using img as patternImage to backgroundColor will not show the image out.
        // So have to draw and trhen to set the background color in pattern image.
        // This way using background color in pattern image is slower than using UIImageView as sub view.
        if let img = ImageLibrary.buildUIImage(keyCell.icon!) {
            UIGraphicsBeginImageContext(self.frame.size)
            img.draw(in: self.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            backgroundColor = UIColor(patternImage: image)
        }
    }
   
    //=====================================================================
    // Operations
    func addHighlight(){
        
    }
    
    func removeHighlight() {
        
    }
    
    //=====================================================================
    //
    
} //end of class
/*
 func addToolbarButton(_ frm:CGRect, title tl:String,name nm:String,img inm:String) {
 let btn:ToolbarButton = ToolbarButton(frame:frm,name:nm)
 //btn.mainVC = self.mainVC
 let ig : UIImage? = UIImage(named: "toolbar_icons/" + inm + "_key")
 let hig : UIImage? = UIImage(named: "toolbar_icons/highlight_" + inm + "_key")
 
 btn.setBackgroundImage(ig?.withRenderingMode(.alwaysOriginal), for: .normal)
 btn.setBackgroundImage(hig?.withRenderingMode(.alwaysOriginal), for: .highlighted)
 //btn.setTitle(tl, for: .normal)
 btn.addTarget(self, action: #selector(didTapToolbarButton), for: .touchUpInside)
 self.addSubview(btn)
 //return btn
 }
 
 class ToolbarButton: UIButton {
 
 var buttonName:String = ""
 init(frame: CGRect,name nm:String) {
 super.init(frame: frame)
 buttonName = nm
 } // end of func
 
 required init(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 //===================================================================
 
 } //end of class
 
 func didTapToolbarButton(sender: AnyObject?) {
 let button = sender as? ToolbarButton
 if button != nil {
 Commander.reportTapToolbarButton((button?.buttonName)!)
 }
 }
 
 var image: UIImageView? {
 willSet {
 let anImage = image
 anImage?.removeFromSuperview()
 }
 didSet {
 if let imageView = image {
 self.addSubview(imageView)
 imageView.contentMode = UIViewContentMode.ScaleAspectFit
 self.redrawImage()
 updateColors()
 }
 }
 }
 
 func redrawImage() {
 if let image = self.image {
 let imageSize = CGSizeMake(20, 20)
 let imageOrigin = CGPointMake(
 (self.bounds.width - imageSize.width) / CGFloat(2),
 (self.bounds.height - imageSize.height) / CGFloat(2))
 var imageFrame = CGRectZero
 imageFrame.origin = imageOrigin
 imageFrame.size = imageSize
 
 image.frame = imageFrame
 }
 }
 
 
 
 
 //    //btn.addTarget(self, action: #selector(didTapToolbarButton), for: .touchUpInside)
 //    func didTapToolbarButton(sender: AnyObject?) {
 //        if let button = sender as? ToolbarButton {
 //            Commander.reportTapToolbarButton((button?.buttonName)!)
 //        }
 //    }
 
 
 
 
 
 */


