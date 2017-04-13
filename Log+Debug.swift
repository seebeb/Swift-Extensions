//
//  Log+Debug.swift
//
//  Created by Augus on 2/21/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


struct log {

    #if DEBUG

    static func debug(_ message: String?, filename: NSString = #file, function: String = #function, line: Int = #line) {
        print("[\(filename.lastPathComponent):\(line)] \(function) - \(String(describing: message))")
    }

    static func debug(_ message: Any?, filename: NSString = #file, function: String = #function, line: Int = #line) {
        print("[\(filename.lastPathComponent):\(line)] \(function) - \(String(describing: message))")
    }

    #else

    static func debug(_ message: String?, filename: NSString = #file, function: String = #function, line: Int = #line) {}
    static func debug(_ message: Any?, filename: NSString = #file, function: String = #function, line: Int = #line) {}
    
    #endif
}

