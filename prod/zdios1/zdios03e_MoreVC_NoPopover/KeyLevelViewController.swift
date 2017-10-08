//
//  KeyLevelViewController.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 12/10/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
//
import Foundation
import UIKit

class KeyLevelViewController: UIViewController {
   
    var commander:Commander?
    //=================================================================
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
        clearKeyLevels()        
    } // end of class

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //=================================================================
    // Draw Key Level
    let textRowHeight:CGFloat = 30
    var curCellStartX:CGFloat=0
    var curCellStartY:CGFloat=0
    
    func clearKeyLevels(){
        for v in self.view.subviews {v.removeFromSuperview()}
    }
    func drawKeyLevel(_ keyLevel:KeyLevel){
        curCellStartX=0
       	curCellStartY=0
        
        var minTextWidth:CGFloat = getStringWidth("zh") // ? font must be considerred here.
        let colCount:CGFloat=floor(self.view.bounds.size.width / minTextWidth) // floor is deinfed in Foundation lib.
        //let remainder:CGFloat=Int(self.view.bounds.size.width) % Int(minTextWidth)
        let remainder:CGFloat = 20.0
        minTextWidth+=remainder/colCount-1 // Distribute extra width to each cell in a row
        
        if let childArray = keyLevel.mChildren {   // Only draw children now, not favor children yet.
            for lvl in childArray {
                let lvlText:String=lvl.text
                //----------------------------------------------------------------------------
                // Calculate real width used in drawing
                var txtWidthActual:CGFloat
                txtWidthActual = getStringWidth(lvlText)
                if 	txtWidthActual < minTextWidth {
                    txtWidthActual = minTextWidth
                }
                let drawnWidth:CGFloat = ceil(txtWidthActual/minTextWidth)*minTextWidth
                //----------------------------------------------------------------------------
                // Check if go to next row
                if curCellStartX+drawnWidth > self.view.bounds.size.width { // Goto next row
                    curCellStartX=0;
                    curCellStartY+=textRowHeight
                }
                
                let cellLeft:CGFloat = curCellStartX
                let cellTop:CGFloat = curCellStartY
                //----------------------------------------------------------------------------
                // Create and add a button for the child level
                let frm:CGRect = CGRect(x:cellLeft, y:cellTop, width:drawnWidth, height:textRowHeight)
                addKeyLevelButton(title:lvlText,frame:frm,keyLevel:lvl)
                
                //----------------------------------------------------------------------------
                // Record location and size back into the child key level
                lvl.x=curCellStartX
                lvl.y=curCellStartY
                lvl.height=textRowHeight
                lvl.width=drawnWidth
                curCellStartX+=drawnWidth
                //----------------------------------------------------------------------------
            }
        }else { // No child found, go back to the top
            clearKeyLevels()
            commander?.drawDefault()
        }
    } //end of func
    
    func getStringWidth (_ text: String) -> CGFloat{
        //let font = NSFont.userFontOfSize(NSFont.systemFontSize())
        //let attributes = NSDictionary(object: font!, forKey:NSFontAttributeName)
        ///let sizeOfText = text.sizeWithAttributes((attributes as! [String : AnyObject]))
        //return sizeOfText.width
        
        return CGFloat(25 * text.characters.count)
    }
    //=================================================================
    // Add Button
    private func addKeyLevelButton(title: String, frame:CGRect, keyLevel:KeyLevel) {
        let lvlButton = KeyLevelButton(frame: frame)
        lvlButton.parentKeyLevel = keyLevel
       	lvlButton.setTitle(title, for: .normal)
        lvlButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        self.view.addSubview(lvlButton)
    }
    
    func didTapButton(sender: AnyObject?) {
        
        let button = sender as! KeyLevelButton
        //let title = button.title(for:.normal)
        //let proxy = textDocumentProxy as UITextDocumentProxy
        //proxy.insertText(title!)
        //txtField.text! += title!
        let klvl = button.parentKeyLevel
        clearKeyLevels()
        drawKeyLevel(klvl)
    }
    
    //=================================================================

} //end of class

