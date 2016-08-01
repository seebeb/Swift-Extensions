//
//  NSDateFormatter+Ex.swift
//
//  Created by Augus on 3/29/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation



extension DateFormatter {
    
    class func stringFromTime(_ seconds: Int) -> String {
        let timeFormater = DateFormatter()
        timeFormater.dateFormat = seconds / 3600 > 0 ? "HH:mm:ss" : "mm:ss"
        timeFormater.timeZone = TimeZone(name: "GTM")
        
        return timeFormater.string(from: NSDate(timeIntervalSince1970: Double(seconds)) as Date)
    }
}
