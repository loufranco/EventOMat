//
//  UINavigationController+Extensions.swift
//  EventOMat
//
//  Created by Louis Franco on 2/17/17.
//  Copyright © 2017 Lou Franco. All rights reserved.
//

import Foundation
import UIKit

// This extension makes the navigation controller use its top view controller to determine status bar style.
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? .default
    }
}
