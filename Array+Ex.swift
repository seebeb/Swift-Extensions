//
//  Array+Ex.swift
//
//  Created by Augus on 3/22/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


extension Array {
    
    func find(_ includedElement: (Element) -> Bool) -> Int? {
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
    func object(_ atIndex: Int) -> Element? {
        
        guard atIndex >= 0 else { return nil }
        
        guard atIndex < count else { return nil }
        
        return self[atIndex]
    }
    
}

extension Array {
    
    mutating func append(_ newElements: [Element]) {
        newElements.forEach() { append($0) }
    }
}
