//
//  KeyCell.swift
//  zdios202
//
//  Created by Wanlou Feng on 27/9/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation

class KeyCell {
    var output:String
    var labelingType:EnumLabelingType
    
    var text:String?
    var shape:String?
    var icon:String?
    
    enum EnumLabelingType {
        case Text
        case Shape
        case Icon
    }
    
    init(_ char:String) {
        self.output = char
        self.text = char
        self.shape = nil
        self.icon = nil
        self.labelingType = EnumLabelingType.Text
    }
    
    init(text:String, output:String) {
        self.output = output
        self.text = text
        self.shape = nil
        self.icon = nil
        self.labelingType = EnumLabelingType.Text
    }
    
    init(shape:String, output:String) {
        self.output = output
        self.text = nil
        self.shape = shape
        self.icon = nil
        self.labelingType = EnumLabelingType.Shape
    }
    
    init(icon:String, output:String) {
        self.output = output
        self.text = nil
        self.shape = nil
        self.icon = icon
        self.labelingType = EnumLabelingType.Icon
    }
    
    
} // end of class
