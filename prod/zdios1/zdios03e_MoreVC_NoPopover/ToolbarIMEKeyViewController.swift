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

	var commander:Commander?
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
    //
    
     
    func addButtons(){
        
    	var frm:CGRect = CGRect(x: 10, y: 2, width: 100 , height: 40)  
    	let closeIMEButton:ToolbarMenuButton = ToolbarMenuButton(frame:frm)
    	closeIMEButton.setTitle("Close", for: .normal)
    	closeIMEButton.addTarget(self, action: #selector(didTap_closeIMEButton), for: .touchUpInside)
    	self.view.addSubview(closeIMEButton)
    	
        frm = CGRect(x: 10, y: 44, width: 100 , height: 40)  
        let nextIMEButton:ToolbarMenuButton = ToolbarMenuButton(frame:frm)
        nextIMEButton.setTitle("Next", for: .normal)
        nextIMEButton.addTarget(self, action: #selector(didTap_nextIMEButton), for: .touchUpInside)
    	self.view.addSubview(nextIMEButton)
    	
        frm = CGRect(x: 10, y: 86, width: 100 , height: 40)  
        let prevIMEButton:ToolbarMenuButton = ToolbarMenuButton(frame:frm)
        prevIMEButton.setTitle("Prev", for: .normal)
        prevIMEButton.addTarget(self, action: #selector(didTap_prevIMEButton), for: .touchUpInside)
    	self.view.addSubview(prevIMEButton)    	    
    }
    //=================================================================
    //
    func removeFromParentView(){
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    //=================================================================
    //
	func didTap_closeIMEButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarMenuButton
	    let title = button.title(for:.normal)
	    
	
	}
	
	func didTap_nextIMEButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarMenuButton
	    let title = button.title(for:.normal)
	    
	
	}
	
	func didTap_prevIMEButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarMenuButton
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


