//
//  Configuration.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 22/02/2017.
//  Copyright © 2017 Richard Feng. All rights reserved.
//

import UIKit

class Configuration {

	
    
	static var KeyLevel_Font_Name:String = "HelveticaNeue"
    static var KeyLevel_BorderColor_HexString:String = "#f0f0f0"
    static var KeyLevel_BackgroundColor_1_HexString:String = "#b3bdc9"
    static var KeyLevel_BackgroundColor_2_HexString:String = "#c2d9d5"
    //------------------------- iPHONE7
    static var Toolbar_Height:CGFloat = 40
    static var KeyLevel_Font_Size:CGFloat = 22
    static var KeyLevel_RowHeight:CGFloat = 40
    static var KeyLevel_MinWidth:CGFloat = 36
    static var KeyLevel_PaddingTop:CGFloat = 5
    //------------------------- getters
    
    static func compute() {
        let bw:CGFloat = UIDevice.current.modelKeyLevelButtonWidth
        let minDim:CGFloat = min(UIScreen.main.bounds.width,UIScreen.main.bounds.height)
        
        KeyLevel_MinWidth = ceil(minDim/bw)
        KeyLevel_Font_Size = KeyLevel_MinWidth * 0.60
        KeyLevel_RowHeight = KeyLevel_MinWidth * 1.0
        KeyLevel_PaddingTop = KeyLevel_MinWidth * 0.10
        Toolbar_Height = KeyLevel_MinWidth * 1.2
        
    }

    
} // end of class


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

/*
 
//------------------------- iPAD
static var iPad_Toolbar_Height:CGFloat = 60
static var iPad_KeyLevel_Font_Size:CGFloat = 60
static var iPad_KeyLevel_RowHeight:CGFloat = 60
static var iPad_KeyLevel_MinWidth:CGFloat = 190
static var iPad_KeyLevel_PaddingTop:CGFloat = 8
//------------------------- iPHONE7
static var iPhone_Toolbar_Height:CGFloat = 40
static var iPhone_KeyLevel_Font_Size:CGFloat = 22
static var iPhone_KeyLevel_RowHeight:CGFloat = 40
static var iPhone_KeyLevel_MinWidth:CGFloat = 36
static var iPhone_KeyLevel_PaddingTop:CGFloat = 5
//------------------------- getters
static var isIPad: Bool {
    if UIScreen.main.bounds.size.width>2000 { return true }
    else {return false}
}

static var Toolbar_Height: CGFloat {
    if isIPad { return iPad_Toolbar_Height }
    else {return iPhone_Toolbar_Height }
}

static var KeyLevel_Font_Size: CGFloat {
    if isIPad { return iPad_KeyLevel_Font_Size }
    else {return iPhone_KeyLevel_Font_Size }
}

static var KeyLevel_RowHeight: CGFloat {
    if isIPad { return iPad_KeyLevel_RowHeight }
    else {return iPhone_KeyLevel_RowHeight }
}

static var KeyLevel_MinWidth: CGFloat {
    if isIPad { return iPad_KeyLevel_MinWidth }
    else {return iPhone_KeyLevel_MinWidth }
}

static var KeyLevel_PaddingTop: CGFloat {
    if isIPad { return iPad_KeyLevel_PaddingTop }
    else {return iPhone_KeyLevel_PaddingTop }
}
 
*/



