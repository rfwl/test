//
//  KeyLevelView.swift
//  zdios05a
//
//  Created by Richard Feng on 3/12/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit
import AVFoundation

class KeyLevelView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //=================================================================
    // Operation - Draw Key Level Buttons
    //let KeyLevel_MinWidth : CGFloat = 50
    let xGap:CGFloat = 2
    let yGap:CGFloat = 2    
    var curCellStartX:CGFloat=0
    var curCellStartY:CGFloat=0
    var isRenderingMUHanzis:Bool = false;
    
    func drawKeyLevelArray(_ keyLevelArray:[KeyLevel]?){        

        clearKeyLevels()
        
        curCellStartX=xGap
       	curCellStartY=yGap
        
        let colCount:CGFloat=floor(self.bounds.size.width / Configuration.KeyLevel_MinWidth) // floor is defined in Foundation lib.
        let remainder:CGFloat=self.bounds.size.width.truncatingRemainder(dividingBy:Configuration.KeyLevel_MinWidth)
        let minTextWidth:CGFloat=Configuration.KeyLevel_MinWidth + remainder/colCount-1 // Distribute extra width to each cell in a row
        
        var requiredHeight:CGFloat = 0.0
        if let childArray = keyLevelArray  {   // Only draw children now, not favor children yet.
            for lvl in childArray {
                let lvlText:String=lvl.text
                //----------------------------------------------------------------------------
                // Calculate real width used in drawing
                var txtWidthActual:CGFloat
                txtWidthActual =  KeyLevelTextLayer.getWidthForString(lvlText) + 6
                if 	txtWidthActual < minTextWidth {
                    txtWidthActual = minTextWidth
                }
                let drawnWidth:CGFloat = ceil(txtWidthActual/minTextWidth)*minTextWidth
                //----------------------------------------------------------------------------
                // Check if go to next row
                if curCellStartX+drawnWidth > self.bounds.size.width { // Goto next row
                    curCellStartX=xGap
                    curCellStartY+=Configuration.KeyLevel_RowHeight+yGap
                }
                
                let cellLeft:CGFloat = curCellStartX
                let cellTop:CGFloat = curCellStartY
                //----------------------------------------------------------------------------
                // Create and add a button for the child level
                let frm:CGRect = CGRect(x:cellLeft, y:cellTop, width:drawnWidth, height:Configuration.KeyLevel_RowHeight)
                addKeyLevelButton(title:lvlText,frame:frm,keyLevel:lvl)
                
                //----------------------------------------------------------------------------
                // Record location and size back into the child key level
                lvl.x=curCellStartX
                lvl.y=curCellStartY
                lvl.height=Configuration.KeyLevel_RowHeight
                lvl.width=drawnWidth
                curCellStartX+=drawnWidth+xGap
                //----------------------------------------------------------------------------
                if requiredHeight < curCellStartY + Configuration.KeyLevel_RowHeight + yGap {
                    requiredHeight = curCellStartY + Configuration.KeyLevel_RowHeight + yGap
                }
            }
            let wid = self.frame.size.width
            self.contentSize = CGSize(width:wid,height:requiredHeight)

        }else { // No child found, just do nothing
            
        }
        
    } //end of func
    
    func clearKeyLevels(){
        curBkColor=bkColor1
        curPinyin=""
        self.setContentOffset(CGPoint(x: 0,y: -self.contentInset.top),animated: false)
        let sls:[CALayer] = self.layer.sublayers!
        for layer in sls{
            if layer is KeyLevelTextLayer {
                layer.removeFromSuperlayer()
            }
        }
    }        
    //==========================================================
    // Helper to Draw KeyLevel Buttons    
    let bkColor1:String=Configuration.KeyLevel_BackgroundColor_1_HexString
	let bkColor2:String=Configuration.KeyLevel_BackgroundColor_2_HexString
    var curBkColor:String=Configuration.KeyLevel_BackgroundColor_1_HexString
	var curPinyin:String="";
	
    func addKeyLevelButton(title: String, frame:CGRect, keyLevel:KeyLevel) {
        let lvlButton = KeyLevelTextLayer(frame: frame)        
        lvlButton.parentKeyLevel = keyLevel
        if keyLevel.level==2 {
            
            if let ppy = keyLevel.parentLevel {
                //print("For Py=\(ppy.text) Hz=\(title)")
                if curPinyin.isEmpty {
                    curPinyin=ppy.text
                } else if ppy.text != curPinyin {
                    
                    //print("Change Bk clr py=\(ppy.text) hz=\(keyLevel.text)")
                    if isRenderingMUHanzis == false {
                        changeBackgroundColor()
                    } else {
                        let s1 = getFirstChars(ppy.text,cnt: 1)
                        let s2 = getFirstChars(curPinyin,cnt: 1)
                        if s1 != s2 {
                            changeBackgroundColor()
                        }
                    }
                    curPinyin=ppy.text
                }
            }
        }
        
        lvlButton.backgroundColor = Utilities.hexStringToUIColor(self.curBkColor).cgColor
       	lvlButton.string=title
        self.layer.addSublayer(lvlButton)
    } // end of func
    
    func getFirstChars(_ str:String, cnt:Int ) -> Character {
        return str.characters.first!
        //return str[str.index(str.startIndex, offsetBy: cnt)]
    }
    func getParentPY(_ klvl:KeyLevel) -> KeyLevel? {
        if klvl.level<2 { return nil}
        else if klvl.level == 2 { return klvl.parentLevel }
        else if klvl.level == 3 {
            if let pklvl = klvl.parentLevel {
                return pklvl.parentLevel
            }
        }
        return nil
    } // end of func   
     
	func changeBackgroundColor()
	{
        if curBkColor==bkColor1 {
			curBkColor=bkColor2
        } else if curBkColor==bkColor2 {
			curBkColor=bkColor1
        }
	}
	
	
    //===================================================================
    // Event Handlers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reportTouches(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        reportTouches(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        reportTouches(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        reportTouches(touches!, with: event)
    }
    
    var downTouchLoc:CGPoint? 
    var downTouchTime:Date = Date()   
    var lastTouchLoc:CGPoint?   
    var touchedKeyLevelButton : KeyLevelTextLayer?

    func reportTouches(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let systemSoundID: SystemSoundID = 1104
        AudioServicesPlaySystemSound(systemSoundID)
        
        let touch = touches.first
        if touch?.phase == UITouchPhase.began {
           	//------------------------------------------- Touch Begin
           	downTouchLoc = touch?.location(in: self)
           	downTouchTime = Date()
           	lastTouchLoc = downTouchLoc
           	removeHighlightKeyLevelButton()
           	highlightPossibleKeyLevelButton(downTouchLoc!)
           	
        } else if touch?.phase == UITouchPhase.stationary { //case stationary: A finger is touching the surface but hasn't moved since the previous event.   
            
        } else if touch?.phase == UITouchPhase.moved {
            //------------------------------------------- Touch Move: highlight touched button
            let moveTouchLoc = touch?.location(in: self)
           	lastTouchLoc = moveTouchLoc
           	highlightPossibleKeyLevelButton(moveTouchLoc!)
        } else if touch?.phase == UITouchPhase.ended {
            //------------------------------------------- Touch Ended
            let endTouchLoc = touch?.location(in: self)
            let dist = max(abs((endTouchLoc?.x)! - (downTouchLoc?.x)!), abs((endTouchLoc?.y)! - (downTouchLoc?.y)!)) 
            if dist < 10 {
            	//-------------------------------------- A tap found.
                
        		if touchedKeyLevelButton == nil {return}
        		if let klvlBtn = touchedKeyLevelButton as KeyLevelTextLayer? {
                    
            		let klvl = klvlBtn.parentKeyLevel
            		let upTouchTime = Date()
            		let milliSecondsBetween = upTouchTime.timeIntervalSince(downTouchTime)
                    //UIDevice.current.playInputClick()
            		if milliSecondsBetween > 0.4 {
            			
                        // create a sound ID, in this case its the tweet sound.
                        let systemSoundID: SystemSoundID = 1057
                        // to play sound
                        AudioServicesPlaySystemSound (systemSoundID)
                        
                        //AudioServices.PlaySystemSound(1104);
                        //UIDevice.current.playInputClick() //not working in tests.
            			Commander.reportLongPressKeyLevel(klvl)
            		} else {
            			Commander.reportTapKeyLevel(klvl)
            		}
        		}
            }
            removeHighlightKeyLevelButton() 
        } else if touch?.phase == UITouchPhase.cancelled {
            //------------------------------------------- Touch Cancelled
            removeHighlightKeyLevelButton() 
        }
    } // end of func
    
   	func highlightPossibleKeyLevelButton(_ pt:CGPoint){
   		//let point = touch.location(in: sv)
        let pt1:CGPoint = self.convert(pt, to: nil)
        let newTouched = self.layer.hitTest(pt1)
		if let newTouchedButton = newTouched as? KeyLevelTextLayer {
			if  touchedKeyLevelButton != nil {touchedKeyLevelButton?.removeHighlight()}
			touchedKeyLevelButton = newTouchedButton
			touchedKeyLevelButton!.addHighlight()
		}
   	}
    
    
   	func removeHighlightKeyLevelButton(){
   		if  touchedKeyLevelButton != nil {
   			touchedKeyLevelButton!.removeHighlight()
   			touchedKeyLevelButton = nil
   		}
   	}
   	//===================================================================
	
    
    
} // end of class
/*
 
     var holdOnTouchedKeyLevelButton : KeyLevelTextLayer?
 
 //------------------------------------------- Hold-on Touch
 let holdOnTouchLoc = touch?.location(in: self)
 let dist1 = max(abs((holdOnTouchLoc?.x)! - (downTouchLoc?.x)!), abs((holdOnTouchLoc?.y)! - (downTouchLoc?.y)!))
 let holdOnTouchTime = Date()
 let milliSecondsBetween1 = holdOnTouchTime.timeIntervalSince(downTouchTime)
 
 if dist1 < 10 && milliSecondsBetween1 > 0.4 {
 redHighlightPossibleKeyLevelButton(holdOnTouchLoc!)
 }

 func redHighlightPossibleKeyLevelButton(_ pt:CGPoint){
 //let point = touch.location(in: sv)
 let pt1:CGPoint = self.convert(pt, to: nil)
 let newTouched = self.layer.hitTest(pt1)
 if let newTouchedButton = newTouched as? KeyLevelTextLayer {
 if  touchedKeyLevelButton != nil {touchedKeyLevelButton?.removeHighlight()}
 touchedKeyLevelButton = newTouchedButton
 touchedKeyLevelButton!.addRedHighlight()
 }
 }

 */

