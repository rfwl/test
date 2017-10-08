//
//  ViewController.swift
//  TestApp002
//
//  Created by Wanlou Feng on 19/8/17.
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

    @IBAction func infoButton(_ sender: Any) {
        
        var a = 1
        a += 2
        
    }
    @IBOutlet weak var btn1: UIButton!

    @IBAction func clickButton1(_ sender: UIButton) {
    }
}

