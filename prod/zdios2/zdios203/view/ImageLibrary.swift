//
//  ImageLibrary.swift
//  zdios202
//
//  Created by Wanlou Feng on 3/10/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit

class ImageLibrary {

    static func buildUIImage(_ image: String) -> UIImage? {
        var imgName:String = ""
        switch image {
        case "Return":
            imgName = "enter_key"
            break
        case "Space":
            imgName = "space_key"
            break
        case "Next":
            imgName = "next_key"
            break
        default:
            break
        }
        let img : UIImage? = UIImage(named: "key_icons/" + imgName)
        return img
    }
    
    
    
} // end of class

