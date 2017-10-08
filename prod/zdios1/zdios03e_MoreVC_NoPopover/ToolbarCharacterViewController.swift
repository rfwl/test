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
    	let numberButton:ToolbarMenuButton = ToolbarMenuButton(frame:frm)
    	numberButton.setTitle("Num", for: .normal)
    	numberButton.addTarget(self, action: #selector(didTap_numberButton), for: .touchUpOutside)
    	self.view.addSubview(numberButton)
    	
        frm = CGRect(x: 10, y: 44, width: 100 , height: 40)  
    	let alphabetButton:ToolbarMenuButton = ToolbarMenuButton(frame:frm)
    	alphabetButton.setTitle("Aa", for: .normal) 
    	alphabetButton.addTarget(self, action: #selector(didTap_alphabetButton), for: .touchUpOutside)
    	self.view.addSubview(alphabetButton)
    	
        frm = CGRect(x: 10, y: 86, width: 100 , height: 40)  
    	let symbolButton:ToolbarMenuButton = ToolbarMenuButton(frame:frm)
    	symbolButton.setTitle("*&$", for: .normal)
    	symbolButton.addTarget(self, action: #selector(didTap_symbolButton), for: .touchUpOutside)
    	self.view.addSubview(symbolButton)    	    
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
	func didTap_numberButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarMenuButton
	    let title = button.title(for:.normal)
	    commander?.drawNumberKeyLevel()
	
	}
	
	func didTap_alphabetButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarMenuButton
	    let title = button.title(for:.normal)
	    commander?.drawAlphabetKeyLevel()
	
	}
	
	func didTap_symbolButton(sender: AnyObject?) {        
	    let button = sender as! ToolbarMenuButton
	    let title = button.title(for:.normal)
	    commander?.drawSymbolKeyLevel()
	
	}
	
    //=================================================================
    
    
    
    
    
    
    
} //end of class
/*
 1> Character
1.1 > Numeric, plus most-used-symbols,  Stay on Page. 
1.2 > Alphabet, plus Shift button  and most-used-symbols Stay on Page
1.3 > Symbol. Go Back to Hanzi PI Page once clicked

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
