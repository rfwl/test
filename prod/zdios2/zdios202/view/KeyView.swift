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
        self.clipsToBounds = false
        
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
                mainCell.drawInView(self,frame: self.bounds)
            }
        } // end of if let ky = self.keyDefinition
    } //end of func
    
    
    //override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    //    return true // self.bounds.contains(point)
    //}
  
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
                        mainCell.addToView_Text(self, frame: self.bounds)
                    } else if mainCell.labelingType == .Icon {
                        mainCell.addToView_Image(self, frame: self.bounds)
                    }
                }
                self.setNeedsDisplay()
            }
        }
    }
    
   
    //=====================================================================
    // Operations
    func addHighlight(){
        
    }
    
    func removeHighlight() {
        
    }
    
  
    //=====================================================================
    // Transient Properties
    var popUpFrame:CGRect = CGRect.zero // Ghe rect is defined in pop up container view
    
    
    
    //=====================================================================
    //
    
    //=====================================================================
    //
    
    //=====================================================================
    //
} //end of class
/*
 
 
 //-------------------------------------------------------------
 if let rt = self.popUpRect {
 let ctx = UIGraphicsGetCurrentContext()
 ctx?.saveGState()
 ky.drawPopUpPath(rt)
 ctx?.restoreGState()
 }
 
 var popUpRect : CGRect?
 func showPopUp(){
 if let ky = self.keyDefinition {
 popUpRect = ky.calculatePopUpRect(CGFloat(20), height: CGFloat(10))
 self.setNeedsDisplay()
 } // end of if let ky = self.keyDefinition
 }
 func hidePopUp(){
 popUpRect = nil
 self.setNeedsDisplay()
 }
 
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


