//
//  Sequence+Ex.swift
//
//  Created by Augus on 18/6/2018.
//  Copyright © 2018 iAugus. All rights reserved.
//

import Foundation

// REFERENCE: https://stackoverflow.com/questions/31220002/how-to-group-by-the-elements-of-an-array-in-swift

public extension Sequence {
    
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}
