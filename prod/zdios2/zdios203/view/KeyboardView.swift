
import UIKit

class KeyboardView: UIView {
    
    //=============================================================================
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //# UIViewContentMode: Options to specify how a view adjusts its content when its size changes. [ScaleToFill, redraw, top, topRight, ....]
        self.contentMode = UIViewContentMode.redraw
        self.isMultipleTouchEnabled = true
        self.isUserInteractionEnabled = true
        self.isOpaque = false
        Commander.keyboardView = self
        
        //prepareTapGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    //=============================================================================
    // Create, Add and Layout Key Views
    public var _keyboardDefinition : KeyboardDefinition?
    var keyboardDefinition : KeyboardDefinition {
        get {
            return _keyboardDefinition!
        }
        set {
            _keyboardDefinition = newValue
            self.buildKeyViews()
        }
    }
    
    //=============================================================================
    // Calculate and pass frames to and build view for all pages, all rows, up to all keys.
    func buildKeyViews(){
        
        for pg in keyboardDefinition.pageArray {
            pg.frame = self.bounds
            pg.layoutRows();
        	for row in pg.rowArray {
                row.layoutKeys()
            	 for ky in row.keyArray {
                    ky.pageFrame = pg.frame
                    ky.calculateCellFrames()
                    ky.buildCellViews()
                    ky.calculateCellFrames()
                    ky.buildPopUpBorderPaths()
                    
                    let kv = KeyView(frame:ky.frame)
                    kv.keyDefinition = ky
                    ky.keyView = kv
                    kv.addCurrentCellViews()
                    
            	 } // end of for ky
        	} // end of for row
        } // end of for pgs
        
    } // end of func
 
    
   
    //=============================================================================
    // Operations
    var drawnKeyboardPage : KeyboardPage?
    
    func drawPageAt(_ index:Int){
        guard index>=0 || index<keyboardDefinition.pageArray.count else { return }
        let pg = keyboardDefinition.pageArray[index]
        drawPage(pg)
    }
    
