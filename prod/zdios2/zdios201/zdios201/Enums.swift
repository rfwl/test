enum VibrancyType {
    case LightSpecial
    case DarkSpecial
    case DarkRegular
}


enum ShiftState {
    case Disabled
    case Enabled
    case Locked
    
    func uppercase() -> Bool {
        switch self {
        case .Disabled:
            return false
        case .Enabled:
            return true
        case .Locked:
            return true
        }
    }
}

 enum KeyType {
        case Character
        case SpecialCharacter
        case Shift
        case Backspace
        case ModeChange
        case KeyboardChange
        case Period
        case Space
        case Return
        case Settings
        case Other
}

enum Direction: Int, CustomStringConvertible {
    case Left = 0
    case Down = 3
    case Right = 2
    case Up = 1
    
    var description: String {
    get {
        switch self {
        case .Left:
            return "Left"
        case .Right:
            return "Right"
        case .Up:
            return "Up"
        case .Down:
            return "Down"
        }
    }
    }
    
    func clockwise() -> Direction {
        switch self {
        case .Left:
            return .Up
        case .Right:
            return .Down
        case .Up:
            return .Right
        case .Down:
            return .Left
        }
    }
    
    func counterclockwise() -> Direction {
        switch self {
        case .Left:
            return .Down
        case .Right:
            return .Up
        case .Up:
            return .Left
        case .Down:
            return .Right
        }
    }
    
    func opposite() -> Direction {
        switch self {
        case .Left:
            return .Right
        case .Right:
            return .Left
        case .Up:
            return .Down
        case .Down:
            return .Up
        }
    }
    
    func horizontal() -> Bool {
        switch self {
        case
        .Left,
        .Right:
            return true
        default:
            return false
        }
    }
}



    
    
    

