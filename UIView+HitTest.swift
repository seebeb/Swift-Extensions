//
//  UIView+HitTest.swift
//
//  Created by Augus on 6/27/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


// REFERENCE: http://stackoverflow.com/a/34774177/4656574

// Handle issue when you need to receive touch on top most visible view.

extension UIView {
    
    
    ///
    /// - parameter point:       point
    /// - parameter event:       evet
    /// - parameter invisibleOn: If you want hidden view can not be hit, set `invisibleOn` to true
    ///
    /// - returns: UIView
    func overlapHitTest(_ point: CGPoint, with event: UIEvent?, invisibleOn: Bool = false) -> UIView? {
        // 1
        let invisible = (isHidden || alpha == 0) && invisibleOn
        
        if !isUserInteractionEnabled || invisible {
            return nil
        }
        //2
        var hitView: UIView? = self
        if !self.point(inside: point, with: event) {
            if clipsToBounds {
                return nil
            } else {
                hitView = nil
            }
        }
        //3
        for subview in subviews.reversed() {
            let insideSubview = convert(point, to: subview)
            if let sview = subview.overlapHitTest(insideSubview, with: event) {
                return sview
            }
        }
        return hitView
    }
}

/**
 1. We should not send touch events for hidden or transparent views, or views with userInteractionEnabled set to NO;
 2. If touch is inside self, self will be considered as potential result.
 3. Check recursively all subviews for hit. If any, return it.
 4. Else return self or nil depending on result from step 2.
 
 Note: 'subviews.reversed()' needed to follow view hierarchy from top most to bottom. And check for clipsToBounds to ensure not to test masked subviews.
 
 Usage:
 
 Import category in your subclassed view.
 Replace hitTest:withEvent: with this

 override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
    let uiview = super.hitTest(point, withEvent: event)
    print(uiview)
    return overlapHitTest(point, withEvent: event)
 }
 */
