//
//  ViewController.swift
//  zdios05
//
//  Created by Richard Feng on 27/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textView: UITextView!
    
    //===============================================
    //required init(coder aDecoder: NSCoder) {
    //    fatalError("init(coder:) has not been implemented")
    //}
    
    //===============================================
    override func loadView() {
        super.loadView()
        self.view = UIView(frame: UIScreen.main.bounds)
        self.textView = UITextView(frame: self.view.frame)
        self.textView.isScrollEnabled = true
        self.textView.isUserInteractionEnabled = true
        self.view.addSubview(self.textView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //===============================================
    
    

} // end of class

