
var counter = 0

let metrics: [String:Double] = [
    "topBanner": 30
]
func metric(name: String) -> CGFloat { return CGFloat(metrics[name]!) }

// TODO: move this somewhere else and localize
let kAutoCapitalization = "kAutoCapitalization"
let kPeriodShortcut = "kPeriodShortcut"
let kKeyboardClicks = "kKeyboardClicks"
let kSmallLowercase = "kSmallLowercase"

// popup constraints have to be setup with the topmost view in mind; hence these callbacks
protocol KeyboardKeyProtocol: class {
    func frameForPopup(key: KeyboardKey, direction: Direction) -> CGRect
    func willShowPopup(key: KeyboardKey, direction: Direction) //may be called multiple times during layout
    func willHidePopup(key: KeyboardKey)
}



protocol Connectable: class {
    func attachmentPoints(direction: Direction) -> (CGPoint, CGPoint)
    func attachmentDirection() -> Direction?
    func attach(direction: Direction?) // call with nil to detach
}


extension CGRect: Hashable {
    public var hashValue: Int {
        get {
            return (origin.x.hashValue ^ origin.y.hashValue ^ size.width.hashValue ^ size.height.hashValue)
        }
    }
}

extension CGSize: Hashable {
    public var hashValue: Int {
        get {
            return (width.hashValue ^ height.hashValue)
        }
    }
}


