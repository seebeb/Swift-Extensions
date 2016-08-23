//
//  UIScrollView+Ex.swift
//  PushUps
//
//  Created by Augus on 8/23/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UIScrollView {
    
    func scrollToTop(animated: Bool = true) {
        let point = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(point, animated: animated)
    }
}
