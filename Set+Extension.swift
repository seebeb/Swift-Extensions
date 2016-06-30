//
//  Set+Extension.swift
//
//  Created by Augus on 6/28/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


extension Set {
    
    func object(_ index: Int) -> Element? {
        
        guard index > 0 else { return nil }
        
        switch index {
        case 0: return first
        case 1: return self[self.index(after: startIndex)]
        default:
            return self[self.index(startIndex, offsetBy: index - 1)]
        }
    }
}
