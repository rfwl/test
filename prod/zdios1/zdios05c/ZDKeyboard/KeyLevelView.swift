//
//  KeyLevelView.swift
//  zdios05a
//
//  Created by Richard Feng on 3/12/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class KeyLevelView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    //===================================================================
    //
    var contentVC:KeyLevelViewController?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentVC?.reportTouches(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentVC?.reportTouches(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentVC?.reportTouches(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        contentVC?.reportTouches(touches!, with: event)
    }
    //===================================================================
    
    
} // end of class
