//
//  NSDateFormatter+Ex.swift
//
//  Created by Augus on 3/29/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


extension DateFormatter {

    class func stringFromTime(seconds: Int) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = seconds / 3600 > 0 ? "HH:mm:ss" : "mm:ss"
        timeFormatter.timeZone = TimeZone(abbreviation: "GTM")

        return timeFormatter.string(from: Date(timeIntervalSince1970: Double(seconds)))
    }

    class func dateFromString(time: String) -> Date? {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = TimeZone(abbreviation: "GTM")

        return timeFormatter.date(from: time)
    }
}


extension Date {

    func stringFromDate() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = TimeZone(abbreviation: "GTM")

        return timeFormatter.string(from: self)
    }
}
