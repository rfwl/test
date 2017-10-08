import Foundation
import UIKit
//import QuartzCore

class KeyLevelButton: UIButton {
    
	let parentKeyLevel:KeyLevel
	
    override init(frame: CGRect, keyLevel:KeyLevel) {
        super.init(frame: frame)
        parentKeyLevel = keyLevel
        titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18.0)
        titleLabel?.textAlignment = .Center
        setTitleColor(UIColor(white: 238.0/255, alpha: 1.0), forState: UIControlState.Normal)
        titleLabel?.sizeToFit()
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        let gradientColors: [AnyObject] = [UIColor(red: 80.0/255, green: 80.0/255, blue: 80.0/255, alpha: 1.0).CGColor, UIColor(red: 60.0/255, green: 60.0/255, blue: 60.0/255, alpha: 1.0).CGColor]
        gradient.colors = gradientColors // Declaration broken into two lines to prevent 'unable to bridge to Objective C' error.
        setBackgroundImage(gradient.UIImageFromCALayer(), forState: .Normal)
        
        let selectedGradient = CAGradientLayer()
        selectedGradient.frame = bounds
        let selectedGradientColors: [AnyObject] = [UIColor(red: 67.0/255, green: 116.0/255, blue: 224.0/255, alpha: 1.0).CGColor, UIColor(red: 32.0/255, green: 90.0/255, blue: 214.0/255, alpha: 1.0).CGColor]
        selectedGradient.colors = selectedGradientColors // Declaration broken into two lines to prevent 'unable to bridge to Objective C' error.
        setBackgroundImage(selectedGradient.UIImageFromCALayer(), forState: .Selected)
        
        layer.masksToBounds = true
        layer.cornerRadius = 3.0
        
        contentVerticalAlignment = .Center
        contentHorizontalAlignment = .Center
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0)
        
        
        
    } // end of func
    
    //required init(coder aDecoder: NSCoder) {
    //    fatalError("init(coder:) has not been implemented")
    //}
    
} //end of class

/*
  private func addShiftButton() {
        shiftButton = KeyButton(frame: CGRectMake(spacing, keyHeight * 2.0 + spacing * 3.0 + predictiveTextBoxHeight, keyWidth * 1.5 + spacing * 0.5, keyHeight))
        shiftButton.setTitle("\u{000021E7}", forState: .Normal)
        shiftButton.addTarget(self, action: "shiftButtonPressed:", forControlEvents: .TouchUpInside)
        self.view.addSubview(shiftButton)
    }
    
    func createButtonWithTitle(title: String, frame:CGRect) -> UIButton {
        
        let button = UIButton.init(type:.system)
        button.frame = frame
        button.setTitle(title, for: .normal)        
        button.titleLabel?.font = UIFont.systemFont(ofSize:15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        button.setTitleColor(UIColor.darkGray, for: .normal)        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)        
        return button
    }
*/

 