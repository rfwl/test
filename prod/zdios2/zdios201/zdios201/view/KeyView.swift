import UIKit

class KeyView: UIControl {

    //=========================================================================================
    // Init Data
    
    var label: UILabel
    var labelInset: CGFloat = 0 {
        didSet {
            if oldValue != labelInset {
                self.label.frame = CGRect(x: self.labelInset, y:self.labelInset, width:self.bounds.width - self.labelInset * 2, height:self.bounds.height - self.labelInset * 2)
            }
        }
    }
    
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
    var vibrancy: VibrancyType?
    //=========================================================================================
    //    	
  	
    init(vibrancy optionalVibrancy: VibrancyType?, key: KeyboardKey) {
        ////super.init(frame: CGRect.zero)
        self.vibrancy = optionalVibrancy
        
        self.displayView = ShapeView()
        self.underView = ShapeView()
        self.borderView = ShapeView()
        
        self.shadowLayer = CAShapeLayer()
        self.shadowView = UIView()
        
        self.label = UILabel()

        if let lbl = key.label {
            self.text = lbl
        } else {
            self.text = "A"
        }
       
            
        self.color = UIColor.white
        self.underColor = UIColor.gray
        self.borderColor = UIColor.black
        
        self.drawUnder = true
        self.drawOver = true
        self.drawBorder = true
        self.underOffset = 2
        
        self.background = KeyboardKeyBackground(frame: key.frame, cornerRadius: 4, underOffset: self.underOffset)
        
        self.textColor = UIColor.black
        
        self.popupColor = UIColor.white
        self.popupDirection = nil
        
        super.init(frame: key.frame)
        
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
        
        //let setupViews: Void = {
        let _ : Void = {
            self.displayView.isOpaque = false
            self.underView?.isOpaque = false
            self.borderView?.isOpaque = false
            
            self.shadowLayer.shadowOpacity = Float(0.2)
            self.shadowLayer.shadowRadius = 4
            self.shadowLayer.shadowOffset = CGSize(width: 0, height: 3)
            
            self.borderView?.lineWidth = CGFloat(0.5)
            self.borderView?.fillColor = UIColor.clear
            
            self.label.textAlignment = NSTextAlignment.center
            self.label.baselineAdjustment = UIBaselineAdjustment.alignCenters
            self.label.font = self.label.font.withSize(22)
            self.label.adjustsFontSizeToFitWidth = true
            self.label.minimumScaleFactor = CGFloat(0.1)
            self.label.isUserInteractionEnabled = false
            self.label.numberOfLines = 1
        }()
        
    } // end of init 
  
