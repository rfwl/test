//
//  MainViewController.swift
//  PopoverTest
//
//  Created by Richard Feng on 30/10/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//


import UIKit
class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate
{
    
    struct properties {
        static let moods = [
            ["title" : "the best", "color" : "#8647b7"],
            ["title" : "really good", "color": "#4870b7"],
            ["title" : "okay", "color" : "#45a85a"],
            ["title" : "meh", "color" : "#a8a23f"],
            ["title" : "not so great", "color" : "#c6802e"],
            ["title" : "the worst", "color" : "#b05050"]
        ]
    }
    
    // MARK: Properties
    
    
    func createPicker()
    {
        picker.frame = CGRect(x: ((self.view.frame.width / 2) - 143), y: 200, width: 286, height: 291)
        picker.alpha = 0
        picker.hidden = true
        picker.userInteractionEnabled = true
        
        var offset = 21
        
        for (index, feeling) in properties.moods.enumerated()
        {
            let button = UIButton()
            button.frame = CGRect(x: 13, y: offset, width: 260, height: 43)
            button.setTitleColor(UIColor(feeling["color"]!), for: .normal)
            button.setTitle(feeling["title"], for: .normal)
            button.tag = index
           
            
            picker.addSubview(button)
            
            offset += 44
        }
        
        view.addSubview(picker)
    }
    
    
    func openPicker()
    {
        self.picker.hidden = false
        
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.picker.frame = CGRect(x: ((self.view.frame.width / 2) - 143), y: 230, width: 286, height: 291)
                                    self.picker.alpha = 1
        })
    }
    
    func closePicker()
    {
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.picker.frame = CGRect(x: ((self.view.frame.width / 2) - 143), y: 200, width: 286, height: 291)
                                    self.picker.alpha = 0
        },
                                   completion: { finished in
                                    self.picker.hidden = true
        }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createPicker()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let popupView = segue.destination
        if let popup = popupView.popoverPresentationController
        {
            popup.delegate = self
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.none
    }
    
} // end of class
