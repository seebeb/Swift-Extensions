//
//  SeemsHacking.swift
//
//  Created by Augus on 4/11/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


// MARK: -

private var latestSystemUpTime = ProcessInfo.processInfo().systemUptime

/// Not executing at the first time anyway
func onlyExecuteOnceIfEventsTooClose(_ equal: Bool = false, interval: TimeInterval = 0.1, closure: (() -> ())) {
    
    let systemUptime = ProcessInfo.processInfo().systemUptime
    
    let calculation: (_: Double, _: Double) -> Bool = equal ? (>=) : (>)
    
    if calculation(systemUptime - latestSystemUpTime, interval) {
        closure()
    }
    
    latestSystemUpTime = systemUptime
}


private var latestSystemUpTimeExceptTheFirstTime: TimeInterval!

/// Executing at the first time anyway
func onlyExecuteOnceIfEventsTooCloseExceptTheFirstTime(_ equal: Bool = false, interval: TimeInterval = 0.1, closure: (() -> ())) {
    
    let systemUptime = ProcessInfo.processInfo().systemUptime
    
    let calculation: (_: Double, _: Double) -> Bool = equal ? (>=) : (>)
    
    if latestSystemUpTimeExceptTheFirstTime == nil || calculation(systemUptime - latestSystemUpTime, interval) {
        closure()
    }
    
    latestSystemUpTimeExceptTheFirstTime = systemUptime
}


private var latestSystemUpTimeExecutionsTooClose: TimeInterval!

func executionsTooClose(_ equal: Bool = false, interval: TimeInterval = 0.1, firstTimeResult: Bool = false) -> Bool {
    
    if latestSystemUpTimeExecutionsTooClose == nil { return firstTimeResult }
    
    let systemUptime = ProcessInfo.processInfo().systemUptime
    
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

