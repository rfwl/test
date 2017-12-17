//
//  ViewController.swift
//  UIPasteboardTest
//
//  Created by Wanlou Feng on 16/12/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let img : UIImage? = UIImage(named: "key_icons/" + "mu_key")
       srcIV.image = img
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var srcTV: UITextView!
    
    @IBOutlet weak var tgtTV: UITextView!
    
    @IBAction func btnCopy(_ sender: Any) {
        let generalPasteboard = UIPasteboard.general
        generalPasteboard.string = srcTV.text + "     \u{2665}"
        
    }
    
    @IBAction func btnPaste(_ sender: Any) {
        let generalPasteboard = UIPasteboard.general
        
        if let txt = generalPasteboard.string {
            //tgtTV.text = txt + "\u{1F496}"
            tgtTV.paste(txt)
            //tgtTV.paste( )(sender: generalPasteboard )
            //canPerformAction(<#T##action: Selector##Selector#>, withSender: )
            //UIMenuController.shared.   menuItems   .perform(<#T##aSelector: Selector!##Selector!#>)
            //UIMenuItem.
            //UITextDocumentProxy.
            
        }
       
    }
    
    @IBOutlet weak var srcIV: UIImageView!
    
    @IBOutlet weak var tgtIV: UIImageView!
    
    @IBAction func btnCopyImage(_ sender: Any) {
        let generalPasteboard = UIPasteboard.general
        if let img = srcIV.image {
            generalPasteboard.image = img
        }
    }
    
    @IBAction func btnPasteImageClicked(_ sender: Any) {
        let generalPasteboard = UIPasteboard.general
        if let img = generalPasteboard.image {
            tgtIV.image = img
        }
    }
    
    @IBOutlet weak var tfUrl: UITextField!
    
    @IBAction func btnCopyUrl(_ sender: Any) {
        let generalPasteboard = UIPasteboard.general
        if let txt = tfUrl.text {
            generalPasteboard.url = URL(string: txt)
        }
    }
    
    
    
} // end of class

