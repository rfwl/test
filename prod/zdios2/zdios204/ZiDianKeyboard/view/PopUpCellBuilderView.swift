//
//  PopUpCellBuilderView.swift
//  zdios204
//
//  Created by Wanlou Feng on 20171218.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit


class PopUpCellBuilderView : UIView {
    
    let viewName = "PopUpCellBuilderView"
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
        
        bannerView.backgroundColor = UIColor.gray
        
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
class ProfileView: UIView {
  var shouldSetupConstraints = true
    
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
    
  override func updateConstraints() {
    if(shouldSetupConstraints) {
      // AutoLayout constraints
      shouldSetupConstraints = false
    }
    super.updateConstraints()
  }
}


class ProfileView: UIView {
  var shouldSetupConstraints = true
    
  var bannerView: UIImageView!
  var profileView: UIImageView!
  var segmentedControl: UISegmentedControl!
    
  let screenSize = UIScreen.main.bounds
  
  override init(frame: CGRect){
    super.init(frame: frame)
        
    bannerView = UIImageView(frame: CGRect.zero)
    bannerView.backgroundColor = UIColor.gray
        
    bannerView.autoSetDimension(.height, toSize: screenSize.width / 3)
    
    self.addSubview(bannerView)
        
    profileView = UIImageView(frame: CGRect.zero)
    profileView.backgroundColor = UIColor.gray
    profileView.layer.borderColor = UIColor.white.cgColor
    profileView.layer.borderWidth = 1.0
    profileView.layer.cornerRadius = 5.0
        
    profileView.autoSetDimension(.width, toSize: 124.0)
    profileView.autoSetDimension(.height, toSize: 124.0)
    
    self.addSubview(profileView)
        
    segmentedControl = UISegmentedControl(items: ["Tweets", "Media", "Likes"])
        
    self.addSubview(segmentedControl)
  }


*/
