//
//  KeyCollectionViewCell.swift
//  Dongle
//
//  Created by vixi on 13.10.15.
//  Copyright © 2015 Anatoly Rosencrantz. All rights reserved.
//

import UIKit

class KeyCollectionViewCell: UICollectionViewCell {
    // MARK: outlets and vars
    @IBOutlet var dongleLabel: UILabel!
    
    var presentBackgroundColor: UIColor?
    var dongleText:String?{
        didSet{
           
            dongleLabel.text = dongleText!
        }
    }
    
    // MARK: UI methods
    func flush(){
        presentBackgroundColor = self.backgroundColor
        
        UIView.animate(withDuration: 0.1,
                            delay: 0.0,
                            options: UIViewAnimationOptions.autoreverse,
                            animations: {
                                self.backgroundColor = UIColor(red: 82, green: 110, blue: 121, alpha: 1.0)

                            },
                            completion:{ finished -> Void in
                                self.backgroundColor = self.presentBackgroundColor
                            })
        

    }
}
