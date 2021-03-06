import UIKit

class KeyView: UIButton {
   
   	//==================================================
   	// Data Context
 	var keyDefinition : KeyboardKey?
    
    
    
    required init(_ key: KeyboardKey) {
        super.init(frame: key.frame)
        self.titleLabel?.text = key.label
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


 
   	/*
     
     
     
     
     
     class ExtraView: UIView {
     
     var globalColors: GlobalColors.Type?
     var darkMode: Bool
     var solidColorMode: Bool
     
     required init(globalColors: GlobalColors.Type?, darkMode: Bool, solidColorMode: Bool) {
     self.globalColors = globalColors
     self.darkMode = darkMode
     self.solidColorMode = solidColorMode
     
     super.init(frame: CGRectZero)
     }
     
     required init?(coder aDecoder: NSCoder) {
     self.globalColors = nil
     self.darkMode = false
     self.solidColorMode = false
     
     super.init(coder: aDecoder)
     }
     }
     
     
    //==================================================
  	// 
    init(vibrancy optionalVibrancy: VibrancyType?) {
        super.init(frame: CGRectZero)        
        self.vibrancy = optionalVibrancy
        
        self.displayView = ShapeView()
        self.underView = ShapeView()
        self.borderView = ShapeView()
        
        self.shadowLayer = CAShapeLayer()
        self.shadowView = UIView()
        
        self.label = UILabel()
        self.text = ""
        
        self.color = UIColor.whiteColor()
        self.underColor = UIColor.grayColor()
        self.borderColor = UIColor.blackColor()
        
        self.drawUnder = true
        self.drawOver = true
        self.drawBorder = false
        self.underOffset = 1
        
        self.background = KeyboardKeyBackground(cornerRadius: 4, underOffset: self.underOffset)
        
        self.textColor = UIColor.blackColor()
        
        self.popupColor = UIColor.whiteColor()
        self.popupDirection = nil
                
        self.addSubview(self.shadowView)
        self.shadowView.layer.addSublayer(self.shadowLayer)
        
        self.addSubview(self.displayView)
        if let underView = self.underView {
            self.addSubview(underView)
        }
        if let borderView = self.borderView {
            self.addSubview(borderView)
        }
        
        self.addSubview(self.background)
        self.background.addSubview(self.label)
        
        let setupViews: Void = {
            self.displayView.opaque = false
            self.underView?.opaque = false
            self.borderView?.opaque = false
            
            self.shadowLayer.shadowOpacity = Float(0.2)
            self.shadowLayer.shadowRadius = 4
            self.shadowLayer.shadowOffset = CGSizeMake(0, 3)
            
            self.borderView?.lineWidth = CGFloat(0.5)
            self.borderView?.fillColor = UIColor.clearColor()
            
            self.label.textAlignment = NSTextAlignment.Center
            self.label.baselineAdjustment = UIBaselineAdjustment.AlignCenters
            self.label.font = self.label.font.fontWithSize(22)
            self.label.adjustsFontSizeToFitWidth = true
            self.label.minimumScaleFactor = CGFloat(0.1)
            self.label.userInteractionEnabled = false
            self.label.numberOfLines = 1
        }()
        
    } // end of init 
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
   	//==================================================
   	// 
   
	override var highlighted: Bool {
        didSet {
            updateColors()
        }
    }
    
    override var frame: CGRect {
        didSet {
            self.redrawText()
        }
    }
    
   
    override func setNeedsLayout() {
        return super.setNeedsLayout()
    }
    
    var oldBounds: CGRect?
    
    override func layoutSubviews() {
        self.layoutPopupIfNeeded()
        
        let boundingBox = (self.popup != nil ? CGRectUnion(self.bounds, self.popup!.frame) : self.bounds)
        
        if self.bounds.width == 0 || self.bounds.height == 0 {
            return
        }
        if oldBounds != nil && CGSizeEqualToSize(boundingBox.size, oldBounds!.size) {
            return
        }
        oldBounds = boundingBox

        super.layoutSubviews()
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        self.background.frame = self.bounds
        self.label.frame = CGRectMake(self.labelInset, self.labelInset, self.bounds.width - self.labelInset * 2, self.bounds.height - self.labelInset * 2)
        
        self.displayView.frame = boundingBox
        self.shadowView.frame = boundingBox
        self.borderView?.frame = boundingBox
        self.underView?.frame = boundingBox
        
        CATransaction.commit()        
        self.refreshViews()
    }
    
    override var enabled: Bool { didSet { updateColors() }}
    override var selected: Bool {
        didSet {
            updateColors()
        }
    }
   
   	
   	//==================================================
   	// 
    weak var delegate: KeyboardKeyProtocol?
 
    var vibrancy: VibrancyType?    
    var text: String {
        didSet {
            self.label.text = text
            self.label.frame = CGRectMake(self.labelInset, self.labelInset, self.bounds.width - self.labelInset * 2, self.bounds.height - self.labelInset * 2)
            self.redrawText()
        }
    }    
    var color: UIColor { didSet { updateColors() }}
    var underColor: UIColor { didSet { updateColors() }}
    var borderColor: UIColor { didSet { updateColors() }}
    var drawUnder: Bool { didSet { updateColors() }}
    var drawOver: Bool { didSet { updateColors() }}
    var drawBorder: Bool { didSet { updateColors() }}
    var underOffset: CGFloat { didSet { updateColors() }}
    
    var textColor: UIColor { didSet { updateColors() }}
    var downColor: UIColor? { didSet { updateColors() }}
    var downUnderColor: UIColor? { didSet { updateColors() }}
    var downBorderColor: UIColor? { didSet { updateColors() }}
    var downTextColor: UIColor? { didSet { updateColors() }}
    
    var labelInset: CGFloat = 0 {
        didSet {
            if oldValue != labelInset {
                self.label.frame = CGRectMake(self.labelInset, self.labelInset, self.bounds.width - self.labelInset * 2, self.bounds.height - self.labelInset * 2)
            }
        }
    }
    
    var shouldRasterize: Bool = false {
        didSet {
            for view in [self.displayView, self.borderView, self.underView] {
                view?.layer.shouldRasterize = shouldRasterize
                view?.layer.rasterizationScale = UIScreen.mainScreen().scale
            }
        }
    }
    
    
    
  
  
  
    var label: UILabel
   
    var shape: Shape? {
        didSet {
            if oldValue != nil && shape == nil {
                oldValue?.removeFromSuperview()
            }
            self.redrawShape()
            updateColors()
        }
    }
    
    var background: KeyboardKeyBackground
    var connector: KeyboardConnector?
    
    var displayView: ShapeView
    var borderView: ShapeView?
    var underView: ShapeView?
    
    var shadowView: UIView
    var shadowLayer: CALayer
    
    //==================================================
   	// 
   	
   	func refreshViews() {
        self.refreshShapes()
        self.redrawText()
        self.redrawShape()
        self.updateColors()
    }
    
    func refreshShapes() {
        // TODO: dunno why this is necessary
        self.background.setNeedsLayout()
        
        self.background.layoutIfNeeded()
        self.popup?.layoutIfNeeded()
        self.connector?.layoutIfNeeded()
        
        let testPath = UIBezierPath()
        let edgePath = UIBezierPath()
        
        let unitSquare = CGRectMake(0, 0, 1, 1)
        
        // TODO: withUnder
        let addCurves = { (fromShape: KeyboardKeyBackground?, toPath: UIBezierPath, toEdgePaths: UIBezierPath) -> Void in
            if let shape = fromShape {
                let path = shape.fillPath
                let translatedUnitSquare = self.displayView.convertRect(unitSquare, fromView: shape)
                let transformFromShapeToView = CGAffineTransformMakeTranslation(translatedUnitSquare.origin.x, translatedUnitSquare.origin.y)
                path?.applyTransform(transformFromShapeToView)
                if path != nil { toPath.appendPath(path!) }
                if let edgePaths = shape.edgePaths {
                    for (_, anEdgePath) in edgePaths.enumerate() {
                        let editablePath = anEdgePath
                        editablePath.applyTransform(transformFromShapeToView)
                        toEdgePaths.appendPath(editablePath)
                    }
                }
            }
        }
        
        addCurves(self.popup, testPath, edgePath)
        addCurves(self.connector, testPath, edgePath)
        
        let shadowPath = UIBezierPath(CGPath: testPath.CGPath)
        
        addCurves(self.background, testPath, edgePath)
        
        let underPath = self.background.underPath
        let translatedUnitSquare = self.displayView.convertRect(unitSquare, fromView: self.background)
        let transformFromShapeToView = CGAffineTransformMakeTranslation(translatedUnitSquare.origin.x, translatedUnitSquare.origin.y)
        underPath?.applyTransform(transformFromShapeToView)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let _ = self.popup {
            self.shadowLayer.shadowPath = shadowPath.CGPath
        }
        
        self.underView?.curve = underPath
        self.displayView.curve = testPath
        self.borderView?.curve = edgePath
        
        if let borderLayer = self.borderView?.layer as? CAShapeLayer {
            borderLayer.strokeColor = UIColor.greenColor().CGColor
        }
        
        CATransaction.commit()
    }
    
    
    //==================================================
   	// Colors
   	func updateColors() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let switchColors = self.highlighted || self.selected
        
        if switchColors {
            if let downColor = self.downColor {
                self.displayView.fillColor = downColor
            }
            else {
                self.displayView.fillColor = self.color
            }
            
            if let downUnderColor = self.downUnderColor {
                self.underView?.fillColor = downUnderColor
            }
            else {
                self.underView?.fillColor = self.underColor
            }
            
            if let downBorderColor = self.downBorderColor {
                self.borderView?.strokeColor = downBorderColor
            }
            else {
                self.borderView?.strokeColor = self.borderColor
            }
            
            if let downTextColor = self.downTextColor {
                self.label.textColor = downTextColor
                self.popupLabel?.textColor = downTextColor
                self.shape?.color = downTextColor
            }
            else {
                self.label.textColor = self.textColor
                self.popupLabel?.textColor = self.textColor
                self.shape?.color = self.textColor
            }
        }
        else {
            self.displayView.fillColor = self.color
            
            self.underView?.fillColor = self.underColor
            
            self.borderView?.strokeColor = self.borderColor
            
            self.label.textColor = self.textColor
            self.popupLabel?.textColor = self.textColor
            self.shape?.color = self.textColor
        }
        
        if self.popup != nil {
            self.displayView.fillColor = self.popupColor
        }
        
        CATransaction.commit()
    }
   	
   	
   	//==================================================
   	// Text

    
       
    func redrawText() {
//        self.keyView.frame = self.bounds
//        self.button.frame = self.bounds
//        
//        self.button.setTitle(self.text, forState: UIControlState.Normal)
    }
    
   	//==================================================
   	// Shape
       

    
    func redrawShape() {
        if let shape = self.shape {
            self.text = ""
            shape.removeFromSuperview()
            self.addSubview(shape)
            
            let pointOffset: CGFloat = 4
            let size = CGSizeMake(self.bounds.width - pointOffset - pointOffset, self.bounds.height - pointOffset - pointOffset)
            shape.frame = CGRectMake(
                CGFloat((self.bounds.width - size.width) / 2.0),
                CGFloat((self.bounds.height - size.height) / 2.0),
                size.width,
                size.height)
            
            shape.setNeedsLayout()
        }
    }
    
    
  	//==================================================
   	// Pop-up 
     
    var popupColor: UIColor { didSet { updateColors() }} 
    var popupDirection: Direction?
    var popupLabel: UILabel? 
    var popup: KeyboardKeyBackground?
    
    func layoutPopupIfNeeded() {
        if self.popup != nil && self.popupDirection == nil {
            self.shadowView.hidden = false
            self.borderView?.hidden = false
            
            self.popupDirection = Direction.Up
            
            self.layoutPopup(self.popupDirection!)
            self.configurePopup(self.popupDirection!)
            
            self.delegate?.willShowPopup(self, direction: self.popupDirection!)
        }
        else {
            self.shadowView.hidden = true
            self.borderView?.hidden = true
        }
    }
    
     
    func layoutPopup(dir: Direction) {
        assert(self.popup != nil, "popup not found")
        
        if let popup = self.popup {
            if let delegate = self.delegate {
                let frame = delegate.frameForPopup(self, direction: dir)
                popup.frame = frame
                popupLabel?.frame = popup.bounds
            }
            else {
                popup.frame = CGRectZero
                popup.center = self.center
            }
        }
    }
    
    func configurePopup(direction: Direction) {
        assert(self.popup != nil, "popup not found")
        
        self.background.attach(direction)
        self.popup!.attach(direction.opposite())
        
        let kv = self.background
        let p = self.popup!
        
        self.connector?.removeFromSuperview()
        self.connector = KeyboardConnector(cornerRadius: 4, underOffset: self.underOffset, start: kv, end: p, startConnectable: kv, endConnectable: p, startDirection: direction, endDirection: direction.opposite())
        self.connector!.layer.zPosition = -1
        self.addSubview(self.connector!)
        
//      self.drawBorder = true
        
        if direction == Direction.Up {
//            self.popup!.drawUnder = false
//            self.connector!.drawUnder = false
        }
    }
    
    func showPopup() {
        if self.popup == nil {
            self.layer.zPosition = 1000
            
            let popup = KeyboardKeyBackground(cornerRadius: 9.0, underOffset: self.underOffset)
            self.popup = popup
            self.addSubview(popup)
            
            let popupLabel = UILabel()
            popupLabel.textAlignment = self.label.textAlignment
            popupLabel.baselineAdjustment = self.label.baselineAdjustment
            popupLabel.font = self.label.font.fontWithSize(22 * 2)
            popupLabel.adjustsFontSizeToFitWidth = self.label.adjustsFontSizeToFitWidth
            popupLabel.minimumScaleFactor = CGFloat(0.1)
            popupLabel.userInteractionEnabled = false
            popupLabel.numberOfLines = 1
            popupLabel.frame = popup.bounds
            popupLabel.text = self.label.text
            popup.addSubview(popupLabel)
            self.popupLabel = popupLabel
            
            self.label.hidden = true
        }
    }
    
    func hidePopup() {
        if self.popup != nil {
            self.delegate?.willHidePopup(self)
            
            self.popupLabel?.removeFromSuperview()
            self.popupLabel = nil
            
            self.connector?.removeFromSuperview()
            self.connector = nil
            
            self.popup?.removeFromSuperview()
            self.popup = nil
            
            self.label.hidden = false
            self.background.attach(nil)
            
            self.layer.zPosition = 0
            
            self.popupDirection = nil
        }
    }
    //==================================================
   	// Pop-up 
    */
    
    
} //end of class 
