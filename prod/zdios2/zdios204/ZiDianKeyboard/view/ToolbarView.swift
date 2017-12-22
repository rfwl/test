//
//  ToolbarView.swift
//  zdios204
//
//  Created by Wanlou Feng on 20171218.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit


class ToolbarView : UIView {
 
 	let viewName = "ToolbarView"
    //=====================================================================
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        self.isOpaque = true
       
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //=====================================================================
    // Overrides
    override func layoutSubviews() {
        
        //let screenSize = UIScreen.main.bounds
        let bannerView:UILabel = UILabel(frame: self.bounds)
        
        bannerView.text = viewName
        
        //bannerView.backgroundColor = UIColor.gray
        
        bannerView.baselineAdjustment = UIBaselineAdjustment.alignCenters
        bannerView.font = bannerView.font.withSize(20)
        bannerView.adjustsFontSizeToFitWidth = true
        bannerView.minimumScaleFactor = CGFloat(0.1)
        bannerView.isUserInteractionEnabled = false
        bannerView.numberOfLines = 1
        bannerView.clipsToBounds = true
        //bannerView.autoSetDimension(.width, toSize: 124.0)
        //bannerView.autoSetDimension(.height, toSize: screenSize.width / 3)
        
        self.addSubview(bannerView)
    }
    //=====================================================================
    // Transient data area
    
    //=====================================================================
    // Operations
    
    //=====================================================================
    //
   
    
} //end of class
/*

*/
