//
//  SeemsPrivateAPI.swift
//
//  Created by Augus on 6/28/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UIView {
    
    func isEqualToNameOfClass(_ name: String) -> Bool {
        return String(describing: classForCoder) == name
    }
    
    func loopView(_ closure: ((_ subView: UIView) -> ())) {
        for v in subviews {
            closure(v)
            v.loopView(closure)
        }
    }
    
    func loopView(_ nameOfView: String, shouldReturn: Bool = true, execute: ((_ subView: UIView) -> ())) {
        for v in subviews {
            if isEqualToNameOfClass(nameOfView) {
                execute(v)
                if shouldReturn {
                    return
                }
            }
            v.loopView(nameOfView, shouldReturn: shouldReturn, execute: execute)
        }
    }
}


func changeKeyboardColorWith(_ color: UIColor) {
    
    guard UIWindow.keyboardWindow.0, let kbWindow = UIWindow.keyboardWindow.1 else { return }
    
    kbWindow.loopView("UIKBBackdropView") { (subView) in
        subView.backgroundColor = color
    }
}

func opaqueKeyboardKeyView() {

    guard UIWindow.keyboardWindow.0, let kbWindow = UIWindow.keyboardWindow.1 else { return }
    
    kbWindow.loopView("UIKBKeyView", shouldReturn: false) { (subView) in
        subView.isOpaque = true
    }
}
