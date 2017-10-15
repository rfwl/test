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
        //print( touchStatus.toString() )
        switch touchStatus {
        case .Down: onTouch_Down(kv)
        case .DownHold: onTouch_DownHold(kv)
        case .DownHoldMove: onTouch_DownHoldMove(kv)
        case .DownHoldMoveUp: onTouch_DownHoldMoveUp(kv)
        case .DownUp: onTouch_DownUp(kv)
        case .DownHoldUp: onTouch_DownHoldUp(kv)
        default: break
            
        }
        
       
    }
    //===================================================
    //
    static func onTouch_Down(_ keyView:KeyView?) {
        let systemSoundID: SystemSoundID = 1104
        AudioServicesPlaySystemSound(systemSoundID)
        if let pucvw = popUpContainerView {
            if let kvw = keyView {
                pucvw.showPopUp_MainCell(kvw)
            }
        }
    }
    static func onTouch_DownHold(_ keyView:KeyView?) {
        if let pucvw = popUpContainerView {
            if let kvw = keyView {
                pucvw.showPopUp_SecondaryCells(kvw)
            }
        }
    }
    static func onTouch_DownUp(_ keyView:KeyView?) {
        if let pucvw = popUpContainerView {
                pucvw.hidePopUp()
        }
    }
    static func onTouch_DownHoldUp(_ keyView:KeyView?) {
        let systemSoundID: SystemSoundID = 1057
        AudioServicesPlaySystemSound (systemSoundID)
    }
    static func onTouch_DownHoldMove(_ keyView:KeyView?) {
    
    }
    static func onTouch_DownHoldMoveUp(_ keyView:KeyView?) {
    
    }
    //===================================================
    //
    
    
    
} // end of class


