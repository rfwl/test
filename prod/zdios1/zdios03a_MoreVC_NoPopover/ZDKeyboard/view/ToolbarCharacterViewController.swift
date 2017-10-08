//
//  ToolbarCharacterViewController.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 12/10/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
//
import Foundation
import UIKit

class ToolbarCharacterViewController: UIViewController {

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
    let numberButton:ToolbarMenuButton = ToolbarMenuButton()
    let alphabetButton:ToolbarMenuButton = ToolbarMenuButton()
    let symbolButton:ToolbarMenuButton = ToolbarMenuButton()
     
    funct addButtons(){
        
    	var frm:CGRect = CGRect(x: 10, y: 2, width: 100 , height: 40)  
    	numberButton.frame = frm
    	numberButton.setTitle("Num", for: .normal)    	
    	self.view.addSubview(numberButton)
    	
        frm = CGRect(x: 10, y: 44, width: 100 , height: 40)  
    	alphabetButton.frame = frm
    	alphabetButton.setTitle("Aa", for: .normal)    	
    	self.view.addSubview(alphabetButton)
    	
        frm = CGRect(x: 10, y: 86, width: 100 , height: 40)  
    	symbolButton.frame = frm
    	symbolButton.setTitle("*&$", for: .normal)    	
    	self.view.addSubview(symbolButton)    	    
    }
    //=================================================================
    //
    func removeFromParentView(){
        self.willMoveToParentViewController(nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    //=================================================================
} //end of class

