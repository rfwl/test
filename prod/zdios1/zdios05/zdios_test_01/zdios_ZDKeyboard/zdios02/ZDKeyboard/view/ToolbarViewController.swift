//
//  ToolbarViewController.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 02/11/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
//
import Foundation
import UIKit

class ToolbarViewController: UIViewController {
   
    var mainVC:MainViewController
    //=================================================================    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.               
        
    } 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    //================================================================= 
    // Built toolbar buttons
    let paddingLeft:CGFloat = 5
    let paddingRight:CGFloat = 5	    	     
    let paddingTop:CGFloat = 5
    let paddingBootom:CGFloat = 5    				
    let gap:CGFloat = 2
    
	let characterButtonWidth:CGFloat = 120    
    let hanziButtonWidth:CGFloat = 120
    let specialKeyButtonWidth:CGFloat = 40
    let IMEKeyButtonWidth:CGFloat = 40
    
    let characterButtonTitle:String = "Chars" 
    let hanziButtonTitle:String = "Hanzi" 
    let specialKeyButtonTitle:String = "Enter" 
    let IMEKeyButtonTitle:String = "IME" 
    
    // Make them accessible from outside to tell location of buttons. 
    let characterButton:ToolbarButton = ToolbarButton()
    let specialKeyButton:ToolbarButton = ToolbarButton()	    
    let hanziButton:ToolbarButton = ToolbarButton()
    let IMEKeyButton:ToolbarButton = ToolbarButton()
    		
    func addToolbarButtons() {
        //----------------------------- Calculated constants
	    let buttonHeight:CGFloat = toolBarHeight - paddingTop - paddingBootom	            
	    //----------------------------- Create and add character button
	    var offset:CGFloat = paddingLeft	            
    	var frm:CGRect = CGRect(x: offset, y: paddingTop, width:characterButtonWidth , height: buttonHeight)  
    	characterButton.frame = frm
    	characterButton.setTitle(characterButtonTitle, for: .normal)
    	characterButton.addTarget(self, action: #selector(didTouchDown_CharcterButton), for: .touchDown)    	
        characterButton.addTarget(self, action: #selector(didTouchUp_CharcterButton), for: .touchUpInside)
    	self.view.addSubview(characterButton)
    	//----------------------------- Create and add hanzi button
    	yOffset += characterButtonWidth + gap
    	frm = CGRect(x: offset, y: paddingTop, width:hanziButtonWidth , height: buttonHeight)  
    	hanziButton.frame= frm;
    	hanziButton.setTitle(hanziButtonTitle, for: .normal)
    	hanziButton.addTarget(self, action: #selector(didTapHanziButton), for: .touchUpInside)
    	self.view.addSubview(hanziButton)
    	//----------------------------- Create and add special key button
    	yOffset += hanziButtonWidth + gap
    	frm = CGRect(x: offset, y: paddingTop, width:specialKeyButtonWidth , height: buttonHeight)  
    	specialKeyButton.frame = frm
    	specialKeyButton.setTitle(specialKeyButtonTitle, for: .normal)
    	specialKeyButton.addTarget(self, action: #selector(didTapSpecialKeyButton), for: .touchUpInside)
    	self.view.addSubview(specialKeyButton)
    	//----------------------------- Create and add IME key button
    	yOffset += specialKeyButtonWidth + gap
    	// Considering last button should take all the remaining width
    	let lastButtonWidth:CGFloat = self.view.bounds.width - yOffset - paddingRight    	
    	//frm = CGRect(x: offset, y: paddingTop, width:IMEKeyButtonWidth , height: buttonHeight)
    	frm = CGRect(x: offset, y: paddingTop, width:lastButtonWidth , height: buttonHeight)    	
    	IMEKeyButton.frame = frm
    	IMEKeyButton.setTitle(IMEKeyButtonTitle, for: .normal)    		
    	IMEKeyButton.addTarget(self, action: #selector(didTapIMEKeyButton), for: .touchUpInside)
    	self.view.addSubview(IMEKeyButton)  
    	
    } // end of func
    //================================================================= 
    
    func didTouchDown_CharcterButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
        mainVC.openCharacterPopoverView()
    
    }
    
    func didTouchUp_CharcterButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
        
        mainVC.closeCharacterPopoverView()
    }
    
    func didTapHanziButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
    
    
    }
    
    func didTapSpecialKeyButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
    
    
    }
    
    func didTapIMEButtonButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
    
    
    }
	//=================================================================
    //
   
    
    
    
    
    
    	    
    
    
   //=================================================================
    

} //end of class
    
    
    
	// Add and create a UIButton
	let btn= UIButton(frame: frame)
	btn.setTitle(title, for: .normal)
	selfview.addSubview(lvlButton)

	// Add and create a UIButton
	let button = UIButton()
	button.frame = CGRect(x: 13, y: offset, width: 260, height: 43)
	button.setTitleColor(UIColor(rgba: feeling["color"]!), forState: .Normal)
	button.setTitle(feeling["title"], forState: .Normal)
	button.tag = index
	picker.addSubview(button)

	// Create and add a UIView
	let testFrame : CGRect = CGRectMake(0,200,320,200)
	var testView : UIView = UIView(frame: testFrame)
	testView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
	testView.alpha=0.5
	self.view.addSubview(testView)


	// Add didTapButton action    
	btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
	func didTapButton(sender: AnyObject?) {        
	    let button = sender as! KeyLevelButton
	    let title = button.title(for:.normal)


    
    

    
    
    

	
	
	
	
	

