//
//  ToolbarHanziViewController.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 12/10/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
//
import Foundation
import UIKit

class ToolbarHanziViewController: UIViewController {

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
        let PIButton:ToolbarMenuButton = ToolbarMenuButton(frame:frm)
    	PIButton.setTitle("PI", for: .normal)  
    	PIButton.addTarget(self, action: #selector(didTap_PIButton), for: .touchUpInside)
    	self.view.addSubview(PIButton)
    	
        frm = CGRect(x: 10, y: 44, width: 100 , height: 40)
        let mostUsedButton:ToolbarMenuButton = ToolbarMenuButton(frame:frm)
    	mostUsedButton.setTitle("Aa", for: .normal)
    	mostUsedButton.addTarget(self, action: #selector(didTap_mostUsedButton), for: .touchUpInside)
    	self.view.addSubview(mostUsedButton)
    	
        frm = CGRect(x: 10, y: 86, width: 100 , height: 40)
        let recentButton:ToolbarMenuButton = ToolbarMenuButton(frame:frm)
    	recentButton.setTitle("Recent", for: .normal)
    	recentButton.addTarget(self, action: #selector(didTap_recentButton), for: .touchUpInside)
    	self.view.addSubview(recentButton)   
    	
    	frm = CGRect(x: 10, y: 140, width: 100 , height: 40)
        let backButton:ToolbarMenuButton = ToolbarMenuButton(frame:frm)
     	backButton.setTitle("Back", for: .normal)
     	backButton.addTarget(self, action: #selector(didTap_backButton), for: .touchUpInside)
     	self.view.addSubview(backButton)  
     	
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
	func didTap_PIButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarMenuButton
	    let title = button.title(for:.normal)
	    commander?.drawDefault()
	
	}
	
	func didTap_mostUsedButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarMenuButton
	    let title = button.title(for:.normal)
	    commander?.drawMostUsedKeyLevel()
	
	}
	
	func didTap_recentButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarMenuButton
	    let title = button.title(for:.normal)
	    commander?.drawRecentKeyLevel()
	
	}
	
	func didTap_backButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarMenuButton
	    let title = button.title(for:.normal)
	    commander?.drawDefault()
	
	}
	
    //=================================================================
} //end of class
/*

2> Hanzi

2.1 > PI

2.2 > Most_Used

2.3 > Recent-Used 

2.4 > Going up, go up a level

2.5 > Custom PH Library[Not Now]

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
