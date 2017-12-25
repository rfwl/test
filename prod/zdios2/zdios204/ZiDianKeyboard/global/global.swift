//
//  global.swift
//  ZiDianKeyboard
//
//  Created by Wanlou Feng on 23/12/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation

func jsonEscapeCharacter(_ char:Character) -> String {
    if char == "\"" { return "SC_DOUBLEQUOTE"}
    else if char == "\\" { return "SC_BACKSLASH"}
    else { return String(char) }
}

func jsonUnescapeCharacter(_ str:String) -> String{
    if str == "SC_DOUBLEQUOTE" { return "\""}
    else if str == "SC_BACKSLASH" { return "\\"}
    else { return String(str) }
}
