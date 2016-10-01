//
//  UITabBar+Ex.swift
//  Test
//
//  Created by Augus on 10/1/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UITabBar {

    public func itemFrameAtIndex(_ index: Int) -> CGRect {

        var frames = subviews.flatMap { view -> CGRect? in
            if let view = view as? UIControl {
                return view.frame
            }
            return nil
        }

        frames.sort { $0.origin.x < $1.origin.x }

        if frames.count > index {
            return frames[index]
        }

        return frames.last ?? .zero
    }

    public func indexOfItemAtPoint(_ point: CGPoint) -> Int? {

        var frames = subviews.flatMap { view -> CGRect? in
            if let view = view as? UIControl {
                return view.frame
            }
            return nil
        }

        frames.sort { $0.origin.x < $1.origin.x }

        for (i, rect) in frames.enumerated() {
            if rect.contains(point) {
                return i
            }
        }

        return nil
    }
}
