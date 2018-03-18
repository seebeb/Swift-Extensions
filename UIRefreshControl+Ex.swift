//
//  UIRefreshControl+Ex.swift
//
//  Created by Augus on 10/29/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UIRefreshControl {

    func beginRefreshingManually() {
        guard let scrollView = superview as? UIScrollView else { return }

        let offsetY = scrollView.contentOffset.y - frame.height

        scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)

        beginRefreshing()
    }
}
