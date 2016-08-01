//
//  Converting.swift
//
//  Created by Augus on 3/20/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


extension Double {
    
    func floatingPointValueToInt(errorValue value: Int) -> Int {
        guard isFinite else { return value }
        return Int(self)
    }
}
