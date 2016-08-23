//
//  Set+Extension.swift
//
//  Created by Augus on 6/28/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


extension Set {
    
    /// Find the element at the specific index
    /// No need to use this to find the first element, just use `aSet.first`
    ///
    /// - parameter atIndex: index
    ///
    /// - returns: result
    func object(_ atIndex: Int) -> Element? {
        
        guard atIndex >= 0 else { return nil }
        
        switch atIndex {
        case 0: return first
        case 1: return self[self.index(after: startIndex)]
        default:
            return self[self.index(startIndex, offsetBy: atIndex - 1)]
        }
    }
}
