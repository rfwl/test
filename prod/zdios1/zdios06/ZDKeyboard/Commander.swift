//
//  Commader.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 4/12/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
//

import UIKit

class Commander: NSObject {
    
    let hanziDictionary:ZDHanziDictionary
    override init(){
        hanziDictionary = ZDHanziDictionary()
    }    
    //===================================================
    // Data Members
    var mainVC:KeyboardViewController?
    var contentVC:KeyLevelViewController?
    var textDocumentProxy : UITextDocumentProxy?   
    //===================================================
    // Reports      
    func reportTap_ToolbarButton(_ name:String){
       
       if name == "CharacterButton" { drawKeyLevelChildren(hanziDictionary.mCharacterKeyLevel); return}
       else if name == "MostUsedHanziButton" {
        contentVC?.isRenderingMUHanzis = true
        drawKeyLevelChildren(hanziDictionary.mMostUsedKeyLevel)
        contentVC?.isRenderingMUHanzis = false
        return
       }
       else if name == "HanziButton"  { drawKeyLevelChildren(hanziDictionary.mTopKeyLevel); return}
       
       else if name == "SpaceKeyButton"  {  outputKeyCode(" "); return} //#20
       else if name == "BackspaceKeyButton" {  outputBackspace(); return} //#08       
       else if name == "EnterKeyButton"  { outputKeyCode("\n"); return} //#0C 
       else if name == "CommaKeyButton" {  outputKeyCode(","); return} //
       else if name == "PeriodKeyButton"  {  outputKeyCode("."); return}
   
       else if name == "CloseIMEKeyButton"  {  mainVC?.closeIME(); return}
       else if name == "NextIMEKeyButton" {  mainVC?.gotoNextIMe(); return}       
       
    } 
    
    func reportTapKeyLevel(_ keyLevel:KeyLevel){
        //print(keyLevel.text)
        outputKeyLevel(keyLevel)
        if keyLevel.toStay {return}
        drawKeyLevelChildren(keyLevel)
    }
     
    func reportLongPressKeyLevel(_ keyLevel:KeyLevel){       
       //print(keyLevel.text)
       outputKeyLevel(keyLevel)
       if keyLevel.toStay {return}
       drawKeyLevelFavorChildren(keyLevel)       
    }
    
    func reportViewTransition() {
        if drawnKeyLevel == nil { return}
        if drawnFavors == true {
            drawKeyLevelFavorChildren(drawnKeyLevel!)
        } else {
            drawKeyLevelChildren(drawnKeyLevel!)
        }
        
    }
    func outputKeyCode(_ code:String){
        //dsp(code)
        let proxy = textDocumentProxy! as UITextDocumentProxy
        proxy.insertText(code)
    }
    
    func outputBackspace(){
        let proxy = textDocumentProxy! as UITextDocumentProxy
        proxy.deleteBackward()
    }

    //===================================================
    // Draw Key levels
    func drawDefault(){
    	drawKeyLevelChildren(hanziDictionary.mTopKeyLevel)
    }   
    //===================================================
    // Output
    func outputKeyLevel(_ keyLevel:KeyLevel){
        outputKeyLevelText(keyLevel)
        if keyLevel.toStay {return}
        drawKeyLevelChildren(keyLevel)
    }
    
    func outputKeyLevelText(_ keyLevel:KeyLevel){
        //dsp(keyLevel.text)
        if(keyLevel.level>1){
            outputKeyCode(keyLevel.text)
        }
    }
    
    var drawnFavors:Bool = false
    var drawnKeyLevel:KeyLevel?
    
    func drawKeyLevelChildren(_ keyLevel:KeyLevel){        
        if let chlds = keyLevel.mChildren {
            if chlds.count > 0 {
                drawnKeyLevel = keyLevel
                drawnFavors = false
                
                contentVC?.drawKeyLevelArray(chlds)
                return
            }
        }
        drawDefault()
    }    
    
    func drawKeyLevelFavorChildren(_ keyLevel:KeyLevel){        
        if let chlds = keyLevel.mFavorChildren {
            if chlds.count > 0 {
                drawnKeyLevel = keyLevel
                drawnFavors = true
                
                contentVC?.drawKeyLevelArray(chlds)
               return
            }
        }
        drawKeyLevelChildren(keyLevel)
    }
    
       //===================================================
    
} //end of class

/*


*/
