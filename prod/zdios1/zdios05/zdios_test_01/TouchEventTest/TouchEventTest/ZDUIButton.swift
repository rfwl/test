//
//  ZDUIButton.swift
//  TouchEventTest
//
//  Created by Richard Feng on 6/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class ZDUIButton: UIButton {
    
    var tv:UITextView?
    var mvw:UIView?
    var vc:ViewController?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //tv?.text! += "ZDBegin   "
        //mvw?.touchesBegan(touches, with: event)
        vc?.findSubview(touches,with: event,prefix:"SB")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //tv?.text! += "Moved   "
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let touch = touches.first
        
        //tv?.text! += "ZDEnd   "
        //mvw?.touchesEnded(touches, with: event)
        vc?.findSubview(touches,with: event,prefix:"SE")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        // Don't forget to add "?" after Set<UITouch>
        //tv?.text! += "Cancelled   "
        vc?.findSubview(touches!,with: event,prefix:"SC")
    }
    
    
    
    
    
    

}
