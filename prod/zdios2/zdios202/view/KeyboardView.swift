import AVFoundation
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
    
    func buildKeyViews(){
        
        for pg in keyboardDefinition.pages {
            buildKeyViewsForPage(pg)
        }
    }
    
    func buildKeyViewsForPage(_ page:KeyboardPage){
        
        // Calculate vertical scale
        if(self.bounds.height==0) { return }
        
        var totalSpecifiedHeight : CGFloat = 0
        for row in page.rows {
            totalSpecifiedHeight += row.paddingTop + row.height + row.paddingBottom
        }
        let heightScale = self.bounds.height / totalSpecifiedHeight
        if(heightScale==0) {return}
        
        var yOffset:CGFloat = 0
        for row in page.rows {
            row.frame.origin.x = 0
            row.frame.size.width = self.frame.width
            row.frame.origin.y = yOffset + row.paddingTop * heightScale
            row.frame.size.height = row.height * heightScale
            buildKeyViewsForRow(row,heightScale: heightScale)
            yOffset += row.frame.height
        }
        
    } // end of func
    
    func buildKeyViewsForRow(_ row:KeyboardRow, heightScale:CGFloat=1.0){
    
        if(self.bounds.width==0) {return}
        let rowWidthInCells = row.cellTotal + row.paddingLeft + row.paddingRight + ( row.cellTotal - CGFloat(1.0) ) * row.gap
        let oneCellWidth = self.bounds.width / rowWidthInCells
        if(oneCellWidth==0) {return}
        var xOffset:CGFloat = row.paddingLeft * oneCellWidth
        for key in row.keys {
            key.frame.origin.y = row.frame.origin.y + row.paddingTop * heightScale
            key.frame.size.height = row.frame.height - (row.paddingTop + row.paddingBottom) * heightScale
            key.frame.origin.x = xOffset
            key.frame.size.width = (CGFloat(key.widthInCells) + CGFloat((key.widthInCells-1)) * row.gap) * oneCellWidth
            //buildKeyViewForKey(key)
            xOffset += key.frame.width + row.gap * oneCellWidth
        }
    } // end of func
    
    func buildKeyViewsForRow1(_ row:KeyboardRow, heightScale:CGFloat=1.0){
        
        if(self.bounds.width==0) {return}
        var totalSpecifiedWidth : CGFloat = 0
        for key in row.keys {
            totalSpecifiedWidth += CGFloat(key.widthInCells)
        }
        totalSpecifiedWidth += row.paddingLeft + row.paddingRight + ( totalSpecifiedWidth - CGFloat(1.0) ) * row.gap
        let widthScale = self.bounds.width / totalSpecifiedWidth
        if(widthScale==0) {return}
        
        var xOffset:CGFloat = row.paddingLeft * widthScale
        for key in row.keys {
            key.frame.origin.y = row.frame.origin.y + row.paddingTop * heightScale
            key.frame.size.height = row.frame.height - (row.paddingTop + row.paddingBottom) * heightScale
            key.frame.origin.x = xOffset
            key.frame.size.width = (CGFloat(key.widthInCells) + CGFloat((key.widthInCells-1)) * row.gap) * widthScale
            xOffset += key.frame.width + row.gap * widthScale
        }
    } // end of func
    
    
    //=============================================================================
    // Operations
    var drawnKeyboardPage : KeyboardPage?
    func drawPage(_ page:KeyboardPage) {
        drawnKeyboardPage = page
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
        for row in page.rows {
            for ky in row.keys {
                if ky.view==nil {
                    let kv = KeyView(frame: ky.frame)
                    kv.keyDefinition = ky
                    //kv.draw(ky.frame)
                    
                    ky.view = kv
                }
                self.addSubview(ky.view!)
                
            }
        }
        
        
    } //end of func
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
    //
 } //end of class


