//
//  ViewController.swift
//  zdios02
//
//  Created by Richard Feng on 2/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //==========================================================
    // MARK: Properties
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
    let paddingBottom:CGFloat = 5
    let gap:CGFloat = 2
    
    let toolbarVC:ToolbarViewController = ToolbarViewController()
    let contentVC:KeyLevelViewController = KeyLevelViewController()
    
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
        let btn:ToolbarButton = toolBarVC.characterButton
        let left:CGFloat = toolBarView.frame.x + btn.frame.x
        let top:CGFloat = toolBarView.frame.y + btn.frame.y
        let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, popoverMinHeight)
        characterPopoverView.frame = frm
        characterPopoverView.backgroundColor = popoverBackgroundColor
    }
    
    func prepareHanziPopoverView(){
        let btn:ToolbarButton = toolbarVC.hanziButton
        let left:CGFloat = toolbarView.frame.x + btn.frame.x
        let top:CGFloat = toolbarView.frame.y + btn.frame.y
        let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, popoverMinHeight)
        characterPopoverView.frame = frm
        characterPopoverView.backgroundColor = popoverBackgroundColor
    }
    
    func prepareSpecialKeyPopoverView(){
        let btn:ToolbarButton = toolbarVC.specialKeyButton
        let left:CGFloat = toolbarView.frame.x + btn.frame.x + btn.frame.width - popoverWidth
        let top:CGFloat = toolbarView.frame.y + btn.frame.y
        let frm:CGRect =  CGRect(x: left, y: top, width: popoverWidth, popoverMinHeight)
        specialKeyPopoverView.frame = frm
        specialKeyPopoverView.backgroundColor = popoverBackgroundColor
    }
    
    func prepareIMEKeyPopoverView(){
        let btn:ToolbarButton = toolbarVC.IMEKeyButton
        let left:CGFloat = toolbarView.frame.width - popoverWidth
        let top:CGFloat = toolbarView.frame.y + btn.frame.y
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
    
    
    
} // end of class


