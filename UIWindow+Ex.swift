//
//  UIWindow+Ex.swift
//
//  Created by Augus on 6/30/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UIWindow {
    
    // do not use `NSClassFromString("UIRemoteKeyboardWindow")`, this is private API
    
    var isKeyboardWindow: Bool {
        return String(describing: classForCoder) == "UIRemoteKeyboardWindow"
    }
    
    class var isTopWindowKeyboard: Bool {
        return UIApplication.shared.windows.last?.isKeyboardWindow ?? false
    }
    
    class var keyboardWindow: (Bool, UIWindow?) {
        return (isTopWindowKeyboard, UIApplication.shared.windows.last)
    }
    
}


// MARK: - 

func changeKeyboardColorWith(_ color: UIColor) {

    guard UIWindow.keyboardWindow.0, let kbWindow = UIWindow.keyboardWindow.1 else { return }

    kbWindow.loopViews("UIKBBackdropView") { (subView) in
        subView.backgroundColor = color
    }
}

func opaqueKeyboardKeyView() {

    guard UIWindow.keyboardWindow.0, let kbWindow = UIWindow.keyboardWindow.1 else { return }

    kbWindow.loopViews("UIKBKeyView", shouldReturn: false) { (subView) in
        subView.isOpaque = true
    }
}
