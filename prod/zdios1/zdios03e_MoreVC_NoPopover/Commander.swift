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
    var mainVC:ViewController?
    var toolbarVC:ToolbarViewController?
    var contentVC:KeyLevelViewController?
    
    //===================================================
    // Open/close popovers
    func openCharacterPopoverView() {
    	mainVC?.openCharacterPopoverView()
    }
    func closeCharacterPopoverView() {
    	mainVC?.closeCharacterPopoverView()
    }
    func openHanziPopoverView() {
    	mainVC?.openHanziPopoverView()
    }
    func closeHanziPopoverView() {
    	mainVC?.closeHanziPopoverView()
    }
    func openSpecialKeyPopoverView() {
    	mainVC?.openSpecialKeyPopoverView()
    }
    func closeSpecialKeyPopoverView() {
    	mainVC?.closeSpecialKeyPopoverView()
    }
    func openIMEKeyPopoverView() {
    	mainVC?.openIMEKeyPopoverView()
    }
    func closeIMEKeyPopoverView() {
    	mainVC?.closeIMEKeyPopoverView()
    }    
    //===================================================
    // Draw Key levels
    func drawDefault(){
    	// content view will draw top key level by default all the time.  
    	contentVC?.drawKeyLevel(hanziDictionary.mTopKeyLevel)
    }   
    
    func drawNumberKeyLevel(){
    	contentVC?.drawKeyLevel(hanziDictionary.mNumberKeyLevel)
    }
    
    func drawAlphabetKeyLevel(){
    	contentVC?.drawKeyLevel(hanziDictionary.mAlphabetKeyLevel)
    }
    func drawSymbolKeyLevel(){
    	contentVC?.drawKeyLevel(hanziDictionary.mSymbolKeyLevel)
    }  	
    func drawMostUsedKeyLevel(){
    	contentVC?.drawKeyLevel(hanziDictionary.mMostUsedKeyLevel)
    }
    func drawRecentKeyLevel(){   
    	contentVC?.drawKeyLevel(hanziDictionary.mRecentKeyLevel)
    }
    // addRecent
    // clearRecent
    //===================================================
    // Output
    func outputKeyLevel(_ keyLevel:KeyLevel){
     
    	
    }
    //===================================================
    // button taps
    
    
    
    //=================================================== 
    
} //end of class
/*




Draw KeyLevel 


Output Hanzi Command
* Output the Hanzi to the text document 
* Added the output Hanzi into Recent-Used-Hanzis KeyLevel 
* Show child PHs.



Toolbar Character Key Commands

1> Open Numeric Keyboard > Tap on Toolbar Character Key
Show Special Numberic Keylevel into main keylevel view with scaled predefined locations

2> Show Toolbar Character Popover Menu > Touch down Toolbar Numberic Key

2.1> Open Numeric Keyboard > Touch-up on Toolbar Numberic Menu Item
Show Special Numberic Keylevel into main keylevel view with scaled predefined locations

2.2> Open Alphabet Keyboard > Touch-up on Toolbar Alphabet Menu Item
Show Special Alphabet Keylevel into main keylevel view with scaled predefined locations

2.3> Open Symbol Keyboard > Touch-up on Toolbar Symbol Menu Item
Show Special Symbol Keylevel into main keylevel view with scaled predefined locations

3> Close Toolbar Numeric Popover Menu > Touch-out Toolbar Numeric Key and Toolbar Numberic/Alphabet/Symbol Menu Item


Toolbar Hanzi Button Commands

1> Show PIs > Tap on Toolbar Hanzi Button
Show PIs

2> Show Toolbar Hanzi Button Popover Menu > Touch down Toolbar Hanzi Button

2.1> Show PIs > Touch-down on Toolbar Hanzi Menu Item
Show PIs

2.2> Most-Used Hanzis > Touch-up on Toolbar Most-Used Hanzis  Menu Item
Shwo Most-Used Hanzis from special Most-Used Hanzi KeyLevel

2.3> Recent-Used Hanzis > Touch-up on Toolbar MRecent-Used Hanzis  Menu Item
Show Recent-Used Hanzis from special Recent-Used Hanzi KeyLevel

3> Close Toolbar Hanzi Button Popover Menu > Touch-out Toolbar Hanzi Button and Toolbar Hanzi Button Mosr-Used/Recent Menu Item

Toolbar Special Key Commands

1> Output Enter Key > Tap on SpecialKey  Button
Output Enter key

2> Show Toolbar SpecialKey Popover Menu > Touch down Toolbar SpecialKey Button

2.1> Output Enter Key > Touch-up on Toolbar SpecialKey Enter Menu Item
Output Enter key

2.2> Output Backspace Key > Touch-up on Toolbar SpecialKey Backspace Menu Item
Output Backspace key

2.3> Output Space Key > Touch-up on Toolbar SpecialKey Space Menu Item
Output Space key

2.4> Output Comma Key > Touch-up on Toolbar SpecialKey Comma Menu Item
Output Comma key

2.4> Output Period Key > Touch-up on Toolbar SpecialKey Period Menu Item
Output Period key

3> Close Toolbar Numeric Popover Menu > Touch-out Toolbar SpecialKey Button and Toolbar SpecialKey Enter/Backspace/Space/Comma/Period Menu Item



Toolbar IMEButton Commands

1> Close IME > Tap on Toolbar IME Button
Close IME

2> Show Toolbar IME Button Popover Menu > Touch down Toolbar IME Button

2.1> Close IME > Touch-up on Toolbar Close IME Menu Item
Close IME

2.2> Next IME > Touch-up on Toolbar Next IME Menu Item
Next IME

2.3> Prev IME > Touch-up on Toolbar Prev IME Menu Item
Prev IME

3> Close Toolbar IME Button Popover Menu > Touch-out Toolbar IME Button and Toolbar IMEButton Close/Next/Prev IME Menu Item


======================================


*/
