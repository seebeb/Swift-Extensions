//
//  App.swift
//
//  Created by Augus on 9/8/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


struct APP {
    
    static func reviewPathWithId(_ appId: String) -> String {
        return "https://itunes.apple.com/app/viewContentsUserReviews?id=" + appId
    }
    
    static func reviewURLWithId(_ appId: String) -> URL {
        return URL(string: reviewPathWithId(appId))!
    }
    
    static func sharePathWithId(_ appId: String) -> String {
        return "https://itunes.apple.com/app/id" + appId
    }
    
    static func shareURLWithId(_ appId: String) -> URL {
        return URL(string: sharePathWithId(appId))!
    }
}

extension APP {
    
    static var version: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    static var build: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }    
}
