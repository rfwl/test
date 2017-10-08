//
//  ViewController.swift
//  zdios03
//
//  Created by Richard Feng on 3/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var toolbarView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
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
        populateCommander()
        
        commander.drawDefault()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //==========================================================
    //
    let toolbarVC:ToolbarViewController = ToolbarViewController()
    let contentVC:KeyLevelViewController = KeyLevelViewController()
    let characterVC:ToolbarCharacterViewController = ToolbarCharacterViewController()
    let hanziVC:ToolbarHanziViewController = ToolbarHanziViewController()
    let specialKeyVC:ToolbarSpecialKeyViewController = ToolbarSpecialKeyViewController()
    let IMEKeyVC:ToolbarIMEKeyViewController = ToolbarIMEKeyViewController()
    //==========================================================
    //
    let commander = Commander()
    
    func populateCommander() {
    	commander.mainVC = self
    	commander.toolbarVC = toolbarVC
    	commander.contentVC = contentVC		
    	
    	toolbarVC.commander = commander
    	contentVC.commander = commander
    	characterVC.commander = commander		
    	hanziVC.commander = commander
    	specialKeyVC.commander = commander
    	IMEKeyVC.commander = commander
    	
    }
    
   
    //==========================================================
    //
    let toolBarHeight:CGFloat = 46
    let paddingLeft:CGFloat = 5
    let paddingRight:CGFloat = 5
    let paddingTop:CGFloat = 25
    let paddingBottom:CGFloat = 5
    let gap:CGFloat = 0
    
    func addToolBarViewController() {
        
        toolbarVC.view = toolbarView
        let toolbarWidth:CGFloat = self.view.bounds.width - paddingLeft - paddingRight
        let frm:CGRect =  CGRect(x: paddingLeft, y: paddingTop, width: toolbarWidth, height: toolBarHeight)
        toolbarVC.view.frame = frm
        toolbarVC.willMove(toParentViewController: self)
        self.addChildViewController(toolbarVC)
        self.view.addSubview(toolbarVC.view)
        toolbarVC.addButtons()
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
        self.addChildViewController(contentVC)
        self.view.addSubview(contentVC.view)        
        contentVC.didMove(toParentViewController:self)
    }
    //==========================================================
    //
    let popoverWidth:CGFloat = 160
    let popoverMinHeight:CGFloat = 230
   	let popoverGap:CGFloat = 2
    
   	let popoverPaddingLeft:CGFloat = 5
    let popoverPaddingRight:CGFloat = 5
    let popoverPaddingTop:CGFloat = 5
    let popoverPaddingBootom:CGFloat = 5
    
    let popoverBackgroundColor = UIColor(red: 0.85, green: 0.75, blue: 0.75, alpha: 1.0)
    
    func prepareCharacterPopoverView(){
        let btn:ToolbarButton = toolbarVC.characterButton
        let left:CGFloat = toolbarView.frame.origin.x + btn.frame.origin.x
        let top:CGFloat = toolbarView.frame.origin.y + toolbarView.frame.height
        let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, height: popoverMinHeight)
        characterPopoverView.frame = frm
        characterPopoverView.backgroundColor = popoverBackgroundColor
    }
    
    func prepareHanziPopoverView(){
        let btn:ToolbarButton = toolbarVC.hanziButton
        let left:CGFloat = toolbarView.frame.origin.x + btn.frame.origin.x
        let top:CGFloat = toolbarView.frame.origin.y + toolbarView.frame.height
        let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, height: popoverMinHeight)
        hanziPopoverView.frame = frm
        hanziPopoverView.backgroundColor = popoverBackgroundColor
    }
    
    func prepareSpecialKeyPopoverView(){
        let btn:ToolbarButton = toolbarVC.specialKeyButton
        let left:CGFloat = toolbarView.frame.origin.x + btn.frame.origin.x + btn.frame.width - popoverWidth
        let top:CGFloat = toolbarView.frame.origin.y + toolbarView.frame.height
        let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, height: popoverMinHeight)
        specialKeyPopoverView.frame = frm
        specialKeyPopoverView.backgroundColor = popoverBackgroundColor
    }
    
    func prepareIMEKeyPopoverView(){
        //let btn:ToolbarButton = toolbarVC.IMEKeyButton
        let left:CGFloat = toolbarView.frame.width - popoverWidth
        let top:CGFloat = toolbarView.frame.origin.y + toolbarView.frame.height
        let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, height: popoverMinHeight)
        IMEKeyPopoverView.frame = frm
        IMEKeyPopoverView.backgroundColor = popoverBackgroundColor
    }
    
    //==========================================================
    // characterPopoverView hanziPopoverView specialKeyPopoverView IMEKeyPopoverView    
   	
    func openCharacterPopoverView(){
        characterVC.view = characterPopoverView
        characterVC.willMove(toParentViewController: self)
        self.addChildViewController(characterVC)
        self.view.addSubview(characterVC.view)
        characterVC.addButtons()
        characterVC.didMove(toParentViewController:self)
    }
    func closeCharacterPopoverView(){
        characterVC.removeFromParentView()
    }
    
    
    func openHanziPopoverView(){
        hanziVC.view = hanziPopoverView
        hanziVC.willMove(toParentViewController: self)
        self.addChildViewController(hanziVC)
        self.view.addSubview(hanziVC.view)
        hanziVC.addButtons()
        hanziVC.didMove(toParentViewController:self)
    }
    func closeHanziPopoverView(){
        hanziVC.removeFromParentView()
    }
    
    
    func openSpecialKeyPopoverView(){
        specialKeyVC.view = specialKeyPopoverView
        specialKeyVC.willMove(toParentViewController: self)
        self.addChildViewController(specialKeyVC)
        self.view.addSubview(specialKeyVC.view)
        specialKeyVC.addButtons()
        specialKeyVC.didMove(toParentViewController:self)
    }
    func closeSpecialKeyPopoverView(){
        specialKeyVC.removeFromParentView()
    }
    
    
    func openIMEKeyPopoverView(){
        IMEKeyVC.view = IMEKeyPopoverView
        IMEKeyVC.willMove(toParentViewController: self)
        self.addChildViewController(IMEKeyVC)
        self.view.addSubview(IMEKeyVC.view)
        IMEKeyVC.addButtons()
        IMEKeyVC.didMove(toParentViewController:self)
    }
    func closeIMEKeyPopoverView(){
        IMEKeyVC.removeFromParentView()
    }
  
    
   //==========================================================
    
    
} // end of class



