//
//  PredictionContainerView.swift
//  zdios204
//
//  Created by Wanlou Feng on 20171218.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit


class PredictionContainerView: UIView {
    
  let viewName = "PredictionContainerView"
    //=====================================================================
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        self.isOpaque = true
        
        let screenSize = UIScreen.main.bounds
    	var bannerView:UIlabel = UILabel(frame: CGRect.zero)
    	
    	bannerView.text = viewName
    	
    	bannerView.backgroundColor = UIColor.gray
    	bannerView.autoSetDimension(.width, toSize: 124.0)
        bannerView.autoSetDimension(.height, toSize: screenSize.width / 3) 	
         
    	self.addSubview(bannerView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //=====================================================================
    // Overrides
    
    //=====================================================================
    // Transient data area
    
    //=====================================================================
    // Operations
    
    //=====================================================================
    //
   
    
} //end of class
/*

*/
