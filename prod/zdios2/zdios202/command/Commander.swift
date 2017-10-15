//
//  KeyboardCommander.swift
//  zdios202
//
//  Created by Wanlou Feng on 1/10/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import AVFoundation

class Commander {
    
    static var keyboardView:KeyboardView?
    static var popUpContainerView : PopUpContainerView?
    //===================================================
    // Report KeyView Touches
    
    static func reportTouchStatus(_ touchStatus:EnumTouchStatus, kv:KeyView, curLoc: CGPoint=CGPoint.zero, downLoc:CGPoint=CGPoint.zero ) {
        print( touchStatus.toString() )
       
    }
    
    static func reportTouchDownKeyView(_ keyView:KeyView?) {
        //print("Touch down " )
        let systemSoundID: SystemSoundID = 1104
        AudioServicesPlaySystemSound(systemSoundID)
        if let pucvw = popUpContainerView {
            if let kvw = keyView {
                pucvw.showPopUp(kvw)
            }
        }
    }
    static func reportTapKeyView(_ keyView:KeyView?) {
        //print("Tap " )
        if let pucvw = popUpContainerView {
                pucvw.hidePopUp()
        }
    }
    static func reportLongPressKeyView(_ keyView:KeyView?) {
        //print("Long Press  ")
        let systemSoundID: SystemSoundID = 1057
        AudioServicesPlaySystemSound (systemSoundID)
    }
  
    //===================================================
    //
    
    
    
} // end of class


