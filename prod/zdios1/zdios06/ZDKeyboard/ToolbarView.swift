//
//  ToolbarView.swift
//  zdios05a
//
//  Created by Richard Feng on 7/12/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class ToolbarView: UIView { 
	//==================================================
	// Constructors, Initializers, and UIView life cycle
  	override init(frame: CGRect) {
    	super.init(frame: frame)
    	
  	}

  	required init?(coder aDecoder: NSCoder) {
    	super.init(coder: aDecoder)    	
  	}
  	  	
  	override func layoutSubviews() {
    	super.layoutSubviews()
     	addToolbarButtons()
  	}

  	override func updateConstraints() {
    	super.updateConstraints()
    	self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //======================================================================== 
    // 
    var mainVC:KeyboardViewController?

    //========================================================================
    // Build and add toolbar buttons
        
    let paddingLeft:CGFloat = 5
    let paddingRight:CGFloat = 5	    	     
    let paddingTop:CGFloat = 5
    let paddingBootom:CGFloat = 5    				
    let gap:CGFloat = 2
    
    let characterButton_Name = "CharacterButton"
    let mostUsedHanziButton_Name = "MostUsedHanziButton" 
    let hanziButton_Name = "HanziButton"
    let spaceKeyButton_Name = "SpaceKeyButton"
    let backspaceKeyButton_Name = "BackspaceKeyButton"
    let enterKeyButton_Name = "EnterKeyButton"
    let commaKeyButton_Name = "CommaKeyButton"
    let periodKeyButton_Name = "PeriodKeyButton"	    
    let nextIMEKeyButton_Name = "NextIMEKeyButton"
    let closeIMEKeyButton_Name = "CloseIMEKeyButton"
      
    let characterButton_Title = "A9"
    let mostUsedHanziButton_Title = "MU"
    let hanziButton_Title = "HZ"
    let spaceKeyButton_Title = "SP"
    let backspaceKeyButton_Title = "BS"
    let enterKeyButton_Title = "ENT"
    let commaKeyButton_Title = ","
    let periodKeyButton_Title = "."	    
    let nextIMEKeyButton_Title = "NX"
    let closeIMEKeyButton_Title = "CL"
         
    let characterButton_PercentageWidth:CGFloat = 10
    let mostUsedHanziButton_PercentageWidth:CGFloat = 10
    let hanziButton_PercentageWidth:CGFloat = 10
    let spaceKeyButton_PercentageWidth:CGFloat = 10
    let backspaceKeyButton_PercentageWidth:CGFloat = 10
    let enterKeyButton_PercentageWidth:CGFloat = 10
    let commaKeyButton_PercentageWidth:CGFloat = 10
    let periodKeyButton_PercentageWidth:CGFloat = 10
    let nextIMEKeyButton_PercentageWidth:CGFloat = 10
    let closeIMEKeyButton_PercentageWidth:CGFloat = 10
    
    
    func addToolbarButtons() {
        
        for vw in self.subviews {
            if let tBtn:ToolbarButton = vw as? ToolbarButton {
                tBtn.removeFromSuperview()
            }
        }
        //----------------------------- Calculated constants
	    let buttonHeight:CGFloat = self.frame.height - paddingTop - paddingBootom
	    let buttonWidthUnit:CGFloat = 0.01 * (self.frame.width - paddingLeft - paddingRight)
    	var frm:CGRect = CGRect(x: 0 , y: paddingTop, width:10, height:buttonHeight)
        
        frm.origin.x = paddingLeft
        frm.size.width = characterButton_PercentageWidth * buttonWidthUnit - gap
        //let characterButton =
        addToolbarButton(frm, title: characterButton_Title,name: characterButton_Name,img: "character")
    	
    	frm.origin.x += frm.size.width + gap
        frm.size.width = mostUsedHanziButton_PercentageWidth * buttonWidthUnit - gap
        //let mostUsedHanziButton = 
        addToolbarButton(frm, title: mostUsedHanziButton_Title,name: mostUsedHanziButton_Name,img: "mu")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = hanziButton_PercentageWidth * buttonWidthUnit - gap
        //let hanziButton = 
        addToolbarButton(frm, title: hanziButton_Title,name: hanziButton_Name,img: "hanzi")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = spaceKeyButton_PercentageWidth * buttonWidthUnit - gap
        //let spaceKeyButton = 
        addToolbarButton(frm, title: spaceKeyButton_Title,name: spaceKeyButton_Name,img: "space")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = backspaceKeyButton_PercentageWidth * buttonWidthUnit - gap
        //let backspaceKeyButton = 
        //addToolbarButton(frm, title: backspaceKeyButton_Title,name: backspaceKeyButton_Name)
        addToolbarButton(frm, title: backspaceKeyButton_Title,name: backspaceKeyButton_Name, img: "backspace")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = enterKeyButton_PercentageWidth * buttonWidthUnit - gap
        //let enterKeyButton = 
        addToolbarButton(frm, title: enterKeyButton_Title,name: enterKeyButton_Name,img: "enter")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = commaKeyButton_PercentageWidth * buttonWidthUnit - gap
        //let commaKeyButton = 
        addToolbarButton(frm, title: commaKeyButton_Title,name: commaKeyButton_Name,img: "comma")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = periodKeyButton_PercentageWidth * buttonWidthUnit - gap
        //var periodKeyButton = 
        addToolbarButton(frm, title: periodKeyButton_Title,name: periodKeyButton_Name,img: "period")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = nextIMEKeyButton_PercentageWidth * buttonWidthUnit - gap
        //var nextIMEKeyButton = 
        addToolbarButton(frm, title: nextIMEKeyButton_Title,name: nextIMEKeyButton_Name,img: "next")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = closeIMEKeyButton_PercentageWidth * buttonWidthUnit - gap
        //var closeIMEKeyButton = 
        addToolbarButton(frm, title: closeIMEKeyButton_Title,name: closeIMEKeyButton_Name,img: "close")
        
    } // end of func
    
    func addToolbarButton(_ frm:CGRect, title tl:String,name nm:String,img inm:String) {
        let btn:ToolbarButton = ToolbarButton(frame:frm,name:nm)
        //btn.mainVC = self.mainVC
        let ig : UIImage? = UIImage(named: "toolbar_icons/" + inm + "_key")
        let hig : UIImage? = UIImage(named: "toolbar_icons/highlight_" + inm + "_key")
        
        
        btn.setBackgroundImage(ig?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setBackgroundImage(hig?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        //btn.setTitle(tl, for: .normal)
        btn.addTarget(self, action: #selector(didTapToolbarButton), for: .touchUpInside)
        self.addSubview(btn)
        //return btn
    }
    func addToolbarButton1(_ frm:CGRect, title tl:String,name nm:String) { //-> ToolbarButton? {
        
        let btn:ToolbarButton = ToolbarButton(frame:frm,name:nm)
        //btn.mainVC = self.mainVC
        btn.setTitle(tl, for: .normal)
        btn.addTarget(self, action: #selector(didTapToolbarButton), for: .touchUpInside)
        self.addSubview(btn)
        //return btn
    }
    
    func addToolbarImageButton(_ frm:CGRect, title tl:String,name nm:String,img inm:String) { //-> ToolbarButton? {
        
        let btn:ToolbarButton = ToolbarButton(frame:frm,name:nm)
        //btn.mainVC = self.mainVC
        let ig : UIImage? = UIImage(named:"backspace01")
        btn.setBackgroundImage(ig?.withRenderingMode(.alwaysOriginal), for: .normal)
        //btn.setImage(UIImage(named: inm)?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        //btn.setTitle(tl, for: .normal)
        btn.addTarget(self, action: #selector(didTapToolbarButton), for: .touchUpInside)
        self.addSubview(btn)
        //return btn
    }

   
//2017-02-05 12:51:19.531 ZDKeyboard[48177:9435197] Failed to inherit CoreMedia permissions from 48175: (null)
    
    func didTapToolbarButton(sender: AnyObject?) {
        
        let button = sender as? ToolbarButton
        //let title = button.title(for:.normal)
        //let proxy = textDocumentProxy as UITextDocumentProxy
        //proxy.insertText(title!)
        //txtField.text! += title!
        //let klvl = button.parentKeyLevel
        //clearKeyLevels()
        //drawKeyLevel(klvl)
        if button != nil {
           mainVC?.tapToolbarButton(button)
        }
    }
       
	//==================================================
    
    
} // end of class

/*

    // Toolbar button definition 
    var characterButton : ToolbarButton?
    var mostUsedHanziButton : ToolbarButton? 
    var hanziButton : ToolbarButton?
    var spaceKeyButton : ToolbarButton?
    var backspaceKeyButton : ToolbarButton?
    var enterKeyButton : ToolbarButton?
    var commaKeyButton : ToolbarButton?
    var periodKeyButton : ToolbarButton?	    
    var nextIMEKeyButton : ToolbarButton?
    var closeIMEKeyButton : ToolbarButton?
    
 
   let buttonTitles:[String] = [
    	characterButton_Title,
    	mostUsedHanziButton_Title
     	hanziButton_Title,
     	spaceKeyButton_Title,
     	backspaceKeyButton_Title,
     	enterKeyButton_Title,
     	commaKeyButton_Title,
     	periodKeyButton_Title,	    
     	nextIMEKeyButton_Title,
     	closeIMEKeyButton_Title]
     	
    let buttonNames:[String] = [
    	characterButton_Name,
    	mostUsedHanziButton_Name
     	hanziButton_Name,
     	spaceKeyButton_Name,
     	backspaceKeyButton_Name,
     	enterKeyButton_Name,
     	commaKeyButton_Name,
     	periodKeyButton_Name,	    
     	nextIMEKeyButton_Name,
     	closeIMEKeyButton_Name]
     	
     let buttons:[ToolbarButton] = [
    	characterButton,
    	mostUsedHanziButton
     	hanziButton,
     	spaceKeyButton,
     	backspaceKeyButton,
     	enterKeyButton,
     	commaKeyButton,
     	periodKeyButton,	    
     	nextIMEKeyButton,
     	closeIMEKeyButton]
     	
      let buttonPercentageWidths:[String] = [
    	characterButton_PercentageWidth,
    	mostUsedHanziButton_PercentageWidth
     	hanziButton_PercentageWidth,
     	spaceKeyButton_PercentageWidth,
     	backspaceKeyButton_PercentageWidth,
     	enterKeyButton_PercentageWidth,
     	commaKeyButton_PercentageWidth,
     	periodKeyButton_PercentageWidth,	    
     	nextIMEKeyButton_PercentageWidth,
     	closeIMEKeyButton_PercentageWidth]
 */
     	
     
