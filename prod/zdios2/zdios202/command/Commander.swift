//
//  KeyboardCommander.swift
//  zdios202
//
//  Created by Wanlou Feng on 1/10/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
class Commander {
    
    //===================================================
    // Report KeyView Touches
    static func reportTouchDownKeyView(_ keyView:KeyView?) {
        //print("Touch down " )
        if let kv = keyView {
            kv.showPopUp()
        }
    }
    static func reportTapKeyView(_ keyView:KeyView?) {
        //print("Tap " )
        if let kv = keyView {
            kv.hidePopUp()
        }
    }
    static func reportLongPressKeyView(_ keyView:KeyView?) {
        print("Long Press  ")
    }
  
    //===================================================
    //
    
    
    
} // end of class


