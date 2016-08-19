//
//  Math+Ex.swift
//  PushUps
//
//  Created by Augus on 8/7/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


// MARK: -

// Xcode 8 beta6 +

/**
 1 > nil // true
 1 < nil // false
 nil > 1 // false
 nil < 1 // true
 
 1 >= nil // true
 1 <= nil // false
 nil >= 1 // false
 nil <= 1 // true
 */

public func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    case (_?, nil):
        return true
    default:
        return false
    }
}

public func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(rhs > lhs)
    }
}

public func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

public func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}


// MARK: -

extension Bool {
    
    init<T : Integer>(_ integer: T){
        self.init(integer != 0)
    }
}


extension Int {
    
    var bool: Bool {
        return self != 0
    }
}
