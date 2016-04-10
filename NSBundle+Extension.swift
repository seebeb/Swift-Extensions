//
//  NSBundle+Extension.swift
//
//  Created by Augus on 4/9/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


extension NSBundle {
    
    var version: String? {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String
    }
    
    var build: String? {
        return NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as? String
    }
    
}