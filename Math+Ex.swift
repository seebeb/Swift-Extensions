//
//  Math+Ex.swift
//
//  Created by Augus on 8/7/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


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

public func == (lhs: String?, rhs: (String, String)) -> Bool {
    if lhs == rhs.0 || lhs == rhs.1 {
        return true
    }
    return false
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


// MARK: - Calculations

// MARK: - Total

func total<T : Arithmetic>(_ values: [T]) -> T {
    var t = T(0)
    values.forEach() { t += $0 }
    return t
}  

func total<T : Arithmetic>(_ values: T ...) -> T {
    return total(values)
}

// MARK: - Average

func average<T : Arithmetic>(_ values: [T]) -> T {
    return total(values) / T(values.count)
}

func average<T : Arithmetic>(_ values: T ...) -> T {
    return total(values) / T(values.count)
}
