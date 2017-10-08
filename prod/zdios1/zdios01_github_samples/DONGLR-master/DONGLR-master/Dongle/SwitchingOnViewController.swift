//
//  ViewController.swift
//  Dongle
//
//  Created by vixi on 13.10.15.
//  Copyright © 2015 Anatoly Rosencrantz. All rights reserved.
//

import UIKit

class SwitchingOnViewController: UIViewController {
    // MARK: outlets and lets
    @IBOutlet var gifView: UIWebView?
    
    // MARK: lifetime methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //"видео"
        guard let filePath = Bundle.main.path(forResource: NSLocalizedString("settingsGifEn", comment: "gif file on how to add screen"), ofType: "gif"),
            let gifData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
                return
        }

        gifView?.load(gifData, mimeType: "image/gif", textEncodingName: "", baseURL: URL(string:"/")!)
    }
}

