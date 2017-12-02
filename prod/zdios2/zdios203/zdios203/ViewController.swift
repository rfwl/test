//
//  ViewController.swift
//  zdios203
//
//  Created by Wanlou Feng on 31/10/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var textViewMessage: UITextView!
    
    @IBOutlet weak var viewMainArea: UIView!
    
    @IBAction func button1(_ sender: Any) {
        Commander.drawPageAt(0)
    }
    
    @IBAction func button2(_ sender: Any) {
        Commander.drawPageAt(1)
    }
    
    @IBAction func button3(_ sender: Any) {
        Commander.drawPageAt(2)
    }
    
    @IBAction func button4(_ sender: Any) {
        Commander.drawPageAt(3)
    }
    
    
    var keyboardView:KeyboardView?
    var popUpContainerView:PopUpContainerView?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let frm = CGRect(x:0, y:0, width:self.viewMainArea.bounds.width, height:self.viewMainArea.bounds.height)
        Commander.keyboardView = KeyboardView(frame: frm)
        viewMainArea.addSubview(Commander.keyboardView!)
        
        let frm1 = CGRect(x: frm.minX, y: frm.minY - PopUpSettings.heightAboveKeyboardView, width: frm.width, height: frm.height)
        Commander.popUpContainerView = PopUpContainerView(frame:frm1)
        viewMainArea.addSubview(Commander.popUpContainerView!)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        try! Commander.startUp()
        
    }
    
    
    
    
} //end of class

