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
    
    static func reportTouchStatus(_ touchStatus:EnumTouchStatus, kv:KeyView,  downLoc:CGPoint=CGPoint.zero, curLoc: CGPoint=CGPoint.zero ) {
        //print( touchStatus.toString() )
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


