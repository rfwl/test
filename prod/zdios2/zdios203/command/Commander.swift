//
//  KeyboardCommander.swift
//  zdios202
//
//  Created by Wanlou Feng on 1/10/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension UIView {
    func clearSubviews() {
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
    }
}

class Commander {
    //===================================================
    // Workers    
    static var keyboardView:KeyboardView?
    static var popUpContainerView : PopUpContainerView?
    
    //===================================================
    // Start-up
    static func startUp(){
        let bldr = KeyboardDefinitionJsonBuilder()
        let strKBD = bldr.buildDefaultKeyboard()
        
        do {
            let kbdDef = try JSONDecoder().decode(KeyboardDefinition.self, from: strKBD.data(using: .utf8)! )
            // Load the keyboard definition onto the keyboard view.
            keyboardView?.keyboardDefinition = kbdDef
        } catch let jsonErr {
            print("Error serializing json", jsonErr)
        }
        
    } //end of func
    
    /*static func startUp1(){
    	// Read in the keyboard definition file into string
   	    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
		let localUrl = documentDirectory?.appendingPathComponent("DefaultKeyboardDefinition.json")
		if FileManager.default.fileExists(atPath: localUrl.path){
    	if let fileContents = NSData(contentsOfFile: localUrl.path) {
        	guard let data = fileContents as Data else {return}
        	do {
        	
        		// Decode into Keyboard Definition object.
            	let kbdDef =  try JSONDecoder().decode(KeyboardDefinition.self, from: data)
            	// Load the keyboard definition onto the keyboard view.            	
            	keyboardView.keyboardDefinition = kbdDef
            	
	        } catch let jsonErr {
	           	print("Error serializing json", jsonErr)
	        }
    	}    
        }
    } //end of func
    */
    //===================================================
    // Report KeyView Touches
    
    static func reportTouchStatus(_ touchStatus:EnumTouchStatus, kv:KeyView,  downLoc:CGPoint=CGPoint.zero, curLoc: CGPoint=CGPoint.zero ) {
        print( touchStatus.toString() )
        switch touchStatus {
        case .Down: onTouch_Down(kv,downLoc:downLoc)
        case .DownHold: onTouch_DownHold(kv,downLoc:downLoc)
        case .DownHoldMove: onTouch_DownHoldMove(kv, moveX: curLoc.x, downX: downLoc.x)
        case .DownHoldMoveUp: onTouch_DownHoldMoveUp(kv)
        case .DownUp: onTouch_DownUp(kv)
        case .DownHoldUp: onTouch_DownHoldUp(kv)
        default: break
            
        }
        
       
    }
    //===================================================
    //
    static func onTouch_Down(_ keyView:KeyView?, downLoc:CGPoint=CGPoint.zero) {
        let systemSoundID: SystemSoundID = 1104
        AudioServicesPlaySystemSound(systemSoundID)
        if let pucvw = popUpContainerView {
            if let kvw = keyView {
                pucvw.showPopUp_MainCell(kvw)
            }
        }
    }
    static func onTouch_DownHold(_ keyView:KeyView?, downLoc:CGPoint=CGPoint.zero) {
        if let pucvw = popUpContainerView {
            if let kvw = keyView {
                pucvw.showPopUp_SecondaryCells(kvw,touchDownX: downLoc.x )
                pucvw.highlightCellView(kvw,moveX: downLoc.x, downX: downLoc.x )
            }
        }
    }
    static func onTouch_DownUp(_ keyView:KeyView?) {
        if let pucvw = popUpContainerView {
                pucvw.hidePopUp()
                pucvw.clearSubviews()
        }
    }
    static func onTouch_DownHoldUp(_ keyView:KeyView?) {
        let systemSoundID: SystemSoundID = 1057
        AudioServicesPlaySystemSound (systemSoundID)
        if let pucvw = popUpContainerView {
            pucvw.hidePopUp()
            pucvw.clearSubviews()
        }
    }
    static func onTouch_DownHoldMove(_ keyView:KeyView?, moveX: CGFloat, downX: CGFloat ) {
        if let pucvw = popUpContainerView {
            if let kvw = keyView {
                pucvw.highlightCellView(kvw,moveX: moveX, downX: downX )
            }
        }
    }
    static func onTouch_DownHoldMoveUp(_ keyView:KeyView?) {
        if let pucvw = popUpContainerView {
            pucvw.hidePopUp()
            pucvw.clearSubviews()
        }
    }
    //===================================================
    //
    
    
    
} // end of class


