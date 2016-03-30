//
//  NSArray+Extension.swift
//
//  Created by Augus on 3/22/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation



extension Array {
    func find(includedElement: Element -> Bool) -> Int? {
        for (idx, element) in enumerate() {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
}