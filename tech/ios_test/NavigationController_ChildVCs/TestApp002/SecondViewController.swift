//
//  SecondViewController.swift
//  TestApp002
//
//  Created by Wanlou Feng on 19/8/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //@IBOutlet weak var btnDismiss: UIButton!
    
    //@IBAction func dismissPopOver(_ sender: Any) {
        
    //    self.navigationController?.dismiss(animated: false, completion:nil);
    //}

    
    @IBAction func btnDismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion:nil);
    }
}
