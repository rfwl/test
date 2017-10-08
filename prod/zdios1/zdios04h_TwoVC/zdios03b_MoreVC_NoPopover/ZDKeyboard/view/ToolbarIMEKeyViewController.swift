//
//  ToolbarIMEKeyViewController.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 12/10/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
//
import Foundation
import UIKit

class ToolbarIMEKeyViewController: UIViewController {

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
    let closeIMEButton:ToolbarMenuButton = ToolbarMenuButton(defaultFrame)
    let nextIMEButton:ToolbarMenuButton = ToolbarMenuButton(defaultFrame)
    let prevIMEButton:ToolbarMenuButton = ToolbarMenuButton(defaultFrame)
     
    funct addButtons(){
        
    	var frm:CGRect = CGRect(x: 10, y: 2, width: 100 , height: 40)  
    	closeIMEButton.frame = frm
    	closeIMEButton.setTitle("Num", for: .normal)  
    	closeIMEButton.addTarget(self, action: #selector(didTap_closeIMEButton), for: .touchUpInside)
    	self.view.addSubview(closeIMEButton)
    	
        frm = CGRect(x: 10, y: 44, width: 100 , height: 40)  
        nextIMEButton.frame = frm
        nextIMEButton.setTitle("Aa", for: .normal)  
        nextIMEButton.addTarget(self, action: #selector(didTap_nextIMEButton), for: .touchUpInside)
    	self.view.addSubview(nextIMEButton)
    	
        frm = CGRect(x: 10, y: 86, width: 100 , height: 40)  
        prevIMEButton.frame = frm
        prevIMEButton.setTitle("*&$", for: .normal) 
        prevIMEButton.addTarget(self, action: #selector(didTap_prevIMEButton), for: .touchUpInside)
    	self.view.addSubview(prevIMEButton)    	    
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
	func didTap_closeIMEButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
	    
	
	}
	
	func didTap_nextIMEButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
	    
	
	}
	
	func didTap_prevIMEButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarButton
	    let title = button.title(for:.normal)
	    
	
	}	
	
    //=================================================================
    
} //end of class
/*


4> IME Buttons

4.1 > Close IME

4.2 > Next IME

4.3 > Prev IME

4.4 > IME Setting Application(Not Now)
*/ 


