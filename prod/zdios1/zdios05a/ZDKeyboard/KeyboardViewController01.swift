//
//  KeyboardViewController.swift
//  ZDKeyboard
//
//  Created by Richard Feng on 29/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
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
        
        addButtons()
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
    
    func addButtons() {
        let frm:CGRect = CGRect(x:5,y:10,width:200,height:100)
        let btn1 = UIButton(frame:frm)
        btn1.backgroundColor = UIColor.brown
        btn1.setTitle("Key1", for:.normal )
        // Buttons have five states that define their appearance: default, highlighted, focused, selected, and disabled.
        btn1.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        self.view.addSubview(btn1)
        
        
        
        
 
    }
    func didTapButton(sender: AnyObject?) {
        
        let button = sender as! UIButton
        let title = button.title(for:.normal)
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(title!)
    }
    

    
    
    

} // end of class
