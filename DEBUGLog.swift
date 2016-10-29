//
//  DEBUGLog.swift
//
//  Created by Augus on 2/21/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation

#if DEBUG
    
//    func DEBUGLog(_ message: String?, filename: NSString = #file, function: String = #function, line: Int = #line) {
//        NSLog("[\(filename.lastPathComponent):\(line)] \(function) - \(message)")
//    }
    
    func DEBUGLog(_ message: Any?, filename: NSString = #file, function: String = #function, line: Int = #line) {
        NSLog("[\(filename.lastPathComponent):\(line)] \(function) - \(message)")
    }
    
    func DEBUGPrint(_ any: Any?) {
        print(any ?? "nil")
    }
    
    func DEBUGPrint(_ any: Any?, prefix: String = "", suffix: String = "") {
        print(prefix + "\(any)" + suffix)
    }
    
#else
    
//    func DEBUGLog(_ message: String?, filename: String = #file, function: String = #function, line: Int = #line) {
//    }
    
    func DEBUGLog(_ message: Any?, filename: NSString = #file, function: String = #function, line: Int = #line) {
    }
    
    func DEBUGPrint(_ any: Any?) {
    }
    
    func DEBUGPrint(_ any: Any?, prefix: String = "", suffix: String = "") {
    }
    
#endif
