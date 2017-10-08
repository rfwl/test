//
//  ZDAppViewController.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 12/10/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
//
import Foundation
import UIKit

class ZDAppViewController: UIViewController {

	//==========================================================
	// MARK: Properties
	@IBOutlet var MainView: UIView!
    
    @IBOutlet weak var toolbarView: UIView!
    
    @IBOutlet weak var contentView: UIScrollView!
    
    @IBOutlet weak var characterPopoverView: UIView!
    
    @IBOutlet weak var hanziPopoverView: UIView!
    
    @IBOutlet weak var specialKeyPopoverView: UIView!
    
    @IBOutlet weak var IMEKeyPopoverView: UIView!
    //==========================================================
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addToolBarViewController()
        addContentViewController()
        prepareCharacterPopoverView() 
        prepareHanziPopoverView() 
        prepareSpecialKeyPopoverView() 
        prepareIMEKeyPopoverView()           
    }  
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //==========================================================
    //        
    let toolBarHeight:CGFloat = 46     	    	    
    let paddingLeft:CGFloat = 5
    let paddingRight:CGFloat = 5	    	     
    let paddingTop:CGFloat = 5
    let paddingBootom:CGFloat = 5    				
    let gap:CGFloat = 2
	
    let toolbarVC:ToolbarViewController = ToolbarViewController()    
    let contentVC:ContentViewController = ContentViewController()
    
    func addToolBarViewController() {
      	        
        toolbarVC.view = toolbarView
        let toolbarWidth:CGFloat = self.view.bounds.width - paddingLeft - paddingRight
        let frm:CGRect =  CGRect(x: paddingLeft, y: paddingTop, width: toolbarWidth, height: toolBarHeight)  
        toolbarVC.view.frame = frm
		toolbarVC.willMove(toParentViewController: self)
        self.view.addSubview(toolbarVC.view)
        self.addChildViewController(toolbarVC)
        toolbarVC.didMove(toParentViewController:self)
    }
    
    func addContentViewController() {
    
    	contentVC.view = contentView
        
    	let contentWidth:CGFloat = self.view.bounds.width - paddingLeft - paddingRight 
        let contentTop:CGFloat = paddingTop + toolBarHeight + gap
        let contentHeight:CGFloat = self.view.bounds.height - contentTop - paddingBottom
        
        let frm:CGRect =  CGRect(x: paddingLeft, y: contentTop, width: contentWidth, height: contentHeight)  
        contentVC.view.frame = frm
		contentVC.willMove(toParentViewController: self)
        self.view.addSubview(contentVC.view)
        self.addChildViewController(contentVC)
        contentVC.didMove(toParentViewController:self)    	
    }
    //==========================================================
    //     
    let popoverWidth:CGFloat = 160    
    let popoverMinHeight:CGFloat = 108
   	let popoverGap:CGFloat = 2
    
   	let popoverPaddingLeft:CGFloat = 5    
    let popoverPaddingRight:CGFloat = 5	    	     
    let popoverPaddingTop:CGFloat = 5
    let popoverPaddingBootom:CGFloat = 5
    
    let popoverBackgroundColor = UIColor(red: 0.85, green: 0.75, blue: 0.75, alpha: 1.0)
	
    //==========================================================
    //  
    func prepareCharacterPopoverView(){
    	let btn:ToolbarButton = toolBarViewController.characterButton
    	let left:CGFloat = toolBarView.frame.x + btn.frame.x
    	let top:CGFloat = toolBarView.frame.y + btn.frame.y
    	let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, popoverMinHeight)
    	characterPopoverView.frame = frm		
		characterPopoverView.backgroundColor = popoverBackgroundColor
    }
    
	func prepareHanziPopoverView(){
    	let btn:ToolbarButton = toolBarViewController.hanziButton
    	let left:CGFloat = toolBarView.frame.x + btn.frame.x
    	let top:CGFloat = toolBarView.frame.y + btn.frame.y
    	let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, popoverMinHeight)
    	characterPopoverView.frame = frm		
		characterPopoverView.backgroundColor = popoverBackgroundColor
    } 
	
	func prepareSpecialKeyPopoverView(){
    	let btn:ToolbarButton = toolBarViewController.specialKeyButton
    	let left:CGFloat = toolBarView.frame.x + btn.frame.x + btn.frame.width - popoverWidth
    	let top:CGFloat = toolBarView.frame.y + btn.frame.y
    	let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, popoverMinHeight)
    	specialKeyPopoverView.frame = frm		
    	specialKeyPopoverView.backgroundColor = popoverBackgroundColor
    }
	
	func prepareIMEKeyPopoverView(){
    	let btn:ToolbarButton = toolBarViewController.IMEKeyButton
    	let left:CGFloat = toolBarView.frame.width - popoverWidth
    	let top:CGFloat = toolBarView.frame.y + btn.frame.y
    	let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, popoverMinHeight)
    	IMEKeyPopoverView.frame = frm		
    	IMEKeyPopoverView.backgroundColor = popoverBackgroundColor
    }
    	
	//==========================================================
    // characterPopoverView hanziPopoverView specialKeyPopoverView IMEKeyPopoverView
    
    let characterVC:ToolbarCharacterViewController = ToolbarCharacterViewController()    
    func openCharacterPopoverView(){
        characterVC.mainVC = this
        characterVC.view = characterPopoverView
        characterVC.willMove(toParentViewController: self)
        self.view.addSubview(characterVC.view)
        self.addChildViewController(characterVC)
        characterVC.didMove(toParentViewController:self)
    }
    func closeCharacterPopoverView(){
        characterVC.removeFromParentView()
    }
    
    let hanziVC:ToolbarHanziViewController = ToolbarHanziViewController()    
    func openHanziView(){
        hanziVC.view = hanziPopoverView
        hanziVC.willMove(toParentViewController: self)
        self.view.addSubview(hanziVC.view)
        self.addChildViewController(hanziVC)
        hanziVC.didMove(toParentViewController:self)
    }
    func closeHanziPopoverView(){
        hanziVC.removeFromParentView()
    }
	
	let specialKeyVC:ToolbarSpecialKeyViewController = ToolbarSpecialKeyViewController()    
    func openSpecialKeyView(){
        specialKeyVC.view = specialKeyPopoverView
        specialKeyVC.willMove(toParentViewController: self)
        self.view.addSubview(specialKeyVC.view)
        self.addChildViewController(specialKeyVC)
        specialKeyVC.didMove(toParentViewController:self)
    }
    func closeSpecialKeyPopoverView(){
        specialKeyVC.removeFromParentView()
    }
	
	let IMEKeyVC:ToolbarIMEKeyViewController = ToolbarIMEKeyViewController()    
    func openIMEKeyView(){
        IMEKeyVC.view = IMEKeyPopoverView
        IMEKeyVC.willMove(toParentViewController: self)
        self.view.addSubview(IMEKeyVC.view)
        self.addChildViewController(IMEKeyVC)
        IMEKeyVC.didMove(toParentViewController:self)
    }
    func closeIMEKeyPopoverView(){
        IMEKeyVC.removeFromParentView()
    }
    //==========================================================
    //
    
} //end of class

