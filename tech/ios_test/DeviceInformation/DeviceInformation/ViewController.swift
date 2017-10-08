//
//  ViewController.swift
//  DeviceInformation
//
//  Created by Wanlou Feng on 27/6/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tvMessage: UITextView!
    @IBOutlet weak var btnModelName: UIButton!
    @IBOutlet weak var btnRefLibVC: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnModelName_TouchUpInsidde(_ sender: Any) {
        

        let bw:CGFloat = UIDevice.current.modelKeyLevelButtonWidth
        let minDim:CGFloat = min(UIScreen.main.bounds.width,UIScreen.main.bounds.height)
            
        let KeyLevel_MinWidth = ceil(minDim/bw)
        let KeyLevel_Font_Size = KeyLevel_MinWidth * 0.60
        let KeyLevel_RowHeight = KeyLevel_MinWidth * 1.0
        let KeyLevel_PaddingTop = KeyLevel_MinWidth * 0.10
        let Toolbar_Height = KeyLevel_MinWidth * 1.2
        let nm = UIDevice.current.modelName
        let scl = UIScreen.main.scale
        let Physical_Width = UIScreen.main.bounds.width * scl
        let Physical_Height = UIScreen.main.bounds.height * scl
        tvMessage.text = "Device Model Name=\(nm)\n"
        + "Screen Width=\(UIScreen.main.bounds.width)\n"
        + "Screen Height=\(UIScreen.main.bounds.height)\n"
        + "KeyLevel_MinWidth=\(KeyLevel_MinWidth)\n"
        + "KeyLevel_Font_Size=\(KeyLevel_Font_Size)\n"
        + "KeyLevel_RowHeight=\(KeyLevel_RowHeight)\n"
        + "KeyLevel_PaddingTop=\(KeyLevel_PaddingTop)\n"
        + "Toolbar_Height=\(Toolbar_Height)\n"
        + "Screen_Physical_Width=\(Physical_Width)\n"
        + "Screen_Physical_Height=\(Physical_Height)\n"
        
        
    }
    
    @IBAction func btnRefLibVC_TouchUpInside(_ sender: Any) {
        
        let refLibVC: UIReferenceLibraryViewController = UIReferenceLibraryViewController(term: "一")
        self.present(refLibVC,animated:true,completion:nil)
        
        
    }
    
    
    
    
    
    
    
    
    
} //end of class


public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
    var modelKeyLevelButtonWidth: CGFloat {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return 6.0 //"iPod Touch 5"
        case "iPod7,1":                                 return 6.0 //"iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return 6.0 //"iPhone 4"
        case "iPhone4,1":                               return 6.0 //"iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return 6.0 //"iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return 6.0 //"iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return 6.0 //"iPhone 5s"
        case "iPhone7,2":                               return 6.0 //"iPhone 6"
        case "iPhone7,1":                               return 6.0 //"iPhone 6 Plus"
        case "iPhone8,1":                               return 8.0 //"iPhone 6s"
        case "iPhone8,2":                               return 8.0 //"iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return 10.0 //"iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return 13.0 //"iPhone 7 Plus"
        case "iPhone8,4":                               return 8.0 //"iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return 17.0 //"iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return 17.0 //"iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return 17.0 //"iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return 17.0 //"iPad Air"
        case "iPad5,3", "iPad5,4":                      return 17.0 //"iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return 17.0 //"iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return 17.0 //"iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return 17.0 //"iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return 17.0 //"iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return 17.0 //"iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return 17.0 //"iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return 24.0 //"iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return 24.0 //"iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return 21.0 //"iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return 40.0 //"Apple TV"
        case "i386", "x86_64":                          return 11.0 //"Simulator"
        default:                                        return 11.0 //identifier
        }
    }
    
    
    
} //end of extension
