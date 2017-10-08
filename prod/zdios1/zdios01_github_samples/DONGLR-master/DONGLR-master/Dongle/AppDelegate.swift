//
//  AppDelegate.swift
//  Dongle
//
//  Created by vixi on 13.10.15.
//  Copyright © 2015 Anatoly Rosencrantz. All rights reserved.
//

import UIKit
import DnrgFramework
import MSDynamicsDrawerViewController
import VK_ios_sdk
import iRate


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MSDynamicsDrawerViewControllerDelegate {
    var window: UIWindow?
    var dynamicsDrawerViewController: MSDynamicsDrawerViewController?
    
    
    override init() {
        iRate.sharedInstance().daysUntilPrompt = 2
        iRate.sharedInstance().usesUntilPrompt = 2
        
        super.init()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //VIEWS
        self.dynamicsDrawerViewController = self.window!.rootViewController as? MSDynamicsDrawerViewController
        self.dynamicsDrawerViewController!.delegate = self;
        
        //dngrs list
        let dngrsViewController = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "DNGRS")
        
        self.dynamicsDrawerViewController?.paneViewController = dngrsViewController
        
        //help
        let logoViewController = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "Help")
        
        self.dynamicsDrawerViewController?.setDrawerViewController(logoViewController, for:MSDynamicsDrawerDirection.left)
        
        //share
        let shareViewController = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "Share")
        
        self.dynamicsDrawerViewController?.setDrawerViewController(shareViewController, for: MSDynamicsDrawerDirection.right)
        
        //stylers
        let parallaxStylerLeft = MSDynamicsDrawerParallaxStyler()
        let parallaxStylerRight = MSDynamicsDrawerParallaxStyler()
        
        parallaxStylerLeft.parallaxOffsetFraction = 0.25
        self.dynamicsDrawerViewController?.addStylers(from: [parallaxStylerLeft, MSDynamicsDrawerResizeStyler.styler()], for: MSDynamicsDrawerDirection.left)
        
        parallaxStylerRight.parallaxOffsetFraction =  -0.25
        self.dynamicsDrawerViewController?.addStylers(from: [parallaxStylerRight, MSDynamicsDrawerResizeStyler.styler()], for: MSDynamicsDrawerDirection.right)
        
        //stuff
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.dynamicsDrawerViewController
        self.window?.makeKeyAndVisible()
        
        let backgroundView = self.backgroundView()
        self.window?.addSubview(backgroundView)
        self.window?.sendSubview(toBack: backgroundView)

        return true
    }
    
    
//MARK: background under all three views
    func backgroundView() -> UIView { //фоновый вид - то, что под нижней панелью
        let bgv = UIView(frame: self.window!.frame)
        //видео?
        bgv.backgroundColor = UIColor(red: 81, green: 255, blue: 221, alpha: 1.0)
        
        return bgv
    }
    

//MARK: left-right nav buttons
    func openLeft(_ sender: UIButton?) {
        dynamicsDrawerViewController?.setPaneState(MSDynamicsDrawerPaneState.open, in: MSDynamicsDrawerDirection.left, animated: true, allowUserInterruption: false, completion: nil)
    }
    
    func openRight(_ sender: UIButton?) {
        dynamicsDrawerViewController?.setPaneState(MSDynamicsDrawerPaneState.open, in: MSDynamicsDrawerDirection.right, animated: true, allowUserInterruption: false, completion: nil)
    }
    
    func dynamicsDrawerViewController(_ drawerViewController: MSDynamicsDrawerViewController!, mayUpdateTo paneState: MSDynamicsDrawerPaneState, for direction: MSDynamicsDrawerDirection) {
        if let udv = drawerViewController.paneViewController as? UserDefinedDongersTableViewController {
            if paneState == MSDynamicsDrawerPaneState.openWide {
                //print("wide")
            } else if paneState == MSDynamicsDrawerPaneState.open {
                if udv.dngrsList.isOpenAccessGranted() == false {
                    dynamicsDrawerViewController?.setPaneTapToCloseEnabled(false, for: direction)
                }
                
                if direction == MSDynamicsDrawerDirection.left {
                    udv.leftButton!.setImage(UIImage(named: "DngrList"), for: UIControlState())
                }else if direction == MSDynamicsDrawerDirection.right {
                    udv.rightButton!.setImage(UIImage(named: "DngrList"), for: UIControlState())
                }
            
            } else if paneState == MSDynamicsDrawerPaneState.closed { //возвращаем кнопки
                    udv.leftButton!.setImage(UIImage(named: "Help"), for: UIControlState())
                    udv.rightButton!.setImage(UIImage(named: "Share"), for: UIControlState())
            }
        }
    }
    
    func dynamicsDrawerViewController(_ drawerViewController: MSDynamicsDrawerViewController!, shouldBeginPanePan panGestureRecognizer: UIPanGestureRecognizer!) -> Bool {
        return false //пользователи окрывают вторую панель только кнопками, жесты не распознаем
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        VKSdk.processOpen(url, fromApplication: sourceApplication )
        
        return true
    }
    
//MARK: unchanged    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

