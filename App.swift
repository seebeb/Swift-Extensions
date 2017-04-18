//
//  App.swift
//
//  Created by Augus on 9/8/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


struct APP {
    
    static func viewReviewPagePath(with id: String) -> String {
        return "https://itunes.apple.com/app/viewContentsUserReviews?id=" + id
    }
    
    static func reviewURL(with id: String) -> URL {
        return URL(string: reviewPath(with: id))!
    }

    static func reviewPath(with id: String) -> String {
        return appPathOnAppStore(with: id) + "?action=write-review"
    }

    static func appPathOnAppStore(with id: String) -> String {
        return "https://itunes.apple.com/app/id" + id
    }

    static func appUrlOnAppStore(with id: String) -> URL {
        return URL(string: appPathOnAppStore(with: id))!
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
