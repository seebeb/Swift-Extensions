//
//  SeemsHacking.swift
//
//  Created by Augus on 4/11/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


// MARK: - 

private var latestSystemUpTime = NSProcessInfo.processInfo().systemUptime

func onlyExecuteOnceIfEventsTooClose(execution: (() -> ())) {
    let systemUptime = NSProcessInfo.processInfo().systemUptime
    
    if systemUptime - latestSystemUpTime > 0.1 {
        execution()
    }
    
    latestSystemUpTime = systemUptime
}


// MARK: - 

