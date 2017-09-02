//
//  Math+Ex.swift
//
//  Created by Augus on 8/7/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit

// MARK: -

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

func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    case (_?, nil):
        return true
    default:
        return false
    }
}

func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(rhs > lhs)
    }
}

func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}


// MARK: - 

func == (lhs: String?, rhs: (String, String)) -> Bool {
    if lhs == rhs.0 || lhs == rhs.1 {
        return true
    }
    return false
}

/// "augus" ~= "Augus" is true
func ~= (lhs: String?, rhs: String?) -> Bool {
    if lhs == rhs {
        return true
    }
    return lhs?.lowercased() == rhs?.lowercased()
}

/// "123" == 123 is true
func == (lhs: String, rhs: Int) -> Bool {
    return Int(lhs) == rhs
}

/// 123 == "123" is true
func == (lhs: Int, rhs: String) -> Bool {
    return lhs == Int(rhs)
}


// MARK: -

extension Bool {

#if swift(>=3.2)
    init<T : BinaryInteger>(_ integer: T) {
        self.init(integer != 0)
    }
#else
    init<T : Integer>(_ integer: T) {
        self.init(integer != 0)
    }
#endif
}


extension Int {
    
    var bool: Bool {
        return self != 0
    }
}


// MARK: - 

extension Float {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    func format(numberOfDecimalPlaces: Int) -> String {
        return String(format: "%.\(numberOfDecimalPlaces)f", self)
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


// MARK: -

func clamp<T: Comparable>(value: T, minimum: T, maximum: T) -> T {
    return min(max(value, minimum), maximum)
}
