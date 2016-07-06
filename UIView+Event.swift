//
//  UIView+Event.swift
//  RemindersPlus
//
//  Created by Augus on 6/28/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


// not cmpleted yet, do not use this

private var initialView: UIView?
private var startTouchPosition1: CGPoint?
private var startTouchPosition2: CGPoint?
private var previousTouchPosition1: CGPoint?
private var previousTouchPosition2: CGPoint?
private var currentTouchPosition1: CGPoint?
private var currentTouchPosition2: CGPoint?

private var startTouchTime: TimeInterval!

private let ZOOM_DRAG_MIN: CGFloat = 10
private let SWIPE_DRAG_HORIZ_MIN: CGFloat = 10

extension UIView {
    
    func detectTouchEvent(event: UIEvent?) {
        
        guard let event = event else { return }
        
        guard let allTouches = event.allTouches() else { return }
        
        guard let touch = allTouches.first else { return }
        
        let touchView = touch.view
        
        if touch.phase == .began {
            initialView = touchView
            startTouchPosition1 = touch.location(in: self)
            startTouchTime = touch.timestamp
            if allTouches.count > 1 {
                startTouchPosition2 = allTouches.first?.location(in: self)
                previousTouchPosition1 = startTouchPosition1
                previousTouchPosition2 = startTouchPosition2
            }
        }
        
        guard let previousTouchPosition1 = previousTouchPosition1, previousTouchPosition2 = previousTouchPosition2 else { return }
        
        if touch.phase == .moved {
            if allTouches.count > 1 {
                guard let currentTouchPosition1 = allTouches.object(0)?.location(in: self), currentTouchPosition2 = allTouches.object(1)?.location(in: self) else { return }
                
                let currentFingerDistance = CGDistance(currentTouchPosition1, currentTouchPosition2)
                let previousFingerDistance = CGDistance(previousTouchPosition1, previousTouchPosition2)
                
                if fabs(currentFingerDistance - previousFingerDistance) > ZOOM_DRAG_MIN {
                    let movedDistance: Int = Int(currentFingerDistance - previousFingerDistance)
                    if currentFingerDistance > previousFingerDistance {
                        print("zoom in")
                        NotificationCenter.default.post(name: NSNotification.Name.NOTIFICATION_ZOOM_IN, object: movedDistance)
                    }
                    else {
                        print("zoom out")
                        NotificationCenter.default.post(name: NSNotification.Name.NOTIFICATION_ZOOM_OUT, object: movedDistance)
                    }
                }
            }
        }
        
        guard let _startTouchPosition1 = startTouchPosition1, let _ = startTouchPosition2 else { return }
        guard let startTouchTime = startTouchTime else { return }
        
        if touch.phase == .ended {
            
            let currentTouchPosition = touch.location(in: self)
            
            // Check if it's a swipe
            if fabsf(Float(_startTouchPosition1.x - currentTouchPosition.x)) >= Float(SWIPE_DRAG_HORIZ_MIN) &&
                fabsf(Float(_startTouchPosition1.x - currentTouchPosition.x)) > fabsf(Float(_startTouchPosition1.y - currentTouchPosition.y)) &&
                touch.timestamp - startTouchTime < 0.7 {
                // It appears to be a swipe.
                if _startTouchPosition1.x < currentTouchPosition.x {
                    NSLog("swipe right")
                    NotificationCenter.default.post(name: NSNotification.Name.NOTIFICATION_SWIPE_RIGHT, object: self)
                }
                else {
                    NSLog("swipe left")
                    NotificationCenter.default.post(name: NSNotification.Name.NOTIFICATION_SWIPE_LEFT
                        , object: self)
                }
            }
            else {
                //-- else, check if it's a single touch
                if touch.tapCount == 1 {
                    let uInfo: [NSObject : AnyObject] = [
                        "touch" : touch
                    ]
                    
                    NotificationCenter.default.post(name: NSNotification.Name.NOTIFICATION_TAP, object: self, userInfo: uInfo)
                }
                /* else if (touch.tapCount > 1) {
                 handle multi-touch
                 }
                 */
            }
            startTouchPosition1 = CGPoint(x: -1, y: -1)
            initialView = nil
        }
        if touch.phase == .cancelled {
            initialView = nil
        }
    }
    
}

extension NSNotification.Name {
    static let NOTIFICATION_TAP = "NOTIFICATION_TAP" as NSNotification.Name
    static let NOTIFICATION_ZOOM_IN = "NOTIFICATION_ZOOM_IN" as NSNotification.Name
    static let NOTIFICATION_ZOOM_OUT = "NOTIFICATION_ZOOM_OUT" as NSNotification.Name
    static let NOTIFICATION_SWIPE_LEFT = "NOTIFICATION_SWIPE_LEFT" as NSNotification.Name
    static let NOTIFICATION_SWIPE_RIGHT = "NOTIFICATION_SWIPE_RIGHT" as NSNotification.Name
}
