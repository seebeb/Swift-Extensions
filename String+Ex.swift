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
    
    var lastRemoved: String {
        
        guard startIndex != endIndex else { return self }
        
        return substring(to: index(before: endIndex))
    }
    
    var firstRemoved: String {
        
        guard startIndex != endIndex else { return self }
        
        return substring(from: index(after: startIndex))
    }
}


// MARK: - 

extension String {
    
    func replacingOccurrences(of: [String], with: String) -> String {
        var str = self
        of.forEach() {
            str = str.replacingOccurrences(of: $0, with: with)
        }
        return str
    }
}


// MARK: - 

extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

// MARK: - 

extension String {
    static let ok = NSLocalizedString("OK", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
}
