//
//  Array+Ex.swift
//
//  Created by Augus on 3/22/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


public extension Array {
    
    public func find(_ includedElement: (Element) -> Bool) -> Int? {
        for (idx, element) in enumerated() {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
    
    /// Find the element at the specific index
    /// No need to use this to find the first element, just use `aArray.first`
    ///
    /// - parameter atIndex: index
    ///
    /// - returns: result
    public func object(_ atIndex: Int) -> Element? {
        
        guard atIndex >= 0 else { return nil }
        
        guard atIndex < count else { return nil }
        
        return self[atIndex]
    }
    
}

public extension Array {
    
    public mutating func append(_ newElements: [Element]) {
        self = self + newElements
//        newElements.forEach() { append($0) }
    }
}

public extension Sequence where Iterator.Element: Hashable {

    public var unique: [Iterator.Element] {
        return Array(Set(self))
    }
}

public extension Array where Element: Equatable {

    public var originalOrderUnique: Array  {
        return reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
    }
}