    func drawPage(_ page:KeyboardPage) {
        drawnKeyboardPage = page
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
        for row in page.rowArray {
            for ky in row.keyArray {
                if ky.keyView==nil {
                    let kv = KeyView(frame: ky.frame)
                    kv.keyDefinition = ky
                    ky.keyView = kv
                }
                self.addSubview(ky.keyView!)
            }
        }
    } //end of func
    
    
    //=============================================================================
    // GestureRecognisers are in conflict against the local reportTouches method.
    // Touch_Ended status cannot be reached anymore.
    func prepareTapGestureRecognizers() {
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector( onTap_Single))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTap)
        
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(onTap_Double))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(doubleTap)
        
        let tripleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(onTap_Triple))
        tripleTap.numberOfTapsRequired = 3
        tripleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tripleTap)
        
        

    } //end of func

    @objc func onTap_Single(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended){
            //print("Single Tapped")
        }
    }
    @objc func onTap_Double(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended){
            //print("Double Tapped")
        }
    }
    @objc func onTap_Triple(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended){
            //print("Triple Tapped")
        }
    }
    //=============================================================================
    // Touche Event Handlers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reportTouches(touches, with: event)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        reportTouches(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        reportTouches(touches, with: event)
    }
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        reportTouches(touches!, with: event)
    }
    //=============================================================================
    //
    var downTouchLoc:CGPoint?
    var downTouchTime:Date = Date()
    var lastTouchLoc:CGPoint?
    var touchedKeyView:KeyView?
    var currentTouchStatus : EnumTouchStatus = EnumTouchStatus.Null
    let holdThresholdInSeconds : Double = 0.4
    var anyNewTouchEvent:Bool = false
    
    func reportTouches(_ touches: Set<UITouch>, with event: UIEvent?) {
        anyNewTouchEvent = true
        let touch = touches.first
        if touch?.phase == UITouchPhase.began {
            //------------------------------------------- Touch Begin
            downTouchLoc = touch?.location(in: self)
            downTouchTime = Date()
            lastTouchLoc = downTouchLoc
            removeTouchedKeyView()
            findTouchedKeyView(downTouchLoc!)
            if let reallyTouched = touchedKeyView {
                //----------------------------------- A Down found.
                currentTouchStatus = EnumTouchStatus.Down
                Commander.reportTouchStatus(currentTouchStatus,kv:reallyTouched, downLoc: downTouchLoc!)
                Timer.scheduledTimer(withTimeInterval: holdThresholdInSeconds, repeats: false) { timer in
                    if self.anyNewTouchEvent {
                        let now = Date()
                        let secondsBetween = now.timeIntervalSince(self.downTouchTime)
                        if !secondsBetween.isLess(than: self.holdThresholdInSeconds ) {
                            if self.currentTouchStatus == EnumTouchStatus.Down {
                                //------------------------------- A Hold found.
                                self.currentTouchStatus = EnumTouchStatus.DownHold
                                Commander.reportTouchStatus(self.currentTouchStatus,kv:reallyTouched, downLoc: self.downTouchLoc!)
                            }
                        }
                    }
                    self.anyNewTouchEvent = false
                } // end of Timer.scheduledTimer
            }
        } else if touch?.phase == UITouchPhase.stationary {
            //------------------------------------------- Touch Stationary
            // A finger is touching the surface but hasn't moved since the previous event.
            // From tests, the next part cannot be reached. Timer is used for the same purpose in the TouchBegin part.
            if let reallyTouched = touchedKeyView {
                if currentTouchStatus == EnumTouchStatus.Down {
                    let now = Date()
                    let secondsBetween = now.timeIntervalSince(downTouchTime)
                    if !secondsBetween.isLess(than: self.holdThresholdInSeconds ) {
                        //------------------------------- A Hold found.
                        currentTouchStatus = EnumTouchStatus.DownHold
                        Commander.reportTouchStatus(currentTouchStatus,kv:reallyTouched)
                    }
                }
            }
        } else if touch?.phase == UITouchPhase.moved {
            //------------------------------------------- Touch Move: highlight touched button
            let moveTouchLoc = touch?.location(in: self)
            lastTouchLoc = moveTouchLoc
            if let reallyTouched = touchedKeyView {
                if currentTouchStatus == EnumTouchStatus.DownHold || currentTouchStatus == EnumTouchStatus.DownHoldMove {
                    //----------------------------------- A Down Hold Move found.
                    currentTouchStatus = EnumTouchStatus.DownHoldMove
                    Commander.reportTouchStatus(currentTouchStatus,kv:reallyTouched, downLoc: downTouchLoc!, curLoc: moveTouchLoc! )
                }
            }
        } else if touch?.phase == UITouchPhase.ended {
            let endTouchLoc = touch?.location(in: self)
            if let reallyTouched = touchedKeyView {
                if currentTouchStatus == EnumTouchStatus.Down {
                    //----------------------------------- A Down Up found - Tap
                    currentTouchStatus = EnumTouchStatus.DownUp
                    Commander.reportTouchStatus(currentTouchStatus,kv:reallyTouched, downLoc: downTouchLoc!, curLoc: endTouchLoc! )
                    checkContinuousTap(keyView : kv, downLoc: downTouchLoc!, downTime: downTouchTime, upLoc: endTouchLoc!, upTime: Date())     
                } else  if currentTouchStatus == EnumTouchStatus.DownHold {
                    //----------------------------------- A Down Hold Up found - Long Press
                    currentTouchStatus = EnumTouchStatus.DownHoldUp
                    Commander.reportTouchStatus(currentTouchStatus,kv:reallyTouched, downLoc: downTouchLoc!, curLoc: endTouchLoc!)
                }  else  if currentTouchStatus == EnumTouchStatus.DownHoldMove {
                    //----------------------------------- A Down Hold Move Up found
                    currentTouchStatus = EnumTouchStatus.DownHoldMoveUp
                    Commander.reportTouchStatus(currentTouchStatus,kv:reallyTouched, downLoc: downTouchLoc!, curLoc: endTouchLoc!)
                }
            }
            removeTouchedKeyView()
        } else if touch?.phase == UITouchPhase.cancelled {
            //------------------------------------------- Touch Cancelled
            removeTouchedKeyView()
            return
        }
    } // end of func
    
    //=============================================================================
    //    
    func findTouchedKeyView(_ pt:CGPoint ){
        touchedKeyView = nil
        if let page = self.drawnKeyboardPage {
            for row in page.rowArray {
                for ky in row.keyArray {
                    if let kv = ky.keyView {
                        if ky.frame.contains(pt) {
                            touchedKeyView = kv
                        }
                    }
                }
            }
        }
    }

    func removeTouchedKeyView(){
            touchedKeyView = nil
    }
   
    //=============================================================================
    // Manual Tap Detection
    let ContinuousTap_SpeedLimit_Second : Double = 0.5
    let ContinuousTap_XMovementLimit : Double = 10
    let ContinuousTap_YMovementLimit : Double = 10
        
    var continuousTapCount : Int = 0 
	var lastDowLoc:CGPoint
	var lastDownTime:Date = Date()
	var lastUpLoc:CGPoint
	var lastUpTime:Date = Date()
    var lastKeyView : KeyView

    checkContinuousTap(keyView : KeyView , downLoc: CGPoint, downTime: Date, upLoc: CGPoint, upTime: Date) {
    	// In the reportTouches(), a tap found if a up was following a down immediately, no move status in the between.
    	// Three points for judging a continuous tap: the same Key, quickly follow the previous tap, the same tap location.
        var toAcceptNewTap = true
        if continuousTapCount > 0 {  
        	if lastKeyView !== keyView { toAcceptnewTap = false }
        	else if abs(lastUpLoc.x - downLoc.x) > ContinuousTap_XMovementLimit  { toAcceptnewTap = false }  
        	else if abs(lastUpLoc.y - downLoc.y) > ContinuousTap_YMovementLimit  { toAcceptnewTap = false }
        	else if downTime.timeIntervalSince(lastUpTime) > ContinuousTap_SpeedLimit_Second  { toAcceptnewTap = false }
        }
        if toAcceptNewTap {
        	continuousTapCount++
        	print("Continuous Tap Found with Count: \(continuousTapCount)")
        	if continuousTapCount == 1 { Commander.reportSingleTap(keyView : KeyView) }
        	else if continuousTapCount == 2 { Commander.reportDoubleTap(keyView : KeyView) }
        	else if continuousTapCount == 3 { Commander.reportTripleTap(keyView : KeyView) }
        	 
        	lastDownLoc = downLoc
        	lastDownTime = downTime
        	lastUpLoc = upLoc
        	lastUpTime = upTime
        	lastKeyView = keyView        	
        } else {
        	continuousTapCount = 0
        }            	
   
    } // end of func
    
    
    
    
    //=============================================================================
    //
 } //end of class

