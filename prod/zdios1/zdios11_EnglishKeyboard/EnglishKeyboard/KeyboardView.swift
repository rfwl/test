
import UIKit

class KeyboardView: UIView {
    
    //=============================================================================
    //
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
    	var totalSpecifiedWidth : CGFloat = 0
        for key in row.keys {
    		totalSpecifiedWidth += CGFloat(key.width)
    	}
        totalSpecifiedWidth += row.paddingLeft + row.paddingRight + ( totalSpecifiedWidth - CGFloat(1.0) ) * row.gap
    	let widthScale = self.bounds.width / totalSpecifiedWidth
        if(widthScale==0) {return}
    	
    	var xOffset:CGFloat = row.paddingLeft * widthScale    	
    	for key in row.keys {    		
    		key.frame.origin.y = row.frame.origin.y + row.paddingTop * heightScale
    		key.frame.size.height = row.frame.height - (row.paddingTop + row.paddingBottom) * heightScale
    		key.frame.origin.x = xOffset
    		key.frame.size.width = (CGFloat(key.width) + CGFloat((key.width-1)) * row.gap) * widthScale
    		//buildKeyViewForKey(key)
    		xOffset += key.frame.width + row.gap * widthScale
    	}
    }
    
    func buildKeyViewForKey(_ key:KeyboardKey){
    	let kv = KeyView(key)
    	self.addSubview(kv)
    }
    
    func drawPage(_ page:KeyboardPage) {
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
        for row in page.rows {
            for ky in row.keys {
                if ky.view==nil {
                    let kv = KeyView(ky)
                    ky.view = kv
                    kv.setTitle(ky.label, for: UIControlState.normal)
                    kv.layer.borderColor = UIColor.blue.cgColor
                    kv.layer.borderWidth = 2
                }
                self.addSubview(ky.view!)
            }
        }
        
        
    }
    
    
    
    
    //=============================================================================
    // 
    
 } //end of class

