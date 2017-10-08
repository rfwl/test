//
//  ShareViewController.swift
//  Dongle
//
//  Created by vixi on 12.11.15.
//  Copyright © 2015 Anatoly Rosencrantz. All rights reserved.
//

import UIKit
import Social
import VK_ios_sdk //20.11 10:15

class ShareViewController: UIViewController {
    let vkAppId = "5146213"
    
    let adsURL: URL = URL(string: "https://itunes.apple.com/app/id1060544653")!
    let adsText: String = NSLocalizedString("DNGR - keyboard for iOS! (ノಠ益ಠ)ノ Wow!", comment: "text for vk, fb and tw share posts")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    @IBAction func vkButtonPushed(_ sender: UIButton) {
        //SDK
        let vkSdk = VKSdk.initialize(withAppId: vkAppId)
        vkSdk?.register(self)
        
        shareOnVk()
    }
    
    func shareOnVk() {
        //Share
        let vkShareDialog = VKShareDialogController()
        
        vkShareDialog.text = adsText
        vkShareDialog.shareLink = VKShareLink(title: "DNGR on AppStore", link: adsURL)
        vkShareDialog.completionHandler = { (controller, result) -> Void in
            vkShareDialog.dismiss(animated: true, completion: nil)
        }
        
        self.present(vkShareDialog, animated: true, completion: nil)
    }
    
    // MARK: my methods
    @IBAction func twitterButtonPushed(_ sender: UIButton) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText(adsText)
            twitterSheet.add(adsURL)
            self.present(twitterSheet, animated: true, completion: nil)
        } else {
            let message = NSLocalizedString("You should be logged in to Twitter to share knowledge", comment: "tw alert text: not logged in")
            
            let alert = UIAlertController(title: "(╭ರ_⊙)", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func facebookButtonPushed(_ sender: UIButton) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText(adsText)
            facebookSheet.add(adsURL)
            self.present(facebookSheet, animated: true, completion: nil)
        } else {
            let message = NSLocalizedString("You should be logged in to Facebook to share knowledge", comment: "fb alert text: not logged in")
            
            let alert = UIAlertController(title: "(╭ರ_⊙)", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension ShareViewController: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        //print("authorized")
        shareOnVk()
    }
    
    func vkSdkUserAuthorizationFailed() {
        //print("auth failed")
    }
}
