//
//  KeyboardViewController.swift
//  ZiDianKeyboard
//
//  Created by Richard Feng on 27/11/16.
//  Copyright © 2016 Wanlou Feng. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
   
    //========================================================================
    // overrides
    override func updateViewConstraints() {
        super.updateViewConstraints()        
        // Add custom view sizing constraints here  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //let ig : UIImage? = UIImage(named:"backspace01")
        
        addToolBarView()        
        addContentView()
        contentVC.view = contentView
        contentVC.commander = commander
        
     	commander.mainVC = self
    	commander.contentVC = contentVC
        commander.textDocumentProxy =  self.textDocumentProxy
        //////http://smnh.me/synchronizing-rotation-animation-between-the-keyboard-and-the-attached-view-part-2/
        NotificationCenter.default.addObserver( self, selector: #selector(kbdDidHide), name: NSNotification.Name.UIKeyboardDidHide,  object: nil)
        NotificationCenter.default.addObserver( self, selector: #selector(kbdDidShow), name: NSNotification.Name.UIKeyboardDidShow,  object: nil)
        NotificationCenter.default.addObserver( self, selector: #selector(kbdWillHide), name: NSNotification.Name.UIKeyboardWillHide,  object: nil)
        NotificationCenter.default.addObserver( self, selector: #selector(kbdWillShow), name: NSNotification.Name.UIKeyboardWillShow,  object: nil)
        
        
        
        commander.drawDefault();
       
    }  // end of func
    
    func kbdDidHide(notification: NSNotification){
        //print(" Did Hide \(self.view.bounds.size.width) \(self.view.bounds.size.height)")    
    }
    
    func kbdWillHide(notification: NSNotification){
        //print(" Will Hide \(self.view.bounds.size.width) \(self.view.bounds.size.height)")    
    }
    
    func kbdDidShow(notification: NSNotification){
        //print(" Did Show \(self.view.bounds.size.width) \(self.view.bounds.size.height)")
    }
    func kbdWillShow(notification: NSNotification){
        //print(" Will Show \(self.view.bounds.size.width) \(self.view.bounds.size.height)")
    }
    
    func resizeSubViews(){
        
        let toolbarWidth:CGFloat = self.view.frame.size.width - self.paddingLeft - self.paddingRight
        let frm:CGRect =  CGRect(x: self.paddingLeft, y: self.paddingTop, width: toolbarWidth, height: self.toolbarHeight)
        self.toolbarView.frame = frm
        
        let contentWidth:CGFloat = self.view.frame.size.width - self.paddingLeft - self.paddingRight
        let contentTop:CGFloat = self.paddingTop + self.toolbarHeight + self.gap
        let contentHeight:CGFloat = self.view.frame.size.height - contentTop - self.paddingBottom
        
        let frm1:CGRect =  CGRect(x: self.paddingLeft, y: contentTop, width: contentWidth, height:contentHeight)
        self.contentView.frame = frm1
        
        self.commander.reportViewTransition()
    }
    
    //override
    func viewWillTransition11(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //print("Transition to \(size.width) \(size.height)")
        
        let toolbarWidth:CGFloat = size.width - paddingLeft - paddingRight
        let frm:CGRect =  CGRect(x: paddingLeft, y: paddingTop, width: toolbarWidth, height: toolbarHeight)
        toolbarView.frame = frm
        
        let contentWidth:CGFloat = size.width - paddingLeft - paddingRight
        let contentTop:CGFloat = paddingTop + toolbarHeight + gap
        let contentHeight:CGFloat = size.height - contentTop - paddingBottom
        
        let frm1:CGRect =  CGRect(x: paddingLeft, y: contentTop, width: contentWidth, height: contentHeight)
        contentView.frame = frm1
        commander.reportViewTransition()
        
        // Worked logically but height is not right, too small after rotations. Gaps left below the content view. ????? Width is changing and recovering OK.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        //print("1 Transition to \(size.width) \(size.height)")
        
        coordinator.animateAlongsideTransition(in: self.view, animation:
            { (coordinator) in
                print("2 Transition to \(self.view.bounds.width) \(self.view.bounds.size.height)")
            },
        completion: { (coordinator) in
                //print("3 Transition to \(self.view.bounds.size.width) \(self.view.bounds.size.height)")
            
                //self.resizeSubViews()
            }
        )
    }
    
    override func viewDidLayoutSubviews() {
        
        //print("viewDidLayoutSubviews to \(self.view.bounds.size.width) \(self.view.bounds.size.height)")
        self.resizeSubViews()
    }
    //========================================================================
    // Data Members
    let contentVC : KeyLevelViewController = KeyLevelViewController()
    let commander = Commander()    
    let toolbarView : ToolbarView = ToolbarView()
    let contentView: KeyLevelView = KeyLevelView()    
    //========================================================================
    // Add View: toolbar and content    
    let toolbarHeight:CGFloat = 60
    let paddingLeft:CGFloat = 5
    let paddingRight:CGFloat = 5
    let paddingTop:CGFloat = 0
    let paddingBottom:CGFloat = 0
    let gap:CGFloat = 0
    
    func addToolBarView() {
        let toolbarWidth:CGFloat = self.view.frame.width - paddingLeft - paddingRight
        let frm:CGRect =  CGRect(x: paddingLeft, y: paddingTop, width: toolbarWidth, height: toolbarHeight)
        toolbarView.frame = frm
        toolbarView.mainVC = self
        self.view.addSubview(toolbarView)
        
    }
    	
    func addContentView() {
       	let contentWidth:CGFloat = self.view.frame.width - paddingLeft - paddingRight
        let contentTop:CGFloat = paddingTop + toolbarHeight + gap
        let contentHeight:CGFloat = self.view.frame.height - contentTop - paddingBottom
        
        let frm:CGRect =  CGRect(x: paddingLeft, y: contentTop, width: contentWidth, height: contentHeight)
        contentView.frame = frm
        contentView.isScrollEnabled = true
        contentView.isUserInteractionEnabled = true
        contentView.showsVerticalScrollIndicator = true
        contentView.contentVC = contentVC
        self.view.addSubview(contentView)
        
    }           
   //========================================================================
    // Report to Commander     
    func tapToolbarButton(_ button : ToolbarButton?) {
    	//print("DB-" + tbBtn.buttonName)
    	commander.reportTap_ToolbarButton((button?.buttonName)!)
    }
    //========================================================================
	func gotoNextIMe(){
    	self.advanceToNextInputMode();
    }
    func closeIME(){
    	self.dismissKeyboard();
    }
    //========================================================================
	   
} // end of class
/*

 // Define identifier
 let notificationName = Notification.Name("NotificationIdentifier")
 
 // Register to receive notification
 NotificationCenter.default.addObserver(self, selector: #selector(YourClassName.methodOfReceivedNotification), name: notificationName, object: nil)
 
 // Post notification
 NotificationCenter.default.post(name: notificationName, object: nil)
 All of the system notification types are now defined as static constants on Notification.Name; i.e. .UIDeviceBatteryLevelDidChange, .UIApplicationDidFinishLaunching, .UITextFieldTextDidChange, etc.
 
 You can extend Notification.Name with your own custom notifications in order to stay consistent with the system notifications:
 
 // Definition:
 extension Notification.Name {
 static let yourCustomNotificationName = Notification.Name("yourCustomNotificationName")
 }
 
 // Usage:
 NotificationCenter.default.post(name: .yourCustomNotificationName, object: nil)

 
 
 func batteryLevelChanged(notification: Notification) {
 // do something useful with this information
 }
 
 let observer = NotificationCenter.default.addObserver(
 forName: NSNotification.Name.UIDeviceBatteryLevelDidChange,
 object: nil, queue: nil,
 using: batteryLevelChanged)
 and you can even just use a closure instead of a method if you want:
 
 let observer = NotificationCenter.default.addObserver(
 forName: NSNotification.Name.UIDeviceBatteryLevelDidChange,
 object: nil, queue: nil) { _ in print("🔋") }
 You can use the returned value to stop listening for the notification later:
 
 NotificationCenter.default.removeObserver(observer)
 
 
*/
/*
 
 (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
 {
 [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
 [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
 {
 //update views here, e.g. calculate your view
 }
 completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
 {
 }];
 }
 
 * Codes from apple web site:
 https://developer.apple.com/library/content/samplecode/NavBar/Listings/CustomAppearance_CustomAppearanceViewController_swift.html
 @available(iOS 8.0, *)
 override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
 super.viewWillTransition(to: size, with: coordinator)
 
 // This works around a bug in iOS 8.0 - 8.2 in which the navigation bar
 // will not display the correct background image after rotating the device.
 // This bug affects bars in navigation controllers that are presented
 // modally. A bar in the window's rootViewController would not be affected.
 coordinator.animate(alongsideTransition: { context in
 // The workaround is to toggle some appearance related setting on the
 // navigation bar when we detect that the view controller has changed
 // interface orientations.  In our example, we call the
 // -configureNewNavBarBackground: which reapplies our appearance
 // based on the current selection.  In a real app, changing just the
 // barTintColor or barStyle would have the same effect.
 self.configureNewNavBarBackground(self.backgroundSwitcher)
 }, completion: nil)
 }
 
 
 */
/*

var inputView: UIInputView?
The primary view for the input view controller.
Controlling a Custom Keyboard
func advanceToNextInputMode()
Switches to the next keyboard in the list of user-enabled keyboards.
func dismissKeyboard()
Dismisses the custom keyboard from from the screen.

var documentContextAfterInput: String?

Textual context after the insertion point in the current text input object.
var documentContextBeforeInput: String?

Textual context before the insertion point in the current text input object.
Adjusting the Insertion Point Position
func adjustTextPosition(byCharacterOffset: Int)

Moves the insertion point forward or backward in the current text input object.

*/
/*
     
    func reportTouches(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self.view) 
        let found:UIView? = self.view.hitTest(location!,with:event!)
        if found == nil {return}
        
        if let tbBtn = found as? ToolbarButton {
        	if touch?.phase == UITouchPhase.began {
        		//print("DB-" + tbBtn.buttonName)
                commander.reportTouchBegan(tbBtn.buttonName)                
        	} else if touch?.phase == UITouchPhase.ended {
        		//print("DE-" + tbBtn.buttonName)
                commander.reportTouchEnded(tbBtn.buttonName)   
        	} else if touch?.phase == UITouchPhase.cancelled {
        		//print("DC-" + tbBtn.buttonName)
                commander.reportTouchCancelled(tbBtn.buttonName)   
        	}
        } else {
        	// Ignore that only buttons will be considered here
        }  
    } 

*/