enum EnumTouchStatus {
    case Null
    case Down
    case DownHold
    case DownHoldMove
    case DownHoldMoveUp
    case DownUp
    case DownHoldUp
    
    func toString()->String {
        switch self {
        case .Null: return "Null"
        case .Down: return "Down"
        case .DownHold: return "DownHold"
        case .DownHoldMove: return "DownHoldMove"
        case .DownHoldMoveUp: return "DownHoldMoveUp"
        case .DownUp: return "DownUp"
        case .DownHoldUp: return "DownHoldUp"
        //default: return ""
        }
    } // end of func
    
    
    
    
} //end of enum


/*
 let coverRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
 self.popUpContainerView = UIView(frame:coverRect)
 self.popUpContainerView.isOpaque = false
 self.popUpContainerView.isUserInteractionEnabled = false
 self.addSubview(self.popUpContainerView)
 */

/*
 
 //=====================================================================
 // ocerrides
 var popUpRect : CGRect?
 var popUpKeyView : KeyView?
 func showPopUp(_ kv:KeyView){
 if let ky = kv.keyDefinition {
 popUpKeyView = kv
 popUpRect = ky.calculatePopUpRect(CGFloat(200), height: CGFloat(40))
 self.setNeedsDisplay()
 } // end of if let ky = self.keyDefinition
 }
 func hidePopUp(){
 popUpRect = nil
 self.setNeedsDisplay()
 }
 
 public override func draw(_ frame: CGRect) {
 if let kv = self.popUpKeyView {
 if let ky = kv.keyDefinition {
 if let rt = self.popUpRect {
 let ctx = UIGraphicsGetCurrentContext()
 ctx?.saveGState()
 ky.drawPopUpPath(rt)
 ctx?.restoreGState()
 }
 }
 }
 //-------------------------------------------------------------
 
 
 //-------------------------------------------------------------
 
 } //end of func
 */
