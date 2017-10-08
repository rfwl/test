//
//  ViewController.swift
//  zdios03
//
//  Created by Richard Feng on 3/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var toolbarView: UIView!
    
    @IBOutlet weak var contentView: UIScrollView!
    
    let characterPopoverView: UIView = UIView()
    
    let hanziPopoverView: UIView = UIView()
    
    let specialKeyPopoverView: UIView = UIView()
    
    let imeKeyPopoverView: UIView = UIView()
    
    
    //==========================================================
    //
    let contentVC:KeyLevelViewController = KeyLevelViewController()
    let commander = Commander()    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addTextView()
        addToolBarView()        
        prepareCharacterPopoverView()
        prepareHanziPopoverView()
        prepareSpecialKeyPopoverView()
        prepareIMEKeyPopoverView()
        
        addContentView()
        contentVC.view = contentView
        contentVC.commander = commander
        
     	commander.mainVC = self
    	commander.contentVC = contentVC
        commander.txtView = txtView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //==========================================================
    // Add View: toolbar and content
    let toolbarHeight:CGFloat = 46
    let paddingLeft:CGFloat = 5
    let paddingRight:CGFloat = 5
    let paddingTop:CGFloat = 200
    let paddingBottom:CGFloat = 5
    let gap:CGFloat = 0
    
    func addTextView() {
        let frm:CGRect =  CGRect(x: paddingLeft, y: 25, width: self.view.frame.width, height: paddingTop - 30)
        txtView.frame = frm
        txtView.text = ""
        self.view.addSubview(txtView)
        
    }
    
    func addToolBarView() {
        let toolbarWidth:CGFloat = self.view.bounds.width - paddingLeft - paddingRight
        let frm:CGRect =  CGRect(x: paddingLeft, y: paddingTop, width: toolbarWidth, height: toolbarHeight)
        toolbarView.frame = frm
        self.view.addSubview(toolbarView)
        addToolbarButtons()
    }
    	
    func addContentView() {
       	let contentWidth:CGFloat = self.view.bounds.width - paddingLeft - paddingRight
        let contentTop:CGFloat = paddingTop + toolbarHeight + gap
        let contentHeight:CGFloat = self.view.bounds.height - contentTop - paddingBottom
        
        let frm:CGRect =  CGRect(x: paddingLeft, y: contentTop, width: contentWidth, height: contentHeight)
        contentView.frame = frm
        contentView.isScrollEnabled = true
        contentView.isUserInteractionEnabled = true
        contentView.showsVerticalScrollIndicator = true
        self.view.addSubview(contentView)
        
    }
           
    //================================================================= 
    // Build and add toolbar buttons
    let toolbarPaddingLeft:CGFloat = 5
    let toolbarPaddingRight:CGFloat = 5	    	     
    let toolbarPaddingTop:CGFloat = 5
    let toolbarPaddingBootom:CGFloat = 5    				
    let toolbarGap:CGFloat = 2
    
	let characterButtonWidth:CGFloat = 90
    let hanziButtonWidth:CGFloat = 90
    let specialKeyButtonWidth:CGFloat = 80
    let imeKeyButtonWidth:CGFloat = 40
    
    let characterButtonTitle:String = "Chars" 
    let hanziButtonTitle:String = "Hanzi" 
    let specialKeyButtonTitle:String = "Enter" 
    let imeKeyButtonTitle:String = "IME" 
    
    // Make them accessible from outside to tell location of buttons. 
    var characterButton:ToolbarButton? 
    var hanziButton:ToolbarButton?
    var specialKeyButton:ToolbarButton?	    
    var imeKeyButton:ToolbarButton?
    		
    func addToolbarButtons() {
        //----------------------------- Calculated constants
	    let buttonHeight:CGFloat = toolbarView.frame.height - toolbarPaddingTop - toolbarPaddingBootom
    	var frm:CGRect = CGRect(x: toolbarPaddingLeft, y: toolbarPaddingTop, width:characterButtonWidth , height: buttonHeight)
        
        characterButton = addToolbarButton(frm,title: characterButtonTitle,name:"CharacterButton") 
    	frm.origin.x += characterButtonWidth + toolbarGap
        frm.size.width = hanziButtonWidth
        
        hanziButton = addToolbarButton(frm,title: hanziButtonTitle,name:"HanziButton")
    	frm.origin.x += hanziButtonWidth + toolbarGap
        frm.size.width = specialKeyButtonWidth
        
        specialKeyButton = addToolbarButton(frm,title:specialKeyButtonTitle,name:"SpecialKeyButton")
		frm.origin.x += specialKeyButtonWidth + toolbarGap
        frm.size.width = self.toolbarView.frame.width - frm.origin.x - toolbarGap - toolbarPaddingRight
        
        imeKeyButton = addToolbarButton(frm,title:imeKeyButtonTitle,name:"IMEKeyButton")
    } // end of func
    
    func addToolbarButton(_ frm:CGRect, title tl:String,name nm:String) -> ToolbarButton? {
	  
        let btn:ToolbarButton = ToolbarButton(frame:frm,name:nm)
        btn.mainVC = self
	    btn.setTitle(tl, for: .normal)
	    toolbarView.addSubview(btn) 
	    return btn
    }
    //==========================================================
    // Build and add popover views
    let popoverWidth:CGFloat = 160
    let popoverMenuButtonHeight:CGFloat = 30
    let popoverGap:CGFloat = 2
   	
   	let popoverPaddingLeft:CGFloat = 5
    let popoverPaddingRight:CGFloat = 5
    let popoverPaddingTop:CGFloat = 5
    let popoverPaddingBootom:CGFloat = 5
    
    let character_MenuButtonCount:CGFloat = 3
    let hanzi_MenuButtonCount:CGFloat = 3
    let specialKey_MenuButtonCount:CGFloat = 5
    let imeKey_MenuButtonCount:CGFloat = 3
    
    let popoverBackgroundColor = UIColor(red: 0.85, green: 0.75, blue: 0.75, alpha: 1.0)
   
    func prepareCharacterPopoverView(){
        if let btn:ToolbarButton = characterButton {
        let left:CGFloat = toolbarView.frame.origin.x + btn.frame.origin.x
        let top:CGFloat = toolbarView.frame.origin.y + toolbarView.frame.height
        let height:CGFloat = (popoverMenuButtonHeight + popoverGap) * character_MenuButtonCount
            + popoverPaddingTop + popoverPaddingBootom
        let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, height: height)
        characterPopoverView.frame = frm
        characterPopoverView.backgroundColor = popoverBackgroundColor
        //characterPopoverView.isHidden = true
        self.view.addSubview(characterPopoverView)
         
        addMenuButton(characterPopoverView,title: "Num",loc: 0,name: "NumberMenu")
       	addMenuButton(characterPopoverView,title: "Alphabet",loc: 1,name: "AlphabetMenu")
       	addMenuButton(characterPopoverView,title: "Symbol",loc: 2,name: "SymbolMenu")
        }
    }
    
    
    func prepareHanziPopoverView(){
        if let btn:ToolbarButton = hanziButton {
        let left:CGFloat = toolbarView.frame.origin.x + btn.frame.origin.x
        let top:CGFloat = toolbarView.frame.origin.y + toolbarView.frame.height
        let height:CGFloat = (popoverMenuButtonHeight + popoverGap) * hanzi_MenuButtonCount
            + popoverPaddingTop + popoverPaddingBootom
        let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth , height: height)
        hanziPopoverView.frame = frm
        hanziPopoverView.backgroundColor = popoverBackgroundColor
        self.view.addSubview(hanziPopoverView)
        
        addMenuButton(hanziPopoverView,title: "PI",loc: 0,name: "PIMenu")
       	addMenuButton(hanziPopoverView,title: "Most",loc: 1,name: "MostMenu")
       	addMenuButton(hanziPopoverView,title: "Recent",loc: 2,name: "RecentMenu")
        }        
    }
       
    func prepareSpecialKeyPopoverView(){
        if let btn:ToolbarButton = specialKeyButton {
        let left:CGFloat = toolbarView.frame.origin.x + btn.frame.origin.x + btn.frame.width - popoverWidth
        let top:CGFloat = toolbarView.frame.origin.y + toolbarView.frame.height
        let height:CGFloat = (popoverMenuButtonHeight + popoverGap) * specialKey_MenuButtonCount
            + popoverPaddingTop + popoverPaddingBootom
        let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, height: height)                      
        specialKeyPopoverView.frame = frm
        specialKeyPopoverView.backgroundColor = popoverBackgroundColor
        self.view.addSubview(specialKeyPopoverView)
        
        addMenuButton(specialKeyPopoverView,title: "Enter",loc: 0,name: "EnterMenu")
       	addMenuButton(specialKeyPopoverView,title: "BS",loc: 1,name: "BSMenu")
       	addMenuButton(specialKeyPopoverView,title:"Space",loc: 2,name: "SpaceMenu")
        addMenuButton(specialKeyPopoverView,title: "Comma",loc:3,name: "CommaMenu")
       	addMenuButton(specialKeyPopoverView,title: "Period",loc:4,name: "PeriodMenu")
        }
        
    }
    
    func prepareIMEKeyPopoverView(){
        //let btn:ToolbarButton = toolbarVC.IMEKeyButton
        let left:CGFloat = toolbarView.frame.width - popoverWidth
        let top:CGFloat = toolbarView.frame.origin.y + toolbarView.frame.height
        let width:CGFloat = popoverWidth //- popoverPaddingLeft - popoverPaddingRight
        let height:CGFloat = (popoverMenuButtonHeight + popoverGap) * imeKey_MenuButtonCount
            + popoverPaddingTop + popoverPaddingBootom
        let frm:CGRect =  CGRect(x: left, y: top, width: width, height: height)
        imeKeyPopoverView.frame = frm
        imeKeyPopoverView.backgroundColor = popoverBackgroundColor
        self.view.addSubview(imeKeyPopoverView)
        
        addMenuButton(imeKeyPopoverView,title: "Close",loc: 0,name: "CloseMenu")
       	addMenuButton(imeKeyPopoverView,title: "Next",loc: 1,name: "NextMenu")
       	addMenuButton(imeKeyPopoverView,title: "Prev",loc: 2,name: "PrevMenu")
        
    }
    
    func addMenuButton(_ parent:UIView,title:String,loc:CGFloat,name nm:String) {
    	
    	let frm:CGRect = CGRect(
            x: popoverPaddingLeft,
            y: popoverPaddingTop + loc*(popoverMenuButtonHeight + popoverGap) ,
            width: popoverWidth - popoverPaddingLeft - popoverPaddingRight ,
            height: popoverMenuButtonHeight)
    	let btn:ToolbarMenuButton = ToolbarMenuButton(frame:frm,name:nm)
        btn.mainVC = self
    	btn.setTitle(title, for: .normal)  
    	parent.addSubview(btn)	
    }
    //==========================================================
    // Report Touches    
        
    func reportTouches(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self.view) 
        let found:UIView? = self.view.hitTest(location!,with:event!)
        if found == nil {return}
        if let tbBtn = found as? ToolbarButton {
        	if touch?.phase == UITouchPhase.began {
        		//print("DB-" + tbBtn.buttonName)
                commander.reportTouchBegan(tbBtn.buttonName)                
        	} else if touch?.phase == UITouchPhase.ended {
        		//print("DE-" + tbBtn.buttonName)
                commander.reportTouchEnded(tbBtn.buttonName)   
        	} else if touch?.phase == UITouchPhase.cancelled {
        		//print("DC-" + tbBtn.buttonName)
                commander.reportTouchCancelled(tbBtn.buttonName)   
        	}
        } else  if let mnuBtn = found as? ToolbarMenuButton {
        	if touch?.phase == UITouchPhase.began {
        		//print("DB-" + mnuBtn.buttonName)
                commander.reportTouchBegan(mnuBtn.buttonName)                
        	} else if touch?.phase == UITouchPhase.ended {
        		//print("DE-" + mnuBtn.buttonName)
                commander.reportTouchEnded(mnuBtn.buttonName)   
        	} else if touch?.phase == UITouchPhase.cancelled {
        		//print("DC-" + mnuBtn.buttonName)
                commander.reportTouchCancelled(mnuBtn.buttonName)   
        	}
        } else {
        	// Ignore that only buttons will be considerred here
        }  
    }
   
    
	   //==========================================================
	   // Operations       	
	   func openCharacterPopoverView(){
            safeRemoveSubview(view: hanziPopoverView)
            safeRemoveSubview(view: specialKeyPopoverView)
            safeRemoveSubview(view: imeKeyPopoverView)
            safeAddSubview(view: characterPopoverView)
	   }
	   func closeCharacterPopoverView(){
            safeRemoveSubview(view: characterPopoverView)
	   }
	   
	   func openHanziPopoverView(){
            safeRemoveSubview(view: characterPopoverView )
            safeRemoveSubview(view: specialKeyPopoverView)
            safeRemoveSubview(view: imeKeyPopoverView)
            safeAddSubview(view:  hanziPopoverView)
	   }
	   func closeHanziPopoverView(){
            safeRemoveSubview(view: hanziPopoverView)
	   }
	   
	   
	   func openSpecialKeyPopoverView(){
        safeRemoveSubview(view: hanziPopoverView)
        safeRemoveSubview(view: characterPopoverView)
        safeRemoveSubview(view: imeKeyPopoverView)
        safeAddSubview(view: specialKeyPopoverView)
	   }
	   func closeSpecialKeyPopoverView(){
            safeRemoveSubview(view: specialKeyPopoverView)
	   }
	   
	   
	   func openIMEKeyPopoverView(){
        safeRemoveSubview(view: hanziPopoverView)
        safeRemoveSubview(view: specialKeyPopoverView)
        safeRemoveSubview(view: characterPopoverView)
        safeAddSubview(view: imeKeyPopoverView)
	   }
	   func closeIMEKeyPopoverView(){
            safeRemoveSubview(view: imeKeyPopoverView)
	   }
	   
	  
	   func safeAddSubview(view:UIView?){
	   	if let vw = view {
            vw.isHidden = false
            self.view.bringSubview(toFront: vw)
	   		///if vw.isDescendant(of: self.view) {
	   			// Already in
                //print("In already")
	   		//} else {
	   			//self.view.addSubview(vw)
	   		//}
	   	}
	   }
	   func safeRemoveSubview(view:UIView?){
	   	if let vw = view {
            vw.isHidden = true
	   	//	if vw.isDescendant(of: self.view) {
	   			//vw.removeFromSuperview()
	   	//	} else {
          //      print("Out already")
	   		//}
	   	}
	   }
    func removeAllPopoverViews(){
        safeRemoveSubview(view: hanziPopoverView)
        safeRemoveSubview(view: specialKeyPopoverView)
        safeRemoveSubview(view: characterPopoverView)
        safeRemoveSubview(view: imeKeyPopoverView)
    }
	  //==========================================================
	    
	  //==========================================================
	   
} // end of class

/*
 func hitTest(_ point:CGPoint, with:UIEvent) -> UIView? {
 if !self.view.isUserInteractionEnabled { return nil}
 if !self.view.point(inside: point,with:with) { return nil}
 for i in (0..<self.view.subviews.count).reversed() {
 let subview:UIView? = self.view.subviews[i]
 if subview == contentView {return nil} // Content view's touches will not be handled here.
 let ptInSubview = self.view.convert(point, to: subview)
 let foundSubview:UIView? = subview?.hitTest(ptInSubview,with:with)
 if let found = foundSubview {
 return found
 }
 }
 return self.view
 } // end of func
 extension UIView {
    convenience init(hexString:String) {

        // some code to parse the hex string
        let red = 0.0
        let green = 0.0
        let blue = 0.0
        let alpha = 1.0

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
} // end of extesnion

*/

/*





*/



    
    
    
