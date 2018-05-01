//
//  String+Extension.swift
//
//  Created by Augus on 6/21/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation

public extension String {
    
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }
}

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
//        self.init(reflecting: subject)
//    }

}


// MARK: - 

extension String {

    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { sInd in
            (range(of: to, range: sInd..<endIndex)?.lowerBound).map { eInd in
                #if swift(>=3.2)
                    return String(self[sInd..<eInd])
                #else
                    return substring(with: sInd..<eInd)
                #endif
            }
        }
    }
}

extension String {

    subscript(i: Int) -> String {
        #if swift(>=3.2)
            guard i >= 0 && i < count else { return "" }
            return String(self[index(startIndex, offsetBy: i)])
        #else
            guard i >= 0 && i < characters.count else { return "" }
            return String(self[index(startIndex, offsetBy: i)])
        #endif
    }

    subscript(range: Range<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        #if swift(>=3.2)
            return String(self[lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) ?? endIndex)])
        #else
            return substring(with: lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) ?? endIndex))
        #endif
    }

    subscript(range: ClosedRange<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        #if swift(>=3.2)
            return String(self[lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) ?? endIndex)])
        #else
            return substring(with: lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) ?? endIndex))
        #endif
    }
}

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

    /// Remove last character
    ///
    /// - returns: characters which are left
    func dropLast() -> String {

        guard startIndex != endIndex else { return self }

        #if swift(>=3.2)
            return String(self[..<index(before: endIndex)])
        #else
            return substring(to: index(before: endIndex))
        #endif
    }

    /// Remove fisrt character
    ///
    /// - returns: characters which are left
    func dropFirst() -> String {

        guard startIndex != endIndex else { return self }

        #if swift(>=3.2)
            return String(self[index(after: startIndex)...])
        #else
            return substring(from: index(after: startIndex))
        #endif
    }

    @available(*, deprecated, message: "Please use `dropLast()`")
    var lastRemoved: String {
        
        guard startIndex != endIndex else { return self }
        
        return substring(to: index(before: endIndex))
    }

    @available(*, deprecated, message: "Please use `dropFirst()`")
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

extension String {

    var encodeURLComponent: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }

    var decodeURLComponent: String {
        return self.components(separatedBy: "+").joined(separator: " ").removingPercentEncoding ?? self
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
    
    var url: URL {
        return URL(string: self) ?? URL(string: "https://")!
    }

    var optionalURL: URL? {
        return URL(string: self)
    }
}


// MARK: - 

extension String {
    static let yes       = NSLocalizedString("YES", comment: "")
    static let no        = NSLocalizedString("NO", comment: "")
    static let ok        = NSLocalizedString("OK", comment: "")
    static let error     = NSLocalizedString("Error", comment: "")
    static let confirm   = NSLocalizedString("Confirm", comment: "")
    static let cancel    = NSLocalizedString("Cancel", comment: "")
    static let delete    = NSLocalizedString("Delete", comment: "")
    static let deleteAll = NSLocalizedString("Delete All", comment: "")
}
