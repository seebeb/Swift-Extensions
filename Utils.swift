//
//  Utils.swift
//
//  Created by Augus on 11/10/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import Foundation


public typealias Closure = () -> ()

public func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}


class Utils {
    
    class var documentPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
    
    class func documentPathForFile(_ name: String) -> String {
        return (documentPath as NSString).appendingPathComponent(name)
    }
    
    class func appGroupDocumentPath(_ appGroupId: String) -> String? {
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupId)
        let path = url?.absoluteString.replacingOccurrences(of: "file:", with: "", options: .literal, range: nil)
        return path
    }
    
    
    class func bundlePathForFile(_ name: String) -> String {
        return (Bundle.main.bundlePath as NSString).appendingPathComponent(name)
    }
    
    @discardableResult
    class func deleteFileWithPath(_ path: String) -> Bool {
        let exists = FileManager.default.fileExists(atPath: path)
        if exists {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                print("error: \(error.localizedDescription)")
                return false
            }
        }
        return exists
    }
    
    /// Delete file in Documents Path
    ///
    /// - parameter name: name of the file
    ///
    /// - returns: success or failed
    @discardableResult
    class func deleteFileWithName(_ name: String) -> Bool {
        let path = documentPath + name
        return deleteFileWithPath(path)
    }
}

var GlobalMainQueue: DispatchQueue {
    return DispatchQueue.main
}

var GlobalUserInteractiveQueue: DispatchQueue {
    return DispatchQueue.global(qos: .userInteractive)
}

var GlobalUserInitiatedQueue: DispatchQueue {
    return DispatchQueue.global(qos: .userInitiated)
}

var GlobalUtilityQueue: DispatchQueue {
    return DispatchQueue.global(qos: .utility)
}

var GlobalBackgroundQueue: DispatchQueue {
    return DispatchQueue.global(qos: .background)
}

// MARK: - Delay

func executeAfterDelay(_ seconds: Double, closure: (() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: {
        closure()
    })
}