/*
 
 //=============================================================================
 // Touche Event Handlers

 var downTouchLoc:CGPoint?
 var downTouchTime:Date = Date()
 var lastTouchLoc:CGPoint?
 
 func reportTouches(_ touches: Set<UITouch>, with event: UIEvent?) {
 
 
 
 let touch = touches.first
 if touch?.phase == UITouchPhase.began {
 //------------------------------------------- Touch Begin
 downTouchLoc = touch?.location(in: self)
 downTouchTime = Date()
 lastTouchLoc = downTouchLoc
 removeHighlightTouchedKeyView()
 findAndHighlightTouchedKeyView(downTouchLoc!, with: event)
 if let reallyTouched = touchedKeyView {
 Commander.reportTouchDownKeyView(reallyTouched)
 let systemSoundID: SystemSoundID = 1104
 AudioServicesPlaySystemSound(systemSoundID)
 }
 return
 } else if touch?.phase == UITouchPhase.stationary { //case stationary: A finger is touching the surface but hasn't moved since the previous event.
 return;
 } else if touch?.phase == UITouchPhase.moved {
 //------------------------------------------- Touch Move: highlight touched button
 let moveTouchLoc = touch?.location(in: self)
 lastTouchLoc = moveTouchLoc
 removeHighlightTouchedKeyView()
 findAndHighlightTouchedKeyView(moveTouchLoc!, with: event)
 return
 } else if touch?.phase == UITouchPhase.ended {
 if let reallyTouched = touchedKeyView {
 //------------------------------------------- Touch Ended
 let endTouchLoc = touch?.location(in: self)
 let dist = max(abs((endTouchLoc?.x)! - (downTouchLoc?.x)!), abs((endTouchLoc?.y)! - (downTouchLoc?.y)!))
 if dist < 10 { // Do nothing more if finger moved a bit.
 //-------------------------------------- A tap found.
 let upTouchTime = Date()
 let secondsBetween = upTouchTime.timeIntervalSince(downTouchTime)
 if secondsBetween > 0.4 {
 //-------------------------------------- A long press found.
 let systemSoundID: SystemSoundID = 1057
 AudioServicesPlaySystemSound (systemSoundID)
 Commander.reportLongPressKeyView(reallyTouched)
 } else {
 Commander.reportTapKeyView(reallyTouched)
 }
 }
 }
 removeHighlightTouchedKeyView()
 return
 
 } else if touch?.phase == UITouchPhase.cancelled {
 //------------------------------------------- Touch Cancelled
 removeHighlightTouchedKeyView()
 return
 }
 } // end of func
 
 var touchedKeyView:KeyView?
 func findAndHighlightTouchedKeyView(_ pt:CGPoint, with event: UIEvent? ){
 //func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView?
 //let pt1:CGPoint = self.convert(pt, to: nil)
 //let newTouchedKeyView = self.hitTest(pt, with:event) //hitTest call point(inside: with event:) for sub views recursively if sub view's isUserInterctionEnabled.
 //if let touched = newTouchedKeyView as? KeyView {
 //    touchedKeyView = touched
 //    touched.addHighlight()
 //} else {
 //    touchedKeyView = nil
 //}
 touchedKeyView = nil
 if let page = self.drawnKeyboardPage {
 for row in page.rows {
 for ky in row.keys {
 if let kv = ky.view {
 if ky.frame.contains(pt) {
 touchedKeyView = kv
 touchedKeyView?.addHighlight()
 return
 }
 }
 }
 }
 }
 }
 
 func removeHighlightTouchedKeyView(){
 touchedKeyView?.removeHighlight()
 touchedKeyView = nil
 }
 
 //=============================================================================
 
 */

