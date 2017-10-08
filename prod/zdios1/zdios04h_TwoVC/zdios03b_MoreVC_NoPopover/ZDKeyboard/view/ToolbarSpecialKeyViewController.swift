//
//  ToolbarSpecialKeyViewController.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 12/10/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
//
import Foundation
import UIKit

class ToolbarSpecialKeyViewController: UIViewController {

    //=================================================================    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
        addButtons()
    } 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    //=================================================================
    //
    let defaultFrame:CGRect = CGRect(x: 0, y: 0, width: 100 , height: 40)  
    let enterButton:ToolbarMenuButton = ToolbarMenuButton(defaultFrame)
    let backspaceButton:ToolbarMenuButton = ToolbarMenuButton(defaultFrame)
    let spaceButton:ToolbarMenuButton = ToolbarMenuButton(defaultFrame)
	let commaButton:ToolbarMenuButton = ToolbarMenuButton(defaultFrame)
	let periodButton:ToolbarMenuButton = ToolbarMenuButton(defaultFrame)
    		    			    	     
    funct addButtons(){
        
    	var frm:CGRect = CGRect(x: 10, y: 2, width: 100 , height: 40)  
    	enterButton.frame = frm
    	enterButton.setTitle("Enter", for: .normal)
    	enterButton.addTarget(self, action: #selector(didTap_enterButton), for: .touchUpInside)
    	self.view.addSubview(enterButton)
    	
        frm = CGRect(x: 10, y: 44, width: 100 , height: 40)  
   		backspaceButton.frame = frm
		backspaceButton.setTitle("BS", for: .normal)  
		backspaceButton.addTarget(self, action: #selector(didTap_backspaceButton), for: .touchUpInside)
    	self.view.addSubview(backspaceButton)
    	
        frm = CGRect(x: 10, y: 86, width: 100 , height: 40)  
   		spaceButton.frame = frm
		spaceButton.setTitle("*Space", for: .normal)
		spaceButton.addTarget(self, action: #selector(didTap_spaceButton), for: .touchUpInside)
    	self.view.addSubview(spaceButton)    	    
    	
        frm = CGRect(x: 10, y: 140, width: 100 , height: 40)  
        commaButton.frame = frm
        commaButton.setTitle("*Space", for: .normal) 
        commaButton.addTarget(self, action: #selector(didTap_commaButton), for: .touchUpInside)
     	self.view.addSubview(commaButton)       	
    	
        frm = CGRect(x: 10, y: 184, width: 100 , height: 40)  
        periodButton.frame = frm
        periodButton.setTitle("*Space", for: .normal)
        periodButton.addTarget(self, action: #selector(didTap_periodButton), for: .touchUpInside)
     	self.view.addSubview(periodButton)    
     	
    }
	

    //=================================================================
    //
    func removeFromParentView(){
        self.willMoveToParentViewController(nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    //=================================================================
    //
	func didTap_enterButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
	    
	
	}
	
	func didTap_backspaceButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
	    
	
	}
	
	func didTap_spaceButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
	    
	
	}
	
	func didTap_commaButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
	    
	
	}
	
	func didTap_periodButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
	    
	
	}
	
    //=================================================================
    //=================================================================
} //end of class
/*

3> Special-Keys

3.1 > Enter 

3.2 > Backspace

3.3 > Space

3.4 > ,

3.5 > .

4> IME Buttons

4.1 > Close IME

4.2 > Next IME

4.3 > Prev IME

4.4 > IME Setting Application(Not Now)
*/ 
