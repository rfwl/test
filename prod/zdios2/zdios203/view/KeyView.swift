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
    // overrides
   
  
    //=====================================================================
    // KeyDefinition
    var keyDefinition:KeyboardKey? = nil {
        didSet {
            /*if let ky = self.keyDefinition {
                if ky.hasSecondaryCells {
                    // Key has 2nd cell
                    let cell1 = ky.keyCellArray[0]
                    let cell2 = ky.keyCellArray[1]
                    ky.calculateMainCellFrame()
                    ky.calculateSecondaryCellFrame()
                    cell1.addToView(self, frame: ky.mainCellFrame)
                    cell2.addToView(self, frame: ky.secondaryCellFrame)
                    
                } else {
                    // Key has no secondary cell
                    let mainCell = ky.getMainCell()
                    mainCell.addToView(self, frame: self.bounds)
                }
                self.setNeedsDisplay()
            }*/
        }
    }
    
   
    //=====================================================================
    // Operations
    func addHighlight(){
        
    }
    
    func removeHighlight() {
        
    }
   
    //======================================================
    //
    var keyView:KeyView?
    var currentMainCellIndex : Int = 0 
    var currentSecondaryCellIndex : Int = 0
    
    func addCurrentCellViews(){
    	addCellViews(mainCellIndex : currentMainCellIndex, secondaryCellIndex : currentSecondaryCellIndex)   
    }
        
    func addCellViews(mainCellIndex : Int, secondaryCellIndex : Int){    	 
        self.clearSubviews()
        if let keyDef = self.keyDefinition {
            //guard mainCellIndex<0 || mainCellIndex >= self.keyDefinition.mainCellArray.count else {return}
            let mcl = keyDef.mainCellArray[mainCellIndex]
            let mclV = mcl.cellView
            mclV.frame = keyDef.mainCellFrame
            self.addSubview(mclV)
            
            if keyDef.hasSecondaryCells {
                 //guard secondaryCellIndex<0 || secondaryCellIndex >= keyDef.secondaryCellArray.count else {return}
                 let scl = keyDef.secondaryCellArray?[secondaryCellIndex]
                 if let scl = scl {
                    let sclV = scl.cellView
                    self.addSubview(sclV)
                 }
            }
        }
    } //end of func
    //=====================================================================
    // Operations
    func getMainCellView() -> UIView? {
        if let keyDef = self.keyDefinition {
            let mcl = keyDef.mainCellArray[currentMainCellIndex]
            let mclV = mcl.cellView
            return mclV
        }
        return nil
    }
    
    func getMainCellView_PopUp() -> UIView? {
        if let keyDef = self.keyDefinition {
            let mcl = keyDef.mainCellArray[currentMainCellIndex]
            let mclV = mcl.cellView_PopUp
            return mclV
        }
        return nil
    }
    func changeMainCellView(){
    }
    
    func changeSecondaryCellView(){
    }
    //=====================================================================
    // Transient Properties
    var popUpFrame_MainCell:CGRect = CGRect.zero // the Rect is calculated in pop up container view
    var popUpFrame_SecondaryCells:CGRect = CGRect.zero
    var isLeftMostInPopUp:Bool = false
    var isRightMostInPopUp:Bool = false
   
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


