//
//  String+Extension.swift
//
//  Created by Augus on 6/21/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


public extension String {
    
    var isBlank : Bool {
        let s = self
        let cset = CharacterSet.newlines.inverted
        let r = s.rangeOfCharacter(from: cset)
        let ok = s.isEmpty || r == nil
        return ok
    }
}

public extension String {
    
    public init<Subject>(_ instance: Subject) {
        self.init(describing: instance)
    }
    
//    public init<Subject>(_ subject: Subject) {
//        self.init(reflecting: instance)
//    }
    
}


// MARK: - 

extension String {
    
    /// Remove last character
    ///
    /// - returns: the character which has been removed.
    @discardableResult
    mutating func removeLast() -> Character? {
        
        guard endIndex != startIndex else { return nil }
        
        let index = self.index(before: endIndex)
        
        return remove(at: index)
    }
    
    /// Remove first character
    ///
    /// - returns: the character which has been removed.
    @discardableResult
    mutating func removeFirst() -> Character? {
        
        guard endIndex != startIndex else { return nil }
        
        return remove(at: startIndex)
    }
}


// MARK: - 

extension String {
    static let ok = NSLocalizedString("OK", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
}
