//
//  ViewController.swift
//  TouchEventTest
//
//  Created by Richard Feng on 6/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var scrView: UIScrollView!
   
    @IBOutlet weak var bbb1: UIButton!
    
    @IBOutlet weak var bbb2: UIButton!
    @IBOutlet weak var tvMsg: UITextView!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    @IBAction func btn2dragEnter(_ sender: Any) {
        //tvMsg.text! += "Drag Enter _     "
    }
    
    @IBAction func btn2DragExit(_ sender: Any) {
        //tvMsg.text! += "Drag Exit _     "
    }
    
    let btn = ZDUIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btn1.addTarget(self, action: #selector(didTouchDown_btn1), for: .touchDown)
        btn1.addTarget(self, action: #selector(didTouchUpIn_btn1), for: .touchUpInside)
        btn1.addTarget(self, action: #selector(didTouchUpOut_btn1), for: .touchUpOutside)
        btn2.addTarget(self, action: #selector(didTouchDown_btn2), for: .touchDown)
        btn2.addTarget(self, action: #selector(didTouchUpIn_btn2), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(didTouchUpOut_btn2), for: .touchUpOutside)
        
        let frm = CGRect(x:100,y:20,width:100,height:30)
        
        btn.frame = frm
        btn.vc = self
        btn.backgroundColor = UIColor.red
        btn.tv = tvMsg
        btn.mvw = self.view
        self.view.addSubview(btn)
        
        
        let frm1 = CGRect(x:100,y:20,width:100,height:30)
        lbl1.frame = frm1
        //lbl1.layer.borderColor = UIColor.blueColor
        
        let frm2 = CGRect(x:100,y:220,width:100,height:30)
        lbl2.frame = frm2
        //lbl2.layer.borderColor = CGColor(   (UIColor.blueColor)
        scrView.contentSize = CGSize(width:320, height:400)

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Actions
    
    func didTouchDown_btn1(sender: AnyObject?) {
        //tvMsg.text! += "Down btn1    "
    }
    
    func didTouchUpIn_btn1(sender: AnyObject?) {
        //tvMsg.text! += "UpIn btn1    "
    }
    
    func didTouchUpOut_btn1(sender: AnyObject?) {
        //tvMsg.text! += "UpOut btn1    "
    }
    
    func didTouchDown_btn2(sender: AnyObject?) {
        ///tvMsg.text! += "Down btn2    "
    }
    
    func didTouchUpIn_btn2(sender: AnyObject?) {
        ///tvMsg.text! += "UpIn btn2    "
    }
    
    func didTouchUpOut_btn2(sender: AnyObject?) {
        //tvMsg.text! += "UpOut btn2    "
    }
    //==================================================== Hit Test
    
    func hitTest(_ point:CGPoint, with:UIEvent) -> UIView? {
        if !self.view.isUserInteractionEnabled { return nil}
        if !self.view.point(inside: point,with:with) { return nil}
        //let subviews:[UIView] = self.view.subviews
        //let subviewsCount:Int = subviews.count
        for i in (0..<self.view.subviews.count).reversed() {
            let subview:UIView? = self.view.subviews[i]
            let ptInSubview = self.view.convert(point, to: subview)
            let foundSubview:UIView? = subview?.hitTest(ptInSubview,with:with)
            if let found = foundSubview {
                return found
            }
        }
        return self.view
    } // end of func
    
    //====================================================
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //tvMsg?.text! += "Begin   "
        findSubview(touches,with: event,prefix:"B")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //tvMsg?.text! += "Moved   "
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //tvMsg?.text! += "End   "
        findSubview(touches,with: event,prefix:"E")
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        // Don't forget to add "?" after Set<UITouch>
        //tvMsg?.text! += "Cancelled   "
        findSubview(touches!,with: event,prefix:"C")
        
        
        
        
        
        //UITouch *touch = [[event allTouches] anyObject];
        //CGPoint location = [touch locationInView:touch.view];
    }
    func findSubview(_ touches: Set<UITouch>, with event: UIEvent?,prefix pre:String) {
        //tvMsg?.text! += "Begin   "
        let touch = touches.first
        let location = touch?.location(in: self.view) //touch?.view)
        let found:UIView? = hitTest(location!,with:event!)
        if found == btn1 {
            tvMsg?.text! += pre + "btn1   "
        } else if found == btn2 {
            tvMsg?.text! += pre + "btn2   "
        } else if found == btn {
            tvMsg?.text! += pre + "btn   "
        } else if found == tvMsg {
            tvMsg?.text! += pre + "tvMsg   "
        } else {
            tvMsg?.text! += pre + "MainD    "
        }
    }

    //====================================================

} //end of class
/*
 NSUInteger subviewsCount = [subviews count];
 
 for (int i = 1; i <= subviewsCount; ++i) {
 UIView *subview = [subviews objectAtIndex:subviewsCount - i];
 
 // Get the point in the subviews space.
 CGPoint pointInSubview = [self convertPoint:p toView:subview];
 
 UIView *result = [subview hitTest:pointInSubview withEvent:event];
 
 if (result)
 return result;
 }
 
 return self;
 }
 */


