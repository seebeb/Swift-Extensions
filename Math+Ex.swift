//
//  Math+Ex.swift
//  PushUps
//
//  Created by Augus on 8/7/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


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
