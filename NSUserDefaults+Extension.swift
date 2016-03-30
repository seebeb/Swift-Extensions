//
//  NSUserDefaults+Extension.swift
//
//  Created by Augus on 2/15/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


extension NSUserDefaults {
    
    func getBool(key: String, defaultKeyValue: Bool) -> Bool {
        if NSUserDefaults.standardUserDefaults().valueForKey(key) == nil {
            NSUserDefaults.standardUserDefaults().setBool(defaultKeyValue, forKey: key)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        return NSUserDefaults.standardUserDefaults().boolForKey(key)
    }
    
    func getBool(userDefaults: NSUserDefaults, key: String, defaultKeyValue: Bool) -> Bool {
        if userDefaults.valueForKey(key) == nil {
            userDefaults.setBool(defaultKeyValue, forKey: key)
            userDefaults.synchronize()
        }
        return userDefaults.boolForKey(key)
    }
}

extension NSUserDefaults {
    
    func getInteger(key: String, defaultKeyValue: Int) -> Int {
        if NSUserDefaults.standardUserDefaults().valueForKey(key) == nil {
            NSUserDefaults.standardUserDefaults().setInteger(defaultKeyValue, forKey: key)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        return NSUserDefaults.standardUserDefaults().integerForKey(key)
    }
    
    func getInteger(userDefaults: NSUserDefaults, key: String, defaultKeyValue: Int) -> Int {
        if userDefaults.valueForKey(key) == nil {
            userDefaults.setInteger(defaultKeyValue, forKey: key)
            userDefaults.synchronize()
        }
        return userDefaults.integerForKey(key)
    }
}

extension NSUserDefaults {
    
    func getDouble(key: String, defaultKeyValue: Double) -> Double {
        if NSUserDefaults.standardUserDefaults().valueForKey(key) == nil {
            NSUserDefaults.standardUserDefaults().setValue(defaultKeyValue, forKey: key)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        return NSUserDefaults.standardUserDefaults().doubleForKey(key)
    }
    
    func getDouble(userDefaults: NSUserDefaults, key: String, defaultKeyValue: Double) -> Double {
        if userDefaults.valueForKey(key) == nil {
            userDefaults.setDouble(defaultKeyValue, forKey: key)
            userDefaults.synchronize()
        }
        return userDefaults.doubleForKey(key)
    }
}