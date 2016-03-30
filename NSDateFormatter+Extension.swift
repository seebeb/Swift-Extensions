//
//  NSDateFormatter+Extension.swift
//  Tremor
//
//  Created by Augus on 3/29/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation



extension NSDateFormatter {
    
    class func stringFromTime(seconds: Int) -> String {
        let timeFormater = NSDateFormatter()
        timeFormater.dateFormat = seconds / 3600 > 0 ? "HH:mm:ss" : "mm:ss"
        timeFormater.timeZone = NSTimeZone(name: "GTM")
        
        return timeFormater.stringFromDate(NSDate(timeIntervalSince1970: Double(seconds)))
    }
}