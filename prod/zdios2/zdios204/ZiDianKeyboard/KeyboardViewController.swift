//
//  KeyboardViewController.swift
//  ZiDianKeyboard
//
//  Created by Wanlou Feng on 17/12/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

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

} // end of class



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
    let contentView: KeyLevelView = KeyLevelView()
    //========================================================================
    // overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        Commander.contentView = contentView
        Commander.textDocumentProxy = self.textDocumentProxy
        Commander.keyboardViewController = self
        Configuration.compute()
        loadToolbarAndContentViews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateContentViewHeight()
        Commander.reportViewTransition()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        Commander.drawDefault()
    }
    //========================================================================
    // Add and layout toolbar and content view
    var contentViewHeightConstraint:NSLayoutConstraint?
    func loadToolbarAndContentViews(){
        self.toolbarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.toolbarView)
        self.toolbarView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.toolbarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.toolbarView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.toolbarView.heightAnchor.constraint(equalToConstant: Configuration.Toolbar_Height).isActive = true
        
        //------------------------------------------------------------------
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        //self.contentView.backgroundColor = UIColor.red
        
        self.view.addSubview(self.contentView)
        //self.contentView.topAnchor.constraint(equalTo: self.toolbarView.topAnchor, constant: Configuration.Toolbar_Height).isActive = true
        self.contentView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalToConstant: 120 )
    }
    func updateContentViewHeight(){
        let dif:CGFloat = self.view.frame.height.subtracting(Configuration.Toolbar_Height)
        contentViewHeightConstraint?.constant = dif
        contentViewHeightConstraint!.isActive = true
        self.view.layoutIfNeeded()
    }
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
 
 // The next is required to give right height to content view after screen rotations.
 //self.view.layoutIfNeeded()
 //let dif:CGFloat = self.view.frame.height.subtracting( self.toolbarHeight) // This line must be in viewDidAppear() since it has used self.frame.height.
 //print("viewDidLayoutSubviews")
 //
 //constraint!.constant = 120
 //self.view.layoutIfNeeded()
 
 //var mNumberKeyLevel:[KeyLevel]? = buildKeyLevelArrayFromCommaSeparatedString(numberKeyLevelDefinition)
 //var mAlphabetKeyLevel:[KeyLevel]? = buildKeyLevelArrayFromCommaSeparatedString(alphabetKeyLevelDefinition)
 //let mSymbolKeyLevel:[KeyLevel]? = buildKeyLevelArrayFromCommaSeparatedString(symbolKeyLevelDefinition)
 //contentView.drawKeyLevelArray(mSymbolKeyLevel)
 
 let numberKeyLevelDefinition:String = "0,1,2,3,4,5,6,7,8,9,+,-,*,/,=,comma, ,?"
 let alphabetKeyLevelDefinition:String = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,+,-,*,/,=,comma"
 let symbolKeyLevelDefinition:String = "!,@,#,$,%,^,&,*,(,),_,+,{,},[,],<,>,/,comma, ,"
 
 
 
 func buildKeyLevelArrayFromCommaSeparatedString(_ css:String) -> [KeyLevel]? {
 let ary =  css.characters.split{$0 == ","}.map(String.init)
 if ary.count<1 {return nil}
 var lvls:[KeyLevel]=[KeyLevel]()
 for i in 0..<ary.count {
 var txt=ary[i]
 
 if txt == "comma" {txt = ","}
 //if txt == "" {continue}
 let lvl:KeyLevel = KeyLevel()
 lvl.level = 2
 lvl.text = txt
 lvls.append(lvl)
 }
 if lvls.count > 0 {
 return lvls
 }
 return nil
 }
 */



