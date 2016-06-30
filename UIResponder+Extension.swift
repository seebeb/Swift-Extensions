//
//  UIResponder+Extension.swift
//
//  Created by Augus on 12/13/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit


extension UIResponder {
    
    private static var _currentFirstResponder: UIResponder?
    
    class var currentFirstResponder: UIResponder? {
        UIResponder._currentFirstResponder = nil
        UIApplication.shared().sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return UIResponder._currentFirstResponder
    }
    
    @objc func findFirstResponder(_ sender: AnyObject) {
        UIResponder._currentFirstResponder = self
    }
    
}
