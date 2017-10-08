//
//  ViewController.swift
//  Popover1
//
//  Created by Richard Feng on 30/10/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var picker: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let layer : CenterCATextLayer = CenterCATextLayer()
        layer.string = "ABC"
        layer.frame = CGRect(x:10,y:100,width:100,height:120)
        layer.backgroundColor = UIColor.gray.cgColor
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 3
        layer.alignmentMode = "center"
        layer.foregroundColor = UIColor.white.cgColor
        layer.shadowColor = UIColor.yellow.cgColor
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width:150, height:162)
        
        let radius: CGFloat = layer.frame.width / 2.0 //change it to .height if you need spread for height
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.1 * radius, height: layer.frame.height))
        //Change 2.1 to amount of spread you need and for height replace the code for height
        layer.cornerRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 6.5, height: 0.4)  //Here you control x and y
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5.0 //Here your control your blur
        layer.masksToBounds =  false
        layer.shadowPath = shadowPath.cgPath
        
        self.view.layer.addSublayer(layer)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let popOver = segue.destination as! PopoverViewController
        popOver.popoverPresentationController!.delegate = self
        //didn't work however if i changed it to
        //popOver.delegate=self
    }
    
    // Tells the delegate that the popover was dismissed.
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print("dismissed")
    }
    
    
} //end of class

/*
 
 
 
 
 */
