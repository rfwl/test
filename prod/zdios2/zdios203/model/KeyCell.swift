//
//  KeyCell.swift
//  zdios203
//
//  Created by Wanlou Feng on 27/9/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit

class KeyCell : Codable {
    
    var name:String
    
    var text:String?
    var image:String?
    var widthInPopUpUnit:CGFloat = CGFloat(1)
    var fontSize:CGFloat = Settings.Main_Cell_Font_Size
    //======================================================
    //
    init(_ char:String) {
        self.name = char
        self.text = char
        self.image = nil
    }
    
    init(name:String, text:String) {
        self.name = name
        self.text = text
        self.image = nil
    }
    
    init(name:String, image:String) {
        self.name = name
        self.text = nil
        self.image = image
    }
    //======================================================
    //
    var textView:UIView {
        get {
            let lbl:UILabel = UILabel()
            lbl.textAlignment = NSTextAlignment.center
            lbl.baselineAdjustment = UIBaselineAdjustment.alignCenters
            lbl.font = lbl.font.withSize(self.fontSize)
            lbl.adjustsFontSizeToFitWidth = true
            lbl.minimumScaleFactor = CGFloat(0.1)
            lbl.isUserInteractionEnabled = false
            lbl.numberOfLines = 1
            lbl.text = self.text
            lbl.backgroundColor = UIColor.brown
            return lbl
        }
    }
    
    var imageView:UIImageView? {
        get {
            if let img = ImageLibrary.buildUIImage(self.image!) {
                let iv:UIImageView = UIImageView(image: img) //UIImageView is said to be fast
                iv.contentMode = UIViewContentMode.scaleAspectFit
                iv.backgroundColor = UIColor.brown
                return iv
            }
            return nil
        }
    }
    
    //======================================================
    // Transient Properties
    let json1 = """
    {
        "name":"P1A",
        "text":"A"
    }
    """.data(using: .utf8)!
    func decodeTest() {
        let jsonDecoder3 = JSONDecoder()
        let obj = try? jsonDecoder3.decode(KeyCell.self, from: json1)
        obj?.image = "img001"
        
        let jsonEncoder2 = JSONEncoder()
        jsonEncoder2.outputFormatting = .prettyPrinted
        
        if let json2 = try? jsonEncoder2.encode(obj) {
            if let jsonString = String(data: json2, encoding: .utf8) {
                print(jsonString)
            }
        }
    } //end of func

    //======================================================
    
} // end of class
