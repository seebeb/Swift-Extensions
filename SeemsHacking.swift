//
//  SeemsHacking.swift
//
//  Created by Augus on 4/11/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


// MARK: -

private var latestSystemUpTime = NSProcessInfo.processInfo().systemUptime

/// Not executing at the first time anyway
func onlyExecuteOnceIfEventsTooClose(equal equal: Bool = false, interval: NSTimeInterval = 0.1, closure: (() -> ())) {
    
    let systemUptime = NSProcessInfo.processInfo().systemUptime
    
    let calculation: (_: Double, _: Double) -> Bool = equal ? (>=) : (>)
    
    if calculation(systemUptime - latestSystemUpTime, interval) {
        closure()
    }
    
    latestSystemUpTime = systemUptime
}


private var latestSystemUpTimeExceptTheFirstTime: NSTimeInterval!

/// Executing at the first time anyway
func onlyExecuteOnceIfEventsTooCloseExceptTheFirstTime(equal equal: Bool = false, interval: NSTimeInterval = 0.1, closure: (() -> ())) {
    
    let systemUptime = NSProcessInfo.processInfo().systemUptime
    
    let calculation: (_: Double, _: Double) -> Bool = equal ? (>=) : (>)
    
    if latestSystemUpTimeExceptTheFirstTime == nil || calculation(systemUptime - latestSystemUpTime, interval) {
        closure()
    }
    
    latestSystemUpTimeExceptTheFirstTime = systemUptime
}


private var latestSystemUpTimeExecutionsTooClose: NSTimeInterval!

func executionsTooClose(equal equal: Bool = false, interval: NSTimeInterval = 0.1, firstTimeResult: Bool = false) -> Bool {
    
    if latestSystemUpTimeExecutionsTooClose == nil { return firstTimeResult }
    
    let systemUptime = NSProcessInfo.processInfo().systemUptime
    
    let calculation: (_: Double, _: Double) -> Bool = equal ? (>) : (>=)
    
    if calculation(systemUptime - latestSystemUpTimeExecutionsTooClose, interval) {
        latestSystemUpTimeExecutionsTooClose = systemUptime
        return false
    } else {
        latestSystemUpTimeExecutionsTooClose = systemUptime
        return true
    }
}


// MARK: -

