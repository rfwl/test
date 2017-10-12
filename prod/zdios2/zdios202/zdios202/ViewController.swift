//
//  ViewController.swift
//  zdios11
//
//  Created by Wanlou Feng on 13/8/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var keyboardViewContainer: UIView!
    
    var keyboardView:KeyboardView?
    var popUpContainerView:PopUpContainerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let frm = CGRect(x:0, y:0, width:self.keyboardViewContainer.bounds.width, height:self.keyboardViewContainer.bounds.height)
        
        keyboardView = KeyboardView(frame: frm)
        keyboardView?.keyboardDefinition = defaultKeyboard()
        //keyboardView!.backgroundColor = UIColor.green // for debug
        keyboardViewContainer.addSubview(keyboardView!)
        
        let frm1 = CGRect(x: frm.minX, y: frm.minY - PopUpSettings.heightAboveKeyboardView, width: frm.width, height: frm.height)
        
        popUpContainerView = PopUpContainerView(frame:frm1)
        keyboardViewContainer.addSubview(popUpContainerView!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        
    }
    
    @IBAction func btnClick1(_ sender: Any) {
        if let kybd = keyboardView{
            let pg = kybd.keyboardDefinition.pages[0]
            kybd.drawPage(pg)
            kybd.setNeedsDisplay()
        }
    }
    @IBAction func btnClick2(_ sender: Any) {
        if let kybd = keyboardView{
            let pg = kybd.keyboardDefinition.pages[1]
            kybd.drawPage(pg)
        }
    }
    @IBAction func btnClick3(_ sender: Any) {
        if let kybd = keyboardView{
            let pg = kybd.keyboardDefinition.pages[2]
            kybd.drawPage(pg)
        }    }
    @IBAction func btnClick4(_ sender: Any) {
        if let kybd = keyboardView{
            let pg = kybd.keyboardDefinition.pages[3]
            kybd.drawPage(pg)
        }
    }
    
    
    
    
    
    
    
    
} //end of class


