//
//  extensions.swift
//  ZiDianKeyboard
//
//  Created by Wanlou Feng on 23/12/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func clearSubviews() {
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
    }
}
