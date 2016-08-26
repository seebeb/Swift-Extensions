//
//  Date+Ex.swift
//  PushUps
//
//  Created by Augus on 8/26/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation

struct Day {
    var began: Date
    var ended: Date
    
    init(began: Date, ended: Date) {
        self.began = began
        self.ended = ended
    }
}

extension Date {
    
    var wholeWeek: [Date] {
        
        var dates: [Date] = []
        
        var cal = Calendar.current
        cal.timeZone = NSTimeZone.local
        
        var comp = DateComponents()
        
        for i in -6 ..< 1 {
            comp.weekday = i
            if let d = cal.date(byAdding: comp, to: self) {
                dates.append(d)
            }
        }
        return dates
    }
    
    var wholeMonthStartOfDates: [Date] {
        return getWholeMonthDatesBaseOn(self, began: true)
    }
    
    var wholeMonthEndOfDates: [Date] {
        return getWholeMonthDatesBaseOn(self, began: false)
    }
    
    var wholeMonthDates: [Day] {
        let days = wholeMonthEndOfDates.map() { (end) -> Day in
            let began = Calendar.current.startOfDay(for: end)
            return Day(began: began, ended: end)
        }
        return days
    }
}

fileprivate func getWholeMonthDatesBaseOn(_ date: Date, began: Bool) -> [Date] {
    
    var dates = [Date]()
    
    let calendar = Calendar.current
    
    var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    
    // get the next month first, then set the day to 0, this will be the last day of the month.
    components.month! += 1
    components.day = 0
    
    components.hour = 23
    components.minute = 59
    components.second = 59
    
    // the end of the last day
    let ended = calendar.date(from: components)!
    
    let endedDateComp = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: ended)
    let endedDay = endedDateComp.day!
    
    components.month! -= 1
    
    if began {
        components.hour = 0
        components.minute = 0
        components.second = 0
    }
    
    (1 ... endedDay).forEach() {
        components.day = $0
        let date = calendar.date(from: components)!
        dates.append(date)
    }
    
    return dates
}
