//
//  UIResponder+Extension.swift
//
//  Created by Augus on 12/13/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit


private var _currentFirstResponder: UIResponder?

extension UIResponder {
    
    var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared().sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }
    
    @objc private func findFirstResponder(_ sender: AnyObject) {
        _currentFirstResponder = self
    }
    
}
