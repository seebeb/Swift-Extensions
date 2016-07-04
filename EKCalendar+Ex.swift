//
//  EKCalendar+Ex.swift
//  RemindersPlus
//
//  Created by Augus on 7/3/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import EventKit

extension EKCalendar: NSCoding {
    
//    public override func awakeAfter(using aDecoder: NSCoder) -> AnyObject? {
//        
//    }
    
    public override func awakeAfter(using aDecoder: NSCoder) -> AnyObject? {
        aDecoder.encode(calendarIdentifier, forKey: "calendarIdentifier")
        aDecoder.encode(source, forKey: "source")
        aDecoder.encode(allowsContentModifications, forKey: "allowsContentModifications")
        aDecoder.encode(title, forKey: "title")
        aDecoder.encode(isSubscribed, forKey: "isSubscribed")
        aDecoder.encode(isImmutable, forKey: "isImmutable")
        aDecoder.encode(cgColor, forKey: "cgColor")
        
        return super.awakeAfter(using: aDecoder)
        
    }
    
    func encodeWithCoder() {
        
    }
    
    
    public func encode(with aCoder: NSCoder) {
        
    }
    
//    public required init?(coder aDecoder: NSCoder) {
//        
//    }
//    
}
