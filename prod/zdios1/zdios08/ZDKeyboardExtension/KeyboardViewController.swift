//
//  KeyboardViewController.swift
//  ZiDianKeyboard
//
//  Created by Richard Feng on 27/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
   
    //========================================================================
    // Data Members
    let contentVC : KeyLevelViewController = KeyLevelViewController()
    let commander = Commander()    
    let toolbarView : ToolbarView = ToolbarView()
    let contentView: KeyLevelView = KeyLevelView()    
   
    //========================================================================
    // overrides    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addToolBarView()        
        addContentView()
        
        contentVC.view = contentView
        contentVC.commander = commander        
     	commander.mainVC = self
    	commander.contentVC = contentVC
        commander.textDocumentProxy =  self.textDocumentProxy
        commander.drawDefault();
       
    }  // end of func    
    
    override func viewDidLayoutSubviews() {
       
        let toolbarWidth:CGFloat = self.view.frame.size.width - self.paddingLeft - self.paddingRight
        let frm:CGRect =  CGRect(x: self.paddingLeft, y: self.paddingTop, width: toolbarWidth, height: self.toolbarHeight)
        self.toolbarView.frame = frm
        
        let contentWidth:CGFloat = self.view.frame.size.width - self.paddingLeft - self.paddingRight
        let contentTop:CGFloat = self.paddingTop + self.toolbarHeight + self.gap
        let contentHeight:CGFloat = self.view.frame.size.height - contentTop - self.paddingBottom
        
        let frm1:CGRect =  CGRect(x: self.paddingLeft, y: contentTop, width: contentWidth, height:contentHeight)
        self.contentView.frame = frm1
        
        self.commander.reportViewTransition()
    }
    
    //========================================================================
    // Add Sub Views    
    let toolbarHeight:CGFloat = 60
    let paddingLeft:CGFloat = 5
    let paddingRight:CGFloat = 5
    let paddingTop:CGFloat = 0
    let paddingBottom:CGFloat = 0
    let gap:CGFloat = 0
    
    func addToolBarView() {
        let toolbarWidth:CGFloat = self.view.frame.width - paddingLeft - paddingRight
        let frm:CGRect =  CGRect(x: paddingLeft, y: paddingTop, width: toolbarWidth, height: toolbarHeight)
        toolbarView.frame = frm
        toolbarView.mainVC = self
        self.view.addSubview(toolbarView)
        
    }
    	
    func addContentView() {
       	let contentWidth:CGFloat = self.view.frame.width - paddingLeft - paddingRight
        let contentTop:CGFloat = paddingTop + toolbarHeight + gap
        let contentHeight:CGFloat = self.view.frame.height - contentTop - paddingBottom
        
        let frm:CGRect =  CGRect(x: paddingLeft, y: contentTop, width: contentWidth, height: contentHeight)
        contentView.frame = frm
        contentView.isScrollEnabled = true
        contentView.isUserInteractionEnabled = true
        contentView.showsVerticalScrollIndicator = true
        contentView.contentVC = contentVC
        self.view.addSubview(contentView)
        
    }
    //========================================================================
    // Report to Commander
    func tapToolbarButton(_ button : ToolbarButton?) {
        //print("DB-" + tbBtn.buttonName)
        commander.reportTap_ToolbarButton((button?.buttonName)!)
    }
    //
    //========================================================================
	// Operations: will be called from commander	
	func gotoNextIMe(){
    	self.advanceToNextInputMode();
    }
    func closeIME(){
    	self.dismissKeyboard();
    }
    //========================================================================
	   
} // end of class

/*

 */


