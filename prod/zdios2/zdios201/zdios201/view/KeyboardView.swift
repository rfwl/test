
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
        let rowWidthInCells = row.cellTotal + row.paddingLeft + row.paddingRight + ( row.cellTotal - CGFloat(1.0) ) * row.gap
        let oneCellWidth = self.bounds.width / rowWidthInCells
        if(oneCellWidth==0) {return}
        var xOffset:CGFloat = row.paddingLeft * oneCellWidth
    	for key in row.keys {    		
    		key.frame.origin.y = row.frame.origin.y + row.paddingTop * heightScale
    		key.frame.size.height = row.frame.height - (row.paddingTop + row.paddingBottom) * heightScale
    		key.frame.origin.x = xOffset
    		key.frame.size.width = (CGFloat(key.width) + CGFloat((key.width-1)) * row.gap) * oneCellWidth
    		//buildKeyViewForKey(key)
    		xOffset += key.frame.width + row.gap * oneCellWidth
    	}
    } // end of func
    
    func buildKeyViewsForRow1(_ row:KeyboardRow, heightScale:CGFloat=1.0){
        
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
    } // end of func
    
    
    func buildKeyViewForKey(_ key:KeyboardKey){
        let kv = KeyView(vibrancy: nil, key: key)
    	self.addSubview(kv)
    }
    
    
    //====================================================================================================
    
    
    
    
    //====================================================================================================
    
    //====================================================================================================
    func drawPage(_ page:KeyboardPage) {
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
        for row in page.rows {
            for ky in row.keys {
                if ky.view==nil {
                    let kv = AKeyView(frame: ky.frame)
                    
                    kv.draw(ky.frame)
                    
                    ky.view = kv
                }
                self.addSubview(ky.view!)
                
            }
        }
        
        
    }
    
    
    
    
    //====================================================================================================
    func drawPage1(_ page:KeyboardPage) {
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
        for row in page.rows {
            for ky in row.keys {
                if ky.view==nil {
                    let kv = KeyView(vibrancy: nil, key: ky)
                    ky.view = kv
                    
                    ///kv.setTitle(ky.label, for: UIControlState.normal)
                    kv.layer.borderColor = UIColor.blue.cgColor
                    kv.layer.borderWidth = 1
                    setAppearanceForKey(kv: kv, ky: ky, darkMode: true, solidColorMode: false)
                }
                self.addSubview(ky.view!)
                //ky.view!.refreshViews()
                //sky.view!.showPopup()

            }
        }
        
        
    }
    
    
    func setAppearanceForKey(kv: KeyView, ky: KeyboardKey, darkMode: Bool, solidColorMode: Bool) {
       
        switch ky.type {
        case
        KeyboardKey.EnumKeyType.Character,
        KeyboardKey.EnumKeyType.SpecialCharacter,
        KeyboardKey.EnumKeyType.Period:
            kv.color = GlobalColors.regularKey(darkMode, solidColorMode: solidColorMode)
            if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
                kv.downColor = GlobalColors.specialKey(darkMode, solidColorMode: solidColorMode)
            }
            else {
                kv.downColor = nil
            }
            kv.textColor = (darkMode ? GlobalColors.darkModeTextColor : GlobalColors.lightModeTextColor)
            kv.downTextColor = nil
        case
        KeyboardKey.EnumKeyType.Space:
            kv.color = GlobalColors.regularKey(darkMode, solidColorMode: solidColorMode)
            kv.downColor = GlobalColors.specialKey(darkMode, solidColorMode: solidColorMode)
            kv.textColor = (darkMode ? GlobalColors.darkModeTextColor : GlobalColors.lightModeTextColor)
            kv.downTextColor = nil
        case
        KeyboardKey.EnumKeyType.PageChangeLower:
            kv.color = GlobalColors.specialKey(darkMode, solidColorMode: solidColorMode)
            kv.downColor = (darkMode ? GlobalColors.darkModeShiftKeyDown : GlobalColors.lightModeRegularKey)
            kv.textColor = GlobalColors.darkModeTextColor
            kv.downTextColor = GlobalColors.lightModeTextColor
        case
        KeyboardKey.EnumKeyType.Backspace:
            kv.color = GlobalColors.specialKey(darkMode, solidColorMode: solidColorMode)
            kv.downColor = GlobalColors.regularKey(darkMode, solidColorMode: solidColorMode)
            kv.textColor = GlobalColors.darkModeTextColor
            kv.downTextColor = (darkMode ? nil : GlobalColors.lightModeTextColor)
        case
        KeyboardKey.EnumKeyType.PageChangeUpper:
            kv.color = GlobalColors.specialKey(darkMode, solidColorMode: solidColorMode)
            kv.downColor = nil
            kv.textColor = (darkMode ? GlobalColors.darkModeTextColor : GlobalColors.lightModeTextColor)
            kv.downTextColor = nil
        case
        KeyboardKey.EnumKeyType.Return,
        KeyboardKey.EnumKeyType.KeyboardChange,
        KeyboardKey.EnumKeyType.Settings:
            kv.color = GlobalColors.specialKey(darkMode, solidColorMode: solidColorMode)
            kv.downColor = GlobalColors.regularKey(darkMode, solidColorMode: solidColorMode)
            kv.textColor = (darkMode ? GlobalColors.darkModeTextColor : GlobalColors.lightModeTextColor)
            kv.downTextColor = nil
        default:
            break
        }
        
        kv.popupColor = GlobalColors.popup(darkMode, solidColorMode: solidColorMode)
        kv.underColor = (darkMode ? GlobalColors.darkModeUnderColor : GlobalColors.lightModeUnderColor)
        kv.borderColor = (darkMode ? GlobalColors.darkModeBorderColor : GlobalColors.lightModeBorderColor)
    }

    
    
    //=============================================================================
    // 
    
 } //end of class

