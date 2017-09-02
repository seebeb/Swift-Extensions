//
//  AppDelegate+RequestReview.swift
//  iTranslator
//
//  Created by Augus on 22/08/2017.
//  Copyright © 2017 iAugus. All rights reserved.
//

import StoreKit

extension AppDelegate {

    func requestReview(shortestTime: UInt32 = 50, longestTime: UInt32 = 500) {

        guard #available(iOS 10.3, *) else { return }

        #if DEBUG

        #else
            let shortestTime: UInt32 = shortestTime
            let longestTime: UInt32 = longestTime
            guard let timeInterval = TimeInterval(exactly: arc4random_uniform(longestTime - shortestTime) + shortestTime) else { return }

            Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(_requestReview), userInfo: nil, repeats: false)
        #endif
    }

    @objc private func _requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Fallback on earlier versions
        }
    }
}
