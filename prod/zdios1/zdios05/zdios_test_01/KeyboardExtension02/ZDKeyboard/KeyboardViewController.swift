import Foundation
import UIKit

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    //=================================================================
    // Build Dictionary KeyLevel
    var hanziDictionary:ZDHanziDictionary?
    var topKeyLevel:KeyLevel?
    //=================================================================
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //--------- Perform custom UI setup here
        hanziDictionary = ZDHanziDictionary()
        topKeyLevel = hanziDictionary!.mTopKeyLevel
        drawKeyLevel(topKeyLevel!)
        
        //----------Prepare next keyboard button
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    } // end of func
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    //=================================================================
    // Draw Key Level
    let textRowHeight:CGFloat = 30
    var curCellStartX:CGFloat=0
    var curCellStartY:CGFloat=0
    func drawKeyLevel(_ keyLevel:KeyLevel){
        curCellStartX=0
       	curCellStartY=0
        
        var minTextWidth:CGFloat = getStringWidth("zh") // ? font must be considerred here.
        let colCount:CGFloat=floor(self.view.bounds.size.width / minTextWidth) // floor is deinfed in Foundation lib.
        //let remainder:CGFloat=Int(self.view.bounds.size.width) % Int(minTextWidth)
        let remainder:CGFloat = 20.0
        minTextWidth+=remainder/colCount-1 // Distribute extra width to each cell in a row
        
        if let childArray = keyLevel.mChildren {   // Only draw children now, not favor children yet.
            for lvl in childArray {
                var lvlText:String=lvl.text
                //----------------------------------------------------------------------------
                // Calculate real width used in drawing
                var txtWidthActual:CGFloat
                txtWidthActual = getStringWidth(lvlText)
                if 	txtWidthActual < minTextWidth {
                    txtWidthActual = minTextWidth
                }
                var drawnWidth:CGFloat = ceil(txtWidthActual/minTextWidth)*minTextWidth
                //----------------------------------------------------------------------------
                // Check if go to next row
                if curCellStartX+drawnWidth > self.view.bounds.size.width { // Goto next row
                    curCellStartX=0;
                    curCellStartY+=textRowHeight
                }
                
                var cellLeft:CGFloat = curCellStartX
                var cellTop:CGFloat = curCellStartY
                //----------------------------------------------------------------------------
                // Create and add a button for the child level
                var frm:CGRect = CGRect(x:cellLeft, y:cellTop, width:drawnWidth, height:textRowHeight)
                addKeyLevelButton(title:lvlText,frame:frm,keyLevel:lvl)
                
                //----------------------------------------------------------------------------
                // Record location and size back into the child key level
                lvl.x=curCellStartX
                lvl.y=curCellStartY
                lvl.height=textRowHeight
                lvl.width=drawnWidth
                curCellStartX+=drawnWidth
                //----------------------------------------------------------------------------
            }
        }else { // No child found, go back to the top
            drawKeyLevel(topKeyLevel!)
        }
    } //end of func
    
    func getStringWidth (_ text: String) -> CGFloat{
        ////let font = NSFont.userFontOfSize(NSFont.systemFontSize())
        //let attributes = NSDictionary(object: font!, forKey:NSFontAttributeName)
        ///let sizeOfText = text.sizeWithAttributes((attributes as! [String : AnyObject]))
        //return sizeOfText.width
        return 40
    }
    //=================================================================
    // Add Button
    private func addKeyLevelButton(title: String, frame:CGRect, keyLevel:KeyLevel) {
        let lvlButton = KeyLevelButton(frame: frame)
        lvlButton.parentKeyLevel = keyLevel
       	lvlButton.setTitle(title, for: .normal)
        lvlButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        self.view.addSubview(lvlButton)
    }
    
    func didTapButton(sender: AnyObject?) {
        
        let button = sender as! KeyLevelButton
        let title = button.title(for:.normal)
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(title!)
        
        let klvl = button.parentKeyLevel
        drawKeyLevel(klvl)        
    }
    
    //=================================================================
} // end of class
