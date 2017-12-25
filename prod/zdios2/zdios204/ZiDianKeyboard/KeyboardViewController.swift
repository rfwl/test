//
//  KeyboardViewController.swift
//  ZiDianKeyboard
//
//  Created by Richard Feng on 27/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//
///https://stackoverflow.com/questions/26180822/swift-adding-constraints-programmatically
//
import Foundation
import UIKit

class KeyboardViewController: UIInputViewController {
    
    //========================================================================
    // Data Members
    let toolbarView:ToolbarView =  ToolbarView()
    let predictionContainerView:PredictionContainerView  = PredictionContainerView()
    let keyboardView:KeyboardView = KeyboardView()
    let popUpCellBuilderView:PopUpCellBuilderView  = PopUpCellBuilderView()
    let popUpCellEditorView:PopUpCellEditorView  = PopUpCellEditorView()
    let popUpContainerView:PopUpContainerView  = PopUpContainerView()
    
    //========================================================================
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        //Commander.textDocumentProxy = self.textDocumentProxy
        //Commander.keyboardViewController = self
        //Configuration.compute()
        //layoutSubviews()
        //self.view.addSubview(toolbarView)
        //toolbarView.backgroundColor = UIColor.yellow
        //layoutTopAreaSubviews(toolbarView)
        //toolbarView.isHidden = true
        
    }
    var constraintsAdded:Bool = false
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
        //updateContentViewHeight()
        //Commander.reportViewTransition()
        if constraintsAdded {
            addSubviews(EnumViewState.Default)
            self.view.setNeedsLayout()
            self.view.updateConstraints()
        } else {
            constraintsAdded = true
            loadSubviews(EnumViewState.Default)
        }
        Commander.keyboardView = self.keyboardView
        Commander.popUpContainerView = self.popUpContainerView
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.view.layoutIfNeeded()
        //try! Commander.startUp()
        //loadSubviews(EnumViewState.Default)
        //let safeInsets = self.view.safeAreaInsets
        //let rectTotalArea = self.view.bounds
        //toolbarView = ToolbarView(frame : rectTotalArea)
       
        //self.view.layoutIfNeeded()
        //print(self.toolbarView.frame)
        //print(rectTotalArea)
        //loadSubviews(EnumViewState.Default)
        try? Commander.startUp()
    }
    
    override func updateViewConstraints() {
        print("updateViewConstraints")
    	//From generated custom keyboard project template
        super.updateViewConstraints()
        // Add custom view sizing constraints here
       
        //self.view.layoutIfNeeded()
    }
    
    //========================================================================
    // Layout subviews
    func addSubview_TopArea(_ vw:UIView){
        vw.backgroundColor = UIColor.yellow
        self.view.addSubview(vw)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        vw.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        vw.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        vw.heightAnchor.constraint(equalToConstant: Settings.Top_Area_Height).isActive = true
    }
    
    func addSubview_ContentArea(_ vw:UIView){
        vw.backgroundColor = UIColor.purple
        self.view.addSubview(vw)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        vw.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        vw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        let dif:CGFloat = self.view.frame.height - Settings.Top_Area_Height
        vw.heightAnchor.constraint(equalToConstant: dif).isActive = true
    }
    
    func addSubview_WholeArea(_ vw:UIView){
        vw.backgroundColor = UIColor.clear
        self.view.addSubview(vw)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        vw.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        vw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        vw.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
   
    //========================================================================
    // Operations: Selectively show subviews
    // View states: 
    // 1> Default: toolbar + keyboard + popUpContainer 
    // 2> selecting popUpCell: prediction + keyboard + popUpContainer 
    // 3> building popUpCell: toolbar + keyboard + popUpContainer + popUpCell builder
    // 4> editing popUpCell:  toolbar + keyboard + popUpContainer + popUpCell editor
    
    enum EnumViewState {
    	case Default
    	case SelectingPopUpCell
    	case BuildingPopUpCell
    	case EditingPopUpCell   
	} //end of enum
    
    func loadSubviews(_ viewState: EnumViewState){
    	self.view.clearSubviews()
        addSubview_TopArea(toolbarView)
        addSubview_ContentArea(keyboardView)
        addSubview_WholeArea(popUpContainerView)
        
    	switch viewState {
            case .SelectingPopUpCell:
                addSubview_TopArea(predictionContainerView)
            case .BuildingPopUpCell:
                addSubview_ContentArea(popUpCellBuilderView)
            case .EditingPopUpCell:
                addSubview_ContentArea(popUpCellEditorView)
            case .Default: break
 		}   
    } //end of func
    
    func addSubviews(_ viewState: EnumViewState){
        self.view.clearSubviews()
        self.view.addSubview(toolbarView)
        self.view.addSubview(keyboardView)
        self.view.addSubview(popUpContainerView)
        
        switch viewState {
        case .SelectingPopUpCell:
            self.view.addSubview(predictionContainerView)
        case .BuildingPopUpCell:
            self.view.addSubview(popUpCellBuilderView)
        case .EditingPopUpCell:
            self.view.addSubview(popUpCellEditorView)
        case .Default: break
        }
    } //end of func
    
    //========================================================================
    // Other operations: will be called from commander
    
    func gotoNextKeyboard(){
        self.advanceToNextInputMode();
    }
    func closeKeyboard(){
        self.dismissKeyboard();
    }
    //========================================================================
    
} // end of class

/*
    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
 */



