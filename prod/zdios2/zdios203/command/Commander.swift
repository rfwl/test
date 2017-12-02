//
//  KeyboardCommander.swift
//  zdios202
//
//  Created by Wanlou Feng on 1/10/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension UIView {
    func clearSubviews() {
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
    }
}

class Commander {
    //===================================================
    // Workers    
    static var keyboardView:KeyboardView?
    static var popUpContainerView : PopUpContainerView?
    
    //===================================================
    // Start-up
    static func startUp1(){
        let bldr = KeyboardDefinitionJsonBuilder()
        let strKBD = bldr.buildDefaultKeyboard()
        
        do {
            let kbdDef = try JSONDecoder().decode(KeyboardDefinition.self, from: strKBD.data(using: .utf8)! )
            // Load the keyboard definition onto the keyboard view.
            keyboardView?.keyboardDefinition = kbdDef
            
            keyboardView?.drawPageAt(0)
            
        } catch let jsonErr {
            print("Error serializing json", jsonErr)
        }
        
    } //end of func
    
    static func startUp() throws{
        //---------------------------------------------
    	// Build a json string, write to a file
        let bldr = KeyboardDefinitionJsonBuilder()
        let strKBD = bldr.buildDefaultKeyboard()
        //---------------------------------------------
        // Write a json string to a file
        let res_url = Bundle.main.resourceURL
        let localUrl = res_url?.appendingPathComponent("DefaultKeyboardDefinition1.json")
        try strKBD.write(to: localUrl!, atomically: true, encoding: String.Encoding.utf8)

        //---------------------------------------------
        // Retrieve the directories
   	    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        print(documentDirectory!)
        
        let resPath = Bundle.main.resourcePath
        print(resPath!)
        
        let resUrl = Bundle.main.resourceURL
        if let resUrl = resUrl { print(resUrl) }
        
        //---------------------------------------------
        // Read in the keyboard definition file into string
        //let res_url = Bundle.main.resourceURL
        //let localUrl = res_url?.appendingPathComponent("DefaultKeyboardDefinition1.json")
		if FileManager.default.fileExists(atPath: localUrl!.path){
            if let fileContents = NSData(contentsOfFile: localUrl!.path) {
                //guard
                let data = fileContents as Data //else {return}
                do {
                
                    // Decode into Keyboard Definition object.
                    let kbdDef =  try JSONDecoder().decode(KeyboardDefinition.self, from: data)
                    // Load the keyboard definition onto the keyboard view.
                    keyboardView?.keyboardDefinition = kbdDef
                     keyboardView?.drawPageAt(0)
                } catch let jsonErr {
                    print("Error serializing json", jsonErr)
                }
            }
        }
    } //end of func
    
    
    //===================================================
    //
    static func drawPageAt(_ index:Int){
       keyboardView?.drawPageAt(index)
    }
    
    
    //===================================================
    // Report KeyView Touches
    
    static func reportTouchStatus(_ touchStatus:EnumTouchStatus, kv:KeyView,  downLoc:CGPoint=CGPoint.zero, curLoc: CGPoint=CGPoint.zero ) {
        print( touchStatus.toString() )
        switch touchStatus {
        case .Down: onTouch_Down(kv,downLoc:downLoc)
        case .DownHold: onTouch_DownHold(kv,downLoc:downLoc)
        case .DownHoldMove: onTouch_DownHoldMove(kv, moveX: curLoc.x, downX: downLoc.x)
        case .DownHoldMoveUp: onTouch_DownHoldMoveUp(kv)
        case .DownUp: onTouch_DownUp(kv)
        case .DownHoldUp: onTouch_DownHoldUp(kv)
        default: break
            
        }
        
       
    }
    //===================================================
    //
    static func onTouch_Down(_ keyView:KeyView?, downLoc:CGPoint=CGPoint.zero) {
        let systemSoundID: SystemSoundID = 1104
        AudioServicesPlaySystemSound(systemSoundID)
        if let pucvw = popUpContainerView {
            if let kvw = keyView {
                pucvw.showPopUp_MainCell(kvw)
            }
        }
    }
    static func onTouch_DownHold(_ keyView:KeyView?, downLoc:CGPoint=CGPoint.zero) {
        if let pucvw = popUpContainerView {
            if let kvw = keyView {
                pucvw.showPopUp_SecondaryCells(kvw,touchDownX: downLoc.x )
                pucvw.highlightCellView(kvw,moveX: downLoc.x, downX: downLoc.x )
            }
        }
    }
    static func onTouch_DownUp(_ keyView:KeyView?) {
        if let pucvw = popUpContainerView {
                pucvw.hidePopUp()
                pucvw.clearSubviews()
        }
    }
    static func onTouch_DownHoldUp(_ keyView:KeyView?) {
        let systemSoundID: SystemSoundID = 1057
        AudioServicesPlaySystemSound (systemSoundID)
        if let pucvw = popUpContainerView {
            pucvw.hidePopUp()
            pucvw.clearSubviews()
        }
    }
    static func onTouch_DownHoldMove(_ keyView:KeyView?, moveX: CGFloat, downX: CGFloat ) {
        if let pucvw = popUpContainerView {
            if let kvw = keyView {
                pucvw.highlightCellView(kvw,moveX: moveX, downX: downX )
            }
        }
    }
    static func onTouch_DownHoldMoveUp(_ keyView:KeyView?) {
        if let pucvw = popUpContainerView {
            pucvw.hidePopUp()
            pucvw.clearSubviews()
        }
    }
    //===================================================
    //
    
    
    
} // end of class

/* File operation codes
 var fileManager = NSFileManager()
 var tmpDir = NSTemporaryDirectory()
 let fileName = "sample.txt"
 
 func enumerateDirectory() -> String? {
 var error: NSError?
 let filesInDirectory =  fileManager.contentsOfDirectoryAtPath(tmpDir, error: &error) as? [String]
 
 if let files = filesInDirectory {
 if files.count > 0 {
 if files[0] == fileName {
 println("sample.txt found")
 return files[0]
 } else {
 println("File not found")
 return nil
 }
 }
 }
 return nil
 }
 
 @IBAction func createFile(sender: AnyObject) {
 let path = tmpDir.stringByAppendingPathComponent(fileName)
 let contentsOfFile = "Sample Text"
 var error: NSError?
 
 // Write File
 if contentsOfFile.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: &error) == false {
 if let errorMessage = error {
 println("Failed to create file")
 println("\(errorMessage)")
 }
 } else {
 println("File sample.txt created at tmp directory")
 }
 }
 
 
 @IBAction func listDirectory(sender: AnyObject) {
 // List Content of Path
 let isFileInDir = enumerateDirectory() ?? "Empty"
 println("Contents of Directory =  \(isFileInDir)")
 }
 
 @IBAction func viewFileContent(sender: AnyObject) {
 let isFileInDir = enumerateDirectory() ?? ""
 
 let path = tmpDir.stringByAppendingPathComponent(isFileInDir)
 let contentsOfFile = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
 
 if let content = contentsOfFile {
 println("Content of file = \(content)")
 } else {
 println("No file found")
 }
 }
 
 @IBAction func deleteFile(sender: AnyObject) {
 var error: NSError?
 
 if let isFileInDir = enumerateDirectory() {
 let path = tmpDir.stringByAppendingPathComponent(isFileInDir)
 fileManager.removeItemAtPath(path, error: &error)
 } else {
 println("No file found")
 }
 }
 

 
 */

