//
//  Utils.swift
//
//  Created by Augus on 11/10/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit


public typealias Closure = () -> ()
public typealias BoolClosure = (Bool) -> ()
public typealias URLClosure = (URL) -> ()
public typealias OptionalURLClosure = (URL?) -> ()

let IS_64_BIT = MemoryLayout<Int>.size == MemoryLayout<Int64>.size

struct Utils {
    
    static var documentPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
    
    static func documentPathForFile(_ named: String) -> String {
        return (documentPath as NSString).appendingPathComponent(named)
    }
    
    static func appGroupDocumentPath(_ appGroupId: String) -> String? {
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupId)
        let path = url?.absoluteString.replacingOccurrences(of: "file:", with: "", options: .literal, range: nil)
        return path
    }
    
    static func bundlePathForFile(_ named: String) -> String {
        return (Bundle.main.bundlePath as NSString).appendingPathComponent(named)
    }

    static func bundlePathForFile(_ named: String, type: String) -> String? {
        return Bundle.main.path(forResource: named, ofType: type)
    }

    static func bundleURLForFile(_ named: String, type: String) -> URL? {
        guard let path = bundlePathForFile(named, type: type) else { return nil }
        return URL(fileURLWithPath: path)
    }

    @discardableResult
    static func createFolder(_ path: String) -> String {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        return path
    }
    
    @discardableResult
    static func deleteFileWithPath(_ path: String) -> Bool {
        let exists = FileManager.default.fileExists(atPath: path)
        if exists {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                debugPrint("error: \(error.localizedDescription)")
                return false
            }
        }
        return exists
    }
    
    /// Delete file in Documents Path
    ///
    /// - parameter named: name of the file
    ///
    /// - returns: success or failed
    @discardableResult
    static func deleteFileWithName(_ named: String) -> Bool {
        let path = documentPath + named
        return deleteFileWithPath(path)
    }
}

extension Utils {

    static func clearTempDirectory() {
        do {
            try tempContents.forEach() {
                try FileManager.default.removeItem(atPath: $0)
            }
        } catch {}
    }

    static var tempContents: [String] {
        let paths = (try? FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory())) ?? []
        return paths.map() {
            return (NSTemporaryDirectory() as NSString).appendingPathComponent($0)
        }
    }

    static func isDirectoryFor(_ path: String) -> Bool {
        var isDirectory: ObjCBool = false
        FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
}

extension Utils {
    
    static var libraryPath: String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
    }
    
    static func libraryPathForFile(_ named: String) -> String {
        return (libraryPath as NSString).appendingPathComponent(named)
    }
}

extension Utils {

    static func fetchRootDirectoryForiCloud(completion: @escaping (URL?) -> ()) {
        GlobalQuene.async {
            guard let url = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") else {
                GlobalMainQueue.async {
                    completion(nil)
                }
                return
            }

            if !FileManager.default.fileExists(atPath: url.path, isDirectory: nil) {
                print("create directory")
                do {
                    try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print(error)
                }
            }

            GlobalMainQueue.async {
                completion(url)
            }
        }
    }

    static func localPath(forResource: String, of type: String) -> URL {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let resourcePath = ((documentsDirectory as NSString).appendingPathComponent(forResource) as NSString).appendingPathExtension(type)
        return URL(fileURLWithPath: resourcePath!)
    }
}

extension Utils {
    
    static var cachePath: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    }
    
    static func cachePathForFile(_ named: String) -> String {
        return (cachePath as NSString).appendingPathComponent(named)
    }
    
    static var tempPath: String {
        return NSTemporaryDirectory()
    }
}


var GlobalMainQueue: DispatchQueue {
    return DispatchQueue.main
}

var GlobalQuene: DispatchQueue {
    return DispatchQueue.global(qos: .default)
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

func executeAfterDelay(_ seconds: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        closure()
    }
}
