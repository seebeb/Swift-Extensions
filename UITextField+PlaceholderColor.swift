//
//  UITextField+PlaceholderColor.swift
//
//  Created by Augus on 26/04/2017.
//  Copyright © 2017 iAugus. All rights reserved.
//

import UIKit

extension UITextField {

    @IBInspectable var placeholderTextColor: UIColor? {
        set {
            guard let color = newValue else { return }

            let placeholderText = self.placeholder ?? ""
            attributedPlaceholder = NSAttributedString(string:placeholderText, attributes:[NSForegroundColorAttributeName: color])
        }
        get{
            return self.placeholderTextColor
        }
    }
}