/*
    
    func openHanziPopoverView(){
        self.view.addSubView(this.hanziPopoverView);
    }
    func closeHanziPopoverView(){
        self.view.removeSubView(this.hanziPopoverView);
    }
    func openHanziPopoverView(){
        self.view.addSubView(this.specialKeyPopoverView);
    }
    func closeHanziPopoverView(){
        self.view.removeSubView(this.specialKeyPopoverView);
    }
    func openIMEKeyPopoverView(){
        self.view.addSubView(this.IMEKeyPopoverView);
    }
    func closeIMEKeyPopoverView(){
        self.view.removeSubView(this.IMEKeyPopoverView);
    }
	
    
    
    
    
    // Add child view controller
        let vcChild:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "ChildViewController")
        //vcChild.ANYPROPERTY=THEVALUE // If you want to pass value
        
        vcChild.view.frame = CGRect(x: 0, y: 140, width: 260, height: 100)  //self.view.bounds;
        vcChild.willMove(toParentViewController: self)
        self.view.addSubview(vcChild.view)
        self.addChildViewController(vcChild)
        vcChild.didMove(toParentViewController:self)
        
        // Remove child view controller
        //self.willMoveToParentViewController(nil)
        //self.view.removeFromSuperview()
        //self.removeFromParentViewController()
        
        // Add child view controller
        
        // Could not find the view controller defined in another target in the same project
        // let vcChild1:Child1ViewController = Child1ViewController()
        
        //let vcChild1:KeyLevelViewController = KeyLevelViewController()
        //vcChild1.view = self.KeyLevelView
        vcChild1.view.frame = CGRect(x: 0, y: 240, width: 260, height: 100)  //self.view.bounds;
        vcChild1.willMove(toParentViewController: self)
        self.view.addSubview(vcChild1.view)
        self.addChildViewController(vcChild1)
        vcChild1.didMove(toParentViewController:self)
        
    // MARK: Actions
    @IBAction func down(_ sender: Any) {
        msglbl.text = "Down Down"
        /*
        let vcChild1:ToolbarViewController = ToolbarViewController()
        
        //vcChild1.view = self.ToolbarView
        
        vcChild1.view.frame = CGRect(x: 0, y: 240, width: 260, height: 100)  //self.view.bounds;
        vcChild1.willMove(toParentViewController: self)
        self.view.addSubview(vcChild1.view)
        self.addChildViewController(vcChild1)
        vcChild1.didMove(toParentViewController:self)
    
    @IBAction func up(_ sender: Any) {
        msglbl.text = "Touch Up"
    }
    
    @IBAction func CharDown(_ sender: UIButton) {
        msglbl.text = "Char Down"
    }

*/
        

