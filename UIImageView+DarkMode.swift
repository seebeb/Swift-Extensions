//
//  UIImageView+DarkMode.swift
//  Lucis
//
//  Created by Augus on 29/11/2017.
//  Copyright © 2017 iAugus. All rights reserved.
//

import UIKit

extension UIImageView {

    @IBInspectable
    var ignoresInvertColors: Bool {
        get {
            if #available(iOS 11.0, *) {
                return accessibilityIgnoresInvertColors
            } else {
                return false
            }
        }
        set {
            if #available(iOS 11.0, *) {
                accessibilityIgnoresInvertColors = newValue
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
