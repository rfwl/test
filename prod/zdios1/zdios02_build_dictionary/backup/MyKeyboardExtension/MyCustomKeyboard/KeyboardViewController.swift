//
//  KeyboardViewController.swift
//  MyCustomKeyboard
//
//  Created by Richard Feng on 7/10/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
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
        //------------------------------------------------------------------
        //let btn = createButtonWithTitle(title : "Key1")
        //self.view.addSubview(btn)
        let buttonTitles1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
        let buttonTitles2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
        let buttonTitles3 = ["CP", "Z", "X", "C", "V", "B", "N", "M", "BP"]
        let buttonTitles4 = ["CHG", "SPACE", "RETURN"]
        
        let row1 = createRowOfButtons(buttonTitles : buttonTitles1 as [NSString])
        let row2 = createRowOfButtons(buttonTitles : buttonTitles2 as [NSString])
        let row3 = createRowOfButtons(buttonTitles : buttonTitles3 as [NSString])
        let row4 = createRowOfButtons(buttonTitles : buttonTitles4 as [NSString])
        
        self.view.addSubview(row1)
        self.view.addSubview(row2)
        self.view.addSubview(row3)
        self.view.addSubview(row4)
        
        row1.translatesAutoresizingMaskIntoConstraints = false
        row2.translatesAutoresizingMaskIntoConstraints = false
        row3.translatesAutoresizingMaskIntoConstraints = false
        row4.translatesAutoresizingMaskIntoConstraints = false
        
        
        addConstraintsToInputView(inputView : self.view, rowViews: [row1, row2, row3, row4])
        
        //------------------------------------------------------------------
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
    //===================================================================
    
    func createButtonWithTitle(title: String) -> UIButton {
        
        let button = UIButton.init(type:.system)
        button.frame = CGRect(x:0, y:0, width:20, height:20)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.titleLabel?.font = UIFont.systemFont(ofSize:15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        //btn.addTarget(self, action: #selector(buttonAction), forControlEvents: .touchUpInside)
        
        return button
    }
    func didTapButton(sender: AnyObject?) {
    
        let button = sender as! UIButton
        let title = button.title(for:.normal)
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(title!)
    }
    //===================================================================
    func createRowOfButtons(buttonTitles: [NSString]) -> UIView {
        
        var buttons = [UIButton]()
        let keyboardRowView = UIView(frame: CGRect(x :0, y:0, width:320, height:50))
        
        for buttonTitle in buttonTitles{
            
            let button = createButtonWithTitle(title : buttonTitle as String)
            buttons.append(button)
            keyboardRowView.addSubview(button)
        }
        
        addIndividualButtonConstraints(buttons:buttons,mainView:keyboardRowView)
        return keyboardRowView;
    }

    
    
    //===================================================================
    
    func addIndividualButtonConstraints(buttons: [UIButton], mainView: UIView){
        
        for (index, button) in buttons.enumerated() {
            var topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 1)
            
            var bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: mainView, attribute: .bottom, multiplier: 1.0, constant: -1)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == buttons.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: mainView, attribute: .right, multiplier: 1.0, constant: -1)
                
            }else{
                
                var nextButton = buttons[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: nextButton, attribute: .left, multiplier: 1.0, constant: -1)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 1)
                
            }else{
                
                var prevtButton = buttons[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: prevtButton, attribute: .right, multiplier: 1.0, constant: 1)
                
                var firstButton = buttons[0]
                var widthConstraint = NSLayoutConstraint(item: firstButton, attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
                
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    func addConstraintsToInputView(inputView: UIView, rowViews: [UIView]){
    
    for (index, rowView) in rowViews.enumerated() {
        var rightSideConstraint = NSLayoutConstraint(item: rowView, attribute: .right, relatedBy: .equal, toItem: inputView, attribute: .right, multiplier: 1.0, constant: -1)
    
    var leftConstraint = NSLayoutConstraint(item: rowView, attribute: .left, relatedBy: .equal, toItem: inputView, attribute: .left, multiplier: 1.0, constant: 1)
    
    inputView.addConstraints([leftConstraint, rightSideConstraint])
    
    var topConstraint: NSLayoutConstraint
    
    if index == 0 {
    topConstraint = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: inputView, attribute: .top, multiplier: 1.0, constant: 0)
    
    }else{
    
    var prevRow = rowViews[index-1]
    topConstraint = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: prevRow, attribute: .bottom, multiplier: 1.0, constant: 0)
    
    var firstRow = rowViews[0]
    var heightConstraint = NSLayoutConstraint(item: firstRow, attribute: .height, relatedBy: .equal, toItem: rowView, attribute: .height, multiplier: 1.0, constant: 0)
    
    inputView.addConstraint(heightConstraint)
    }
    inputView.addConstraint(topConstraint)
    
    var bottomConstraint: NSLayoutConstraint
    
    if index == rowViews.count - 1 {
    bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: inputView, attribute: .bottom, multiplier: 1.0, constant: 0)
    
    }else{
    
    var nextRow = rowViews[index+1]
    bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: nextRow, attribute: .top, multiplier: 1.0, constant: 0)
    }
    
    inputView.addConstraint(bottomConstraint)
    }
    
    } // end of method

    //===================================================================
    

} //end of class
/*
 
 //
 //  KeyboardViewController.swift
 //  RFKeyBoard
 //
 //  Created by Richard Feng on 5/10/2016.
 //  Copyright © 2016 Richard Feng. All rights reserved.
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
 
 
 let buttonTitles1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
 let buttonTitles2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
 let buttonTitles3 = ["CP", "Z", "X", "C", "V", "B", "N", "M", "BP"]
 let buttonTitles4 = ["CHG", "SPACE", "RETURN"]
 
 let row1 = createRowOfButtons(buttonTitles : buttonTitles1 as [NSString])
 let row2 = createRowOfButtons(buttonTitles : buttonTitles2 as [NSString])
 let row3 = createRowOfButtons(buttonTitles : buttonTitles3 as [NSString])
 let row4 = createRowOfButtons(buttonTitles : buttonTitles4 as [NSString])
 
 self.view.addSubview(row1)
 self.view.addSubview(row2)
 self.view.addSubview(row3)
 self.view.addSubview(row4)
 
 row1.translatesAutoresizingMaskIntoConstraints = false
 row2.translatesAutoresizingMaskIntoConstraints = false
 row3.translatesAutoresizingMaskIntoConstraints = false
 row4.translatesAutoresizingMaskIntoConstraints = false
 
 
 addConstraintsToInputView(inputView : self.view, rowViews: [row1, row2, row3, row4])
 
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
 func addIndividualButtonConstraints(buttons: [UIButton], mainView: UIView){
 
 for (index, button) in buttons.enumerated() {
 let topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 1)
 
 let bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: mainView, attribute: .bottom, multiplier: 1.0, constant: -1)
 
 var rightConstraint : NSLayoutConstraint!
 
 if index == buttons.count - 1 {
 
 rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: mainView, attribute: .right, multiplier: 1.0, constant: -1)
 
 }else{
 
 let nextButton = buttons[index+1]
 rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: nextButton, attribute: .left, multiplier: 1.0, constant: -1)
 }
 
 
 var leftConstraint : NSLayoutConstraint!
 
 if index == 0 {
 
 leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 1)
 
 }else{
 
 let prevtButton = buttons[index-1]
 leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: prevtButton, attribute: .right, multiplier: 1.0, constant: 1)
 
 let firstButton = buttons[0]
 let widthConstraint = NSLayoutConstraint(item: firstButton, attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
 
 mainView.addConstraint(widthConstraint)
 }
 
 mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
 }
 }
 
 func addConstraintsToInputView(inputView: UIView, rowViews: [UIView]){
 
 for (index, rowView) in rowViews.enumerated() {
 let rightSideConstraint = NSLayoutConstraint(item: rowView, attribute: .right, relatedBy: .equal, toItem: inputView, attribute: .right, multiplier: 1.0, constant: -1)
 
 let leftConstraint = NSLayoutConstraint(item: rowView, attribute: .left, relatedBy: .equal, toItem: inputView, attribute: .left, multiplier: 1.0, constant: 1)
 
 inputView.addConstraints([leftConstraint, rightSideConstraint])
 
 let topConstraint: NSLayoutConstraint
 
 if index == 0 {
 topConstraint = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: inputView, attribute: .top, multiplier: 1.0, constant: 0)
 
 }else{
 
 let prevRow = rowViews[index-1]
 topConstraint = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: prevRow, attribute: .bottom, multiplier: 1.0, constant: 0)
 
 let firstRow = rowViews[0]
 let heightConstraint = NSLayoutConstraint(item: firstRow, attribute: .height, relatedBy: .equal, toItem: rowView, attribute: .height, multiplier: 1.0, constant: 0)
 
 inputView.addConstraint(heightConstraint)
 }
 inputView.addConstraint(topConstraint)
 
 var bottomConstraint: NSLayoutConstraint
 
 if index == rowViews.count - 1 {
 bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: inputView, attribute: .bottom, multiplier: 1.0, constant: 0)
 
 }else{
 
 let nextRow = rowViews[index+1]
 bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: nextRow, attribute: .top, multiplier: 1.0, constant: 0)
 }
 
 inputView.addConstraint(bottomConstraint)
 }
 
 } // end of method
 
 
 
 
 
 func createButtonWithTitle(title: String) -> UIButton {
 
 let button = UIButton.init(type:.system)
 button.frame = CGRect(x:0, y:0, width:20, height:20)
 button.setTitle(title, for: .normal)
 button.sizeToFit()
 button.titleLabel?.font = UIFont.systemFont(ofSize:15)
 button.translatesAutoresizingMaskIntoConstraints = false
 button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
 button.setTitleColor(UIColor.darkGray, for: .normal)
 
 button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
 //btn.addTarget(self, action: #selector(buttonAction), forControlEvents: .touchUpInside)
 
 return button
 }
 
 func didTapButton(sender: AnyObject?) {
 
 let button = sender as! UIButton
 let title = button.title(for:.normal)
 let proxy = textDocumentProxy as UITextDocumentProxy
 
 proxy.insertText(title!)
 }
 
 func createRowOfButtons(buttonTitles: [NSString]) -> UIView {
 
 var buttons = [UIButton]()
 let keyboardRowView = UIView(frame: CGRect(x :0, y:0, width:320, height:50))
 
 for buttonTitle in buttonTitles{
 
 let button = createButtonWithTitle(title : buttonTitle as String)
 buttons.append(button)
 keyboardRowView.addSubview(button)
 }
 return keyboardRowView;
 }
 
 } // end of class
 
 

 */
