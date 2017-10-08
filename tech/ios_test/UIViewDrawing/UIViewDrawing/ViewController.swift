//
//  ViewController.swift
//  UIViewDrawing
//
//  Created by Wanlou Feng on 27/9/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vw:ViewA = ViewA(frame: CGRect(x:10, y:60, width:380, height:500))
        self.view.addSubview(vw)
        vw.setNeedsLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


} //end of class


