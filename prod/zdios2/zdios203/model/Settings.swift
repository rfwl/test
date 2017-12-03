//
//  Settings.swift
//  zdios203
//
//  Created by Wanlou Feng on 7/11/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit

class Settings {
   
    static let Main_Cell_Font_Size:CGFloat = CGFloat(22)
    static let Secondary_Cell_Font_Size:CGFloat = CGFloat(10)
    static let PopUp_Cell_Font_Size:CGFloat = CGFloat(16)
    
    //======================================================
    
        
    //======================================================
    
} // end of class

class PopUpSettings {
    
    static var popUpBorderWidth = CGFloat(3.0)
    static var popUpBorderColor:UIColor = UIColor.gray
    static var popUpGap = CGFloat(10.0) // The gap below popup and above the KeyView will be used as corner radius between pop-up and self.frame
    static var popUpCornerRadius = CGFloat(5.0)
    static var popUpHeight = CGFloat(40.0)
    
    static var popUpUnitWidth = CGFloat(30.0)
    static var popUpCellGap = CGFloat(3.0)
    
    static var heightAboveKeyboardView:CGFloat {
        get {
            return popUpHeight + popUpGap + popUpBorderWidth
        }
    }
    
    static var minDelta:CGFloat {
        get {
            return popUpCornerRadius + popUpGap + popUpBorderWidth
        }
    }
    
} //end of class

