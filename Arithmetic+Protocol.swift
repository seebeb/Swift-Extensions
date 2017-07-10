//
//  Arithmetic+Protocol.swift
//
//  Created by Augus on 7/16/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


// MARK: - Math

typealias Mathematical = Arithmetic

protocol Arithmetic: Comparable {
    
    var int: Int { get }
    var double: Double { get }
    var cgFloat: CGFloat { get }
    
    
    init(_ x: Int)
    init(_ x: Double)
    init(_ x: Float)
    init(_ x: CGFloat)

    
    static prefix func -(x: Self) -> Self
    
    
    static func +(lhs: Self, rhs: Self) -> Self
    
    static func *(lhs: Self, rhs: Self) -> Self
    
    static func -(lhs: Self, rhs: Self) -> Self
    
    static func /(lhs: Self, rhs: Self) -> Self
    
    static func %(lhs: Self, rhs: Self) -> Self
    
    
    static func +=(lhs: inout Self, rhs: Self)
    
    static func -=(lhs: inout Self, rhs: Self)
    
    static func *=(lhs: inout Self, rhs: Self)
    
    static func /=(lhs: inout Self, rhs: Self)
    
}


// MARK: - 

extension Int: Arithmetic {
    @available(iOS, deprecated, message: "unnecessary")
    var int: Int { return self } // `Int()` is unnecessary here, but just for convenience
    var double: Double { return Double(self) }
    var cgFloat: CGFloat { return CGFloat(self) }
}

extension Int8: Arithmetic {
    var int: Int { return Int(self) }
    var double: Double { return Double(self) }
    var cgFloat: CGFloat { return CGFloat(self) }
}

extension Int16: Arithmetic {
    var int: Int { return Int(self) }
    var double: Double { return Double(self) }
    var cgFloat: CGFloat { return CGFloat(self) }
}

extension Int32: Arithmetic {
    var int: Int { return Int(self) }
    var double: Double { return Double(self) }
    var cgFloat: CGFloat { return CGFloat(self) }
}

extension Int64: Arithmetic {
    var int: Int { return Int(self) }
    var double: Double { return Double(self) }
    var cgFloat: CGFloat { return CGFloat(self) }
}

extension Float: Arithmetic {
    var int: Int { return Int(self) }
    var double: Double { return Double(self) }
    var cgFloat: CGFloat { return CGFloat(self) }
}

extension Double: Arithmetic {
    var int: Int { return Int(self) }
    @available(iOS, deprecated, message: "unnecessary")
    var double: Double { return self } // `Double()` is unnecessary here, but just for convenience
    var cgFloat: CGFloat { return CGFloat(self) }
}

extension CGFloat: Arithmetic {
    var int: Int { return Int(self) }
    var double: Double { return Double(self) }
    @available(iOS, deprecated, message: "unnecessary")
    var cgFloat: CGFloat { return self } // `CGFloat()` is unnecessary here, but just for convenience
}

//extension UInt: Arithmetic {
//    var int: Int { return Int(self) }
//    var double: Double { return Double(self) }
//    var cgFloat: CGFloat { return CGFloat(self) }
//}
//
//extension UInt8 : Arithmetic {
//    var int: Int { return Int(self) }
//    var double: Double { return Double(self) }
//    var cgFloat: CGFloat { return CGFloat(self) }
//}
//
//extension UInt16 : Arithmetic {
//    var int: Int { return Int(self) }
//    var double: Double { return Double(self) }
//    var cgFloat: CGFloat { return CGFloat(self) }
//}
//
//extension UInt32 : Arithmetic {
//    var int: Int { return Int(self) }
//    var double: Double { return Double(self) }
//    var cgFloat: CGFloat { return CGFloat(self) }
//}
//
//extension UInt64 : Arithmetic {
//    var int: Int { return Int(self) }
//    var double: Double { return Double(self) }
//    var cgFloat: CGFloat { return CGFloat(self) }
//}


// MARK: -

func plus<T : Arithmetic>(_ a: T, _ b: T) -> T {
    return a + b
}

func minus<T : Arithmetic>(_ a: T, _ b: T) -> T {
    return a - b
}

func multiply<T : Arithmetic>(_ a: T, _ b: T) -> T {
    return a * b
}

func divide<T : Arithmetic>(_ a: T, _ b: T) -> T {
    return a / b
}

func boundValue<T : Arithmetic>(_ x: T, between a: T, and b: T) -> T {
    if a > b {
        return max(b, min(x, a))
    } else {
        return max(a, min(x, b))
    }
}
