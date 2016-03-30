//
//  CoreGraphics+Extension.swift
//
//  Created by Augus on 3/19/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


// MARK: - distance

func CGDistance(l1: CGFloat, _ l2: CGFloat) -> CGFloat {
    guard l1 != 0 && l2 != 0 else { return 0 }
    
    return sqrt(pow(l1, 2) + pow(l2, 2))
}

func CGDistance(p1: CGPoint, _ p2: CGPoint) -> CGFloat {
    guard p1 != p2 else { return 0 }
    
    return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2))
}


// MARK: - point

func CGPointInsideLoop(point: CGPoint, center: CGPoint, firstRadius: CGFloat, secondRadius: CGFloat) -> Bool {
    let area = touchArea(point, center: center)
    let smaller = square(min(firstRadius, secondRadius))
    let bigger = square(max(firstRadius, secondRadius))
    
    if area >= smaller && area <= bigger {
        return true
    }
    
    return false
}

func CGPointInsideCircle(point: CGPoint, center: CGPoint, radius: CGFloat) -> Bool {
    let area = touchArea(point, center: center)
    if area <= square(radius) {
        return true
    }
    return false
}

private func touchArea(point: CGPoint, center: CGPoint) -> Double {
    return square(point.x - center.x) + square(point.y - center.y)
}

private func square(x: CGFloat) -> Double {
    return pow(Double(x), 2)
}
    