 	required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    } 
 	 
   	//==================================================
   	// Overrides   
	//override
    override var isHighlighted: Bool {
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
        
        let boundingBox = (self.popup != nil ? self.bounds.union(self.popup!.frame) : self.bounds)
        
        if self.bounds.width == 0 || self.bounds.height == 0 {
            return
        }
        if oldBounds != nil && boundingBox.size.equalTo(oldBounds!.size) {
            return
        }
        oldBounds = boundingBox

        super.layoutSubviews()
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        self.background.frame = self.bounds
        self.label.frame = CGRect(x: self.labelInset, y: self.labelInset, width: self.bounds.width - self.labelInset * 2, height: self.bounds.height - self.labelInset * 2)
        
        self.displayView.frame = boundingBox
        self.shadowView.frame = boundingBox
        self.borderView?.frame = boundingBox
        self.underView?.frame = boundingBox
        
        CATransaction.commit()        
        self.refreshViews()
    }
    
    //override
    override var isEnabled: Bool { didSet { updateColors() }}
 
    //override
    override var isSelected: Bool {
        didSet {
            updateColors()
        }
    }
   	
   	//==================================================
   	// 
    weak var delegate: KeyboardKeyProtocol?
 
      
   	//==================================================
   	//   
  
    
   
    
    var shouldRasterize: Bool = false {
        didSet {
            for view in [self.displayView, self.borderView, self.underView] {
                view?.layer.shouldRasterize = shouldRasterize
                view?.layer.rasterizationScale = UIScreen.main.scale
            }
        }
    }
    
    
    
  
  
  
    
    //==================================================
   	// 
   	
   	func refreshViews() {
        self.refreshShapes()
        self.redrawText()
        self.redrawShape()
        self.updateColors()
        
        self.background.fillPath?.fill()
        if let eps = self.background.edgePaths {
            for pth in eps {
                pth.fill()
            }
        }
        self.background.underPath?.fill()
        
        
    }
    
   
    
    
    //==================================================
   	// Colors
   	
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
   	
   	
   	func updateColors() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let switchColors = self.isHighlighted || self.isSelected
        
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
  	var text: String {
        didSet {
            self.label.text = text
            self.label.frame = CGRect(x: self.labelInset, y: self.labelInset, width: self.bounds.width - self.labelInset * 2, height: self.bounds.height - self.labelInset * 2)
            self.redrawText()
        }
    }
      
    func redrawText() {
//        self.keyView.frame = self.bounds
//        self.button.frame = self.bounds
//        
//       self.button.setTitle(self.text, forState: UIControlState.Normal)
        self.label.text = self.text
    }
    
   	//==================================================
   	// Shape
     
        
 	func refreshShapes() {
        // TODO: dunno why this is necessary
        self.background.setNeedsLayout()
        
        self.background.layoutIfNeeded()
        self.popup?.layoutIfNeeded()
        self.connector?.layoutIfNeeded()
        
        let testPath = UIBezierPath()
        let edgePath = UIBezierPath()
        
        let unitSquare = CGRect(x:0, y: 0, width: 1, height: 1)
        
        // TODO: withUnder
        let addCurves = { (fromShape: KeyboardKeyBackground?, toPath: UIBezierPath, toEdgePaths: UIBezierPath) -> Void in
            if let shape = fromShape {
                let path = shape.fillPath
                let translatedUnitSquare = self.displayView.convert(unitSquare, from: shape)
                let transformFromShapeToView = CGAffineTransform(translationX: translatedUnitSquare.origin.x, y: translatedUnitSquare.origin.y)
                path?.apply(transformFromShapeToView)
                if path != nil { toPath.append(path!) }
                if let edgePaths = shape.edgePaths {
                    for (_, anEdgePath) in edgePaths.enumerated() {
                        let editablePath = anEdgePath
                        editablePath.apply(transformFromShapeToView)
                        toEdgePaths.append(editablePath)
                    }
                }
            }
        }
        
        addCurves(self.popup, testPath, edgePath)
        addCurves(self.connector, testPath, edgePath)
        
        let shadowPath = UIBezierPath(cgPath: testPath.cgPath)
        
        addCurves(self.background, testPath, edgePath)
        
        let underPath = self.background.underPath
        let translatedUnitSquare = self.displayView.convert(unitSquare, from: self.background)
        let transformFromShapeToView = CGAffineTransform(translationX: translatedUnitSquare.origin.x, y: translatedUnitSquare.origin.y)
        underPath?.apply(transformFromShapeToView)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let _ = self.popup {
            self.shadowLayer.shadowPath = shadowPath.cgPath
        }
        
        self.underView?.curve = underPath
        self.displayView.curve = testPath
        self.borderView?.curve = edgePath
        
        if let borderLayer = self.borderView?.layer as? CAShapeLayer {
            borderLayer.strokeColor = UIColor.green.cgColor
        }
        
        CATransaction.commit()
    } //end of function
    
    func redrawShape() {
        if let shape = self.shape {
            self.text = ""
            shape.removeFromSuperview()
            self.addSubview(shape)
            
            let pointOffset: CGFloat = 4
            let size = CGSize(width: self.bounds.width - pointOffset - pointOffset, height: self.bounds.height - pointOffset - pointOffset)
            shape.frame = CGRect(
                x: CGFloat((self.bounds.width - size.width) / 2.0),
                y: CGFloat((self.bounds.height - size.height) / 2.0),
                width: size.width,
                height: size.height)
            
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
            self.shadowView.isHidden = false
            self.borderView?.isHidden = false
            
            self.popupDirection = Direction.Up
            
            self.layoutPopup(self.popupDirection!)
            self.configurePopup(self.popupDirection!)
            
            self.delegate?.willShowPopup(self, direction: self.popupDirection!)
        }
        else {
            self.shadowView.isHidden = true
            self.borderView?.isHidden = true
        }
    }
    
     
    func layoutPopup(_ direction: Direction) {
        assert(self.popup != nil, "popup not found")
        
        if let popup = self.popup {
            if let delegate = self.delegate {
                let frame = delegate.frameForPopup(self, direction: direction)
                popup.frame = frame
                popupLabel?.frame = popup.bounds
            }
            else {
                popup.frame = CGRect.zero
                popup.center = self.center
            }
        }
    }
    
    func configurePopup(_ direction: Direction) {
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
            
            let popup = KeyboardKeyBackground(frame: self.frame, cornerRadius: 9.0, underOffset: self.underOffset)
            self.popup = popup
            self.addSubview(popup)
            
            let popupLabel = UILabel()
            popupLabel.textAlignment = self.label.textAlignment
            popupLabel.baselineAdjustment = self.label.baselineAdjustment
            popupLabel.font = self.label.font.withSize(22 * 2)
            popupLabel.adjustsFontSizeToFitWidth = self.label.adjustsFontSizeToFitWidth
            popupLabel.minimumScaleFactor = CGFloat(0.1)
            popupLabel.isUserInteractionEnabled = false
            popupLabel.numberOfLines = 1
            popupLabel.frame = popup.bounds
            popupLabel.text = self.label.text
            popup.addSubview(popupLabel)
            self.popupLabel = popupLabel
            
            self.label.isHidden = true
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
            
            self.label.isHidden = false
            self.background.attach(nil)
            
            self.layer.zPosition = 0
            
            self.popupDirection = nil
        }
    }
    //==================================================
    
    
} //end of class 
