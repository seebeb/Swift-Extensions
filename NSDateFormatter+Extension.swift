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
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = seconds / 3600 > 0 ? "HH:mm:ss" : "mm:ss"
        timeFormatter.timeZone = NSTimeZone(name: "GTM")
        
        return timeFormatter.stringFromDate(NSDate(timeIntervalSince1970: Double(seconds)))
    }

    class func dateFromString(time: String) -> NSDate? {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = NSTimeZone(name: "GTM")
        
        return timeFormatter.dateFromString(time)
    }
}


extension NSDate {
    
    func stringFromDate() -> String {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = NSTimeZone(name: "GTM")
        
        return timeFormatter.stringFromDate(self)
    }
    
}