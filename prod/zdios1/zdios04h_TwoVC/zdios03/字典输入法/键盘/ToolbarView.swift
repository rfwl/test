//
//  ToolbarView.swift
//  zdios05a
//
//  Created by Richard Feng on 7/12/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class ToolbarButton: UIButton {
    
    var buttonName:String = ""
    init(frame: CGRect,name nm:String) {
        super.init(frame: frame)
        buttonName = nm        
    } // end of func

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //===================================================================
    
} //end of class

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
        
	    let buttonHeight:CGFloat = self.frame.height - paddingTop - paddingBootom
	    let buttonWidthUnit:CGFloat = 0.01 * (self.frame.width - paddingLeft - paddingRight)
    	var frm:CGRect = CGRect(x: 0 , y: paddingTop, width:10, height:buttonHeight)
        
        frm.origin.x = paddingLeft
        frm.size.width = characterButton_PercentageWidth * buttonWidthUnit - gap
        addToolbarButton(frm, title: characterButton_Title,name: characterButton_Name,img: "character")
    	
    	frm.origin.x += frm.size.width + gap
        frm.size.width = mostUsedHanziButton_PercentageWidth * buttonWidthUnit - gap
        addToolbarButton(frm, title: mostUsedHanziButton_Title,name: mostUsedHanziButton_Name,img: "mu")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = hanziButton_PercentageWidth * buttonWidthUnit - gap
        addToolbarButton(frm, title: hanziButton_Title,name: hanziButton_Name,img: "hanzi")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = spaceKeyButton_PercentageWidth * buttonWidthUnit - gap
        addToolbarButton(frm, title: spaceKeyButton_Title,name: spaceKeyButton_Name,img: "space")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = commaKeyButton_PercentageWidth * buttonWidthUnit - gap
        addToolbarButton(frm, title: commaKeyButton_Title,name: commaKeyButton_Name,img: "comma")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = periodKeyButton_PercentageWidth * buttonWidthUnit - gap
        addToolbarButton(frm, title: periodKeyButton_Title,name: periodKeyButton_Name,img: "period")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = backspaceKeyButton_PercentageWidth * buttonWidthUnit - gap
        addToolbarButton(frm, title: backspaceKeyButton_Title,name: backspaceKeyButton_Name, img: "backspace")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = enterKeyButton_PercentageWidth * buttonWidthUnit - gap
        addToolbarButton(frm, title: enterKeyButton_Title,name: enterKeyButton_Name,img: "enter")

        frm.origin.x += frm.size.width + gap
        frm.size.width = nextIMEKeyButton_PercentageWidth * buttonWidthUnit - gap
        addToolbarButton(frm, title: nextIMEKeyButton_Title,name: nextIMEKeyButton_Name,img: "next")
        
        frm.origin.x += frm.size.width + gap
        frm.size.width = closeIMEKeyButton_PercentageWidth * buttonWidthUnit - gap
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
    
    func didTapToolbarButton(sender: AnyObject?) {        
        let button = sender as? ToolbarButton
        if button != nil {
        	 Commander.reportTapToolbarButton((button?.buttonName)!)
        }
    }  
	//==================================================
    
    
} // end of class
