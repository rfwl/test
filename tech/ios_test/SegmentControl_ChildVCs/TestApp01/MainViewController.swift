//
//  ViewController.swift
//  TestApp01
//
//  Created by Wanlou Feng on 13/8/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var uiSegmentControl: UISegmentedControl!

    lazy var masterVC:MasterViewController = { //() -> MasterViewController in
        let sb = UIStoryboard(name:"Main", bundle: Bundle.main)
        var vc = sb.instantiateViewController(withIdentifier: "MasterViewController" ) as! MasterViewController
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        vc.view.frame = self.view.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParentViewController: self)
        return vc
    }()
    
    lazy var sessionVC:SessionViewController = { //() -> SessionViewController in
        let sb = UIStoryboard(name:"Main", bundle: Bundle.main)
        var vc = sb.instantiateViewController(withIdentifier: "SessionViewController" ) as! SessionViewController
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        vc.view.frame = self.view.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParentViewController: self)
        
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUISegementControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setupUISegementControl(){
        uiSegmentControl.removeAllSegments()
        uiSegmentControl.insertSegment(withTitle: "Master", at: 0, animated: false)
        uiSegmentControl.insertSegment(withTitle: "Session", at: 1, animated: false)
        uiSegmentControl.selectedSegmentIndex = 0
        refreshView()
    }
    @IBAction func uiSegmentControl_TouchUpInside(_ sender: UISegmentedControl) {
        refreshView()
    }
    private func refreshView() {
        masterVC.view.isHidden = uiSegmentControl.selectedSegmentIndex != 0
        sessionVC.view.isHidden = uiSegmentControl.selectedSegmentIndex != 1
        
    }
    @IBAction func valueChanged(_ sender: Any) {
        refreshView()
    }

  
    
    private func removeChildViewController(childVC:UIViewController){
        childVC.willMove(toParentViewController: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParentViewController()
    }
} //end of class


