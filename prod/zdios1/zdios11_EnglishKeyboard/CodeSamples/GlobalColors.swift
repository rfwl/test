
class GlobalColors: NSObject {
    class var lightModeRegularKey: UIColor { get { return UIColor.whiteColor() }}
    class var darkModeRegularKey: UIColor { get { return UIColor.whiteColor().colorWithAlphaComponent(CGFloat(0.3)) }}
    class var darkModeSolidColorRegularKey: UIColor { get { return UIColor(red: CGFloat(83)/CGFloat(255), green: CGFloat(83)/CGFloat(255), blue: CGFloat(83)/CGFloat(255), alpha: 1) }}
    class var lightModeSpecialKey: UIColor { get { return GlobalColors.lightModeSolidColorSpecialKey }}
    class var lightModeSolidColorSpecialKey: UIColor { get { return UIColor(red: CGFloat(177)/CGFloat(255), green: CGFloat(177)/CGFloat(255), blue: CGFloat(177)/CGFloat(255), alpha: 1) }}
    class var darkModeSpecialKey: UIColor { get { return UIColor.grayColor().colorWithAlphaComponent(CGFloat(0.3)) }}
    class var darkModeSolidColorSpecialKey: UIColor { get { return UIColor(red: CGFloat(45)/CGFloat(255), green: CGFloat(45)/CGFloat(255), blue: CGFloat(45)/CGFloat(255), alpha: 1) }}
    class var darkModeShiftKeyDown: UIColor { get { return UIColor(red: CGFloat(214)/CGFloat(255), green: CGFloat(220)/CGFloat(255), blue: CGFloat(208)/CGFloat(255), alpha: 1) }}
    class var lightModePopup: UIColor { get { return GlobalColors.lightModeRegularKey }}
    class var darkModePopup: UIColor { get { return UIColor.grayColor() }}
    class var darkModeSolidColorPopup: UIColor { get { return GlobalColors.darkModeSolidColorRegularKey }}
    
    class var lightModeUnderColor: UIColor { get { return UIColor(hue: (220/360.0), saturation: 0.04, brightness: 0.56, alpha: 1) }}
    class var darkModeUnderColor: UIColor { get { return UIColor(red: CGFloat(38.6)/CGFloat(255), green: CGFloat(18)/CGFloat(255), blue: CGFloat(39.3)/CGFloat(255), alpha: 0.4) }}
    class var lightModeTextColor: UIColor { get { return UIColor.blackColor() }}
    class var darkModeTextColor: UIColor { get { return UIColor.whiteColor() }}
    class var lightModeBorderColor: UIColor { get { return UIColor(hue: (214/360.0), saturation: 0.04, brightness: 0.65, alpha: 1.0) }}
    class var darkModeBorderColor: UIColor { get { return UIColor.clearColor() }}
    
    class func regularKey(darkMode: Bool, solidColorMode: Bool) -> UIColor {
        if darkMode {
            if solidColorMode {
                return self.darkModeSolidColorRegularKey
            }
            else {
                return self.darkModeRegularKey
            }
        }
        else {
            return self.lightModeRegularKey
        }
    }
    
    class func popup(darkMode: Bool, solidColorMode: Bool) -> UIColor {
        if darkMode {
            if solidColorMode {
                return self.darkModeSolidColorPopup
            }
            else {
                return self.darkModePopup
            }
        }
        else {
            return self.lightModePopup
        }
    }
    
    class func specialKey(darkMode: Bool, solidColorMode: Bool) -> UIColor {
        if darkMode {
            if solidColorMode {
                return self.darkModeSolidColorSpecialKey
            }
            else {
                return self.darkModeSpecialKey
            }
        }
        else {
            if solidColorMode {
                return self.lightModeSolidColorSpecialKey
            }
            else {
                return self.lightModeSpecialKey
            }
        }
    }
}

//"darkShadowColor": UIColor(hue: (220/360.0), saturation: 0.04, brightness: 0.56, alpha: 1),
//"blueColor": UIColor(hue: (211/360.0), saturation: 1.0, brightness: 1.0, alpha: 1),
//"blueShadowColor": UIColor(hue: (216/360.0), saturation: 0.05, brightness: 0.43, alpha: 1),
