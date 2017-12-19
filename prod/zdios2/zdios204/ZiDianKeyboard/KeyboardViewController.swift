//
//  KeyboardViewController.swift
//  ZiDianKeyboard
//
//  Created by Richard Feng on 27/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//
///https://stackoverflow.com/questions/26180822/swift-adding-constraints-programmatically
//
import UIKit



class KeyboardViewController: UIInputViewController {
    
    //========================================================================
    // Data Members
    let toolbarView : ToolbarView = ToolbarView()
    let predictionContainerView: PredictionContainerView = PredictionContainerView()
    let keyboardView: KeyLevelView = KeyBoardView()
    let popUpCellBuilderView: PopUpCellBuilderView = PopUpCellBuilderView()
    let popUpCellEditorView: PopUpCellEditorView = PopUpCellEditorView()
    let popUpContainerView: PopUpContainerView = PopUpContainerView()
    //========================================================================
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        Commander.contentView = contentView
        Commander.textDocumentProxy = self.textDocumentProxy
        Commander.keyboardViewController = self
        Configuration.compute()
        loadSubviews()
    }
    
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateContentViewHeight()
        Commander.reportViewTransition()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        try! Commander.startUp()        
    }
    
    override func updateViewConstraints() { 
    	//From generated custom keyboard project template
        super.updateViewConstraints()
        // Add custom view sizing constraints here 
    }
    
    //========================================================================
    // Layout subviews
    func layoutSubviews(){
    	layoutPopUpContainerView()
    	layoutTopAreaSubviews(self.toolbarView)
    	layoutTopAreaSubviews(self.predictionContainerView)
    	layoutContentAreaSubviews(self.keyboardView)
    	layoutContentAreaSubviews(self.popUpCellBuilderView)
    	layoutContentAreaSubviews(self.popUpCellEditorView)
    	
    }
    
    func layoutPopUpContainerView(){
    	self.popUpContainerView.translatesAutoresizingMaskIntoConstraints = false      
        self.popUpContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.popUpContainerView.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.popUpContainerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    	self.popUpContainerView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true   
    }
    
    func layoutTopAreaSubviews(vw:UIView){
        vw.translatesAutoresizingMaskIntoConstraints = false       
        vw.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        vw.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        vw.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        vw.heightAnchor.constraint(equalToConstant: Configuration.Toolbar_Height).isActive = true
    }    
    
    func layoutContentAreaSubviews(vw:UIView){        
        vw.translatesAutoresizingMaskIntoConstraints = false      
        vw.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        vw.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        vw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        let dif:CGFloat = self.view.frame.height.subtracting(Configuration.Toolbar_Height)
        contentAreaViewHeightConstraint = vw.heightAnchor.constraint(equalToConstant: dif )
    }
    
    var contentAreaViewHeightConstraint : NSLayoutConstraint?     
    func updateSubviewHeight(){
        let dif:CGFloat = self.view.frame.height.subtracting(Configuration.Toolbar_Height)
        contentViewHeightConstraint?.constant = dif
        contentViewHeightConstraint!.isActive = true
        self.view.layoutIfNeeded()
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
    
    func loadSubviews(viewState: EnumViewState?){
    	self.clearSubviews()
    	switch viewState {
        case 
        case .SelectingPopUpCell: {
        	self.view.addSubview(toolbarView)
    		self.view.addSubview(predictionContainerView)
        } 
        case .BuildingPopUpCell: {
        	self.view.addSubview(toolbarView)
    		self.view.addSubview(popUpCellBuilderView)
        } 
        case .EditingPopUpCell:{
        	self.view.addSubview(toolbarView)    		
    		self.view.addSubview(popUpCellEditorView)
        }  
        case .Default: loadDefaultSubviews()
        case nil: loadDefaultSubviews() 
        default: loadDefaultSubviews()
 		}   
    } //end of func
      
    func loadDefaultSubviews(){
    	self.view.addSubview(toolbarView)
    	self.view.addSubview(keyboardView)
    	self.view.addSubview(popUpContainerView)
    }
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



