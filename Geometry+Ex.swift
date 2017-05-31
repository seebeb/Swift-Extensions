//
//  Geometry+Ex.swift
//
//  Created by Augus on 5/16/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


@available(iOS, deprecated, message: "please use: init(surrounding:)")
func UIEdgeInsetsMakeEachSide(_ distance: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsetsMake(distance, distance, distance, distance)
}

extension UIEdgeInsets {

    init(surrounding: CGFloat) {
        self.init(top: surrounding, left: surrounding, bottom: surrounding, right: surrounding)
    }
}
