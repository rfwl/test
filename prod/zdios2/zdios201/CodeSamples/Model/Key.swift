
class Key: Hashable {

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
    
    var type: KeyType
    var uppercaseKeyCap: String?
    var lowercaseKeyCap: String?
    var uppercaseOutput: String?
    var lowercaseOutput: String?
    var toMode: Int? //if the key is a mode button, this indicates which page it links to
    
    var isCharacter: Bool {
        get {
            switch self.type {
            case
            .Character,
            .SpecialCharacter,
            .Period:
                return true
            default:
                return false
            }
        }
    }
    
    var isSpecial: Bool {
        get {
            switch self.type {
            case .Shift:
                return true
            case .Backspace:
                return true
            case .ModeChange:
                return true
            case .KeyboardChange:
                return true
            case .Return:
                return true
            case .Settings:
                return true
            default:
                return false
            }
        }
    }
    
    var hasOutput: Bool {
        get {
            return (self.uppercaseOutput != nil) || (self.lowercaseOutput != nil)
        }
    }
    
    // TODO: this is kind of a hack
    var hashValue: Int
    
    init(_ type: KeyType) {
        self.type = type
        self.hashValue = counter
        counter += 1
    }
    
    convenience init(_ key: Key) {
        self.init(key.type)
        
        self.uppercaseKeyCap = key.uppercaseKeyCap
        self.lowercaseKeyCap = key.lowercaseKeyCap
        self.uppercaseOutput = key.uppercaseOutput
        self.lowercaseOutput = key.lowercaseOutput
        self.toMode = key.toMode
    }
    
    func setLetter(letter: String) {
        self.lowercaseOutput = (letter as NSString).lowercaseString
        self.uppercaseOutput = (letter as NSString).uppercaseString
        self.lowercaseKeyCap = self.lowercaseOutput
        self.uppercaseKeyCap = self.uppercaseOutput
    }
    
    func outputForCase(uppercase: Bool) -> String {
        if uppercase {
            if self.uppercaseOutput != nil {
                return self.uppercaseOutput!
            }
            else if self.lowercaseOutput != nil {
                return self.lowercaseOutput!
            }
            else {
                return ""
            }
        }
        else {
            if self.lowercaseOutput != nil {
                return self.lowercaseOutput!
            }
            else if self.uppercaseOutput != nil {
                return self.uppercaseOutput!
            }
            else {
                return ""
            }
        }
    }
    
    func keyCapForCase(uppercase: Bool) -> String {
        if uppercase {
            if self.uppercaseKeyCap != nil {
                return self.uppercaseKeyCap!
            }
            else if self.lowercaseKeyCap != nil {
                return self.lowercaseKeyCap!
            }
            else {
                return ""
            }
        }
        else {
            if self.lowercaseKeyCap != nil {
                return self.lowercaseKeyCap!
            }
            else if self.uppercaseKeyCap != nil {
                return self.uppercaseKeyCap!
            }
            else {
                return ""
            }
        }
    }
} //end of class

