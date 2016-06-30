//
//  UIWindow+Ex.swift
//  RemindersPlus
//
//  Created by Augus on 6/30/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UIWindow {
    
    // do not use `NSClassFromString("UIRemoteKeyboardWindow")`, this is private API
    
    var isKeyboardWindow: Bool {
        return String(classForCoder) == "UIRemoteKeyboardWindow"
    }
}
