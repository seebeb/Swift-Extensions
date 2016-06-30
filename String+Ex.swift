//
//  String+Extension.swift
//
//  Created by Augus on 6/21/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


extension String {
    
    var isBlank : Bool {
        let s = self
        let cset = CharacterSet.newlines.inverted
        let r = s.rangeOfCharacter(from: cset)
        let ok = s.isEmpty || r == nil
        return ok
    }
}
