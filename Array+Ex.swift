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
}

extension Array {
    
    mutating func append(_ newElements: [Element]) {
        newElements.forEach() { append($0) }
    }
}
