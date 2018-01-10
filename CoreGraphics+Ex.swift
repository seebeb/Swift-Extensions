//
//  CoreGraphics+Extension.swift
//
//  Created by Augus on 3/19/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


// MARK: -

extension CGRect {

    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2)
        self.init(origin: origin, size: size)
    }

    init(origin: CGPoint = .zero, sideLength: CGFloat) {
        self.init(origin: origin, size: CGSize(width: sideLength, height: sideLength))
    }
    
    var center: CGPoint {
        let x = origin.x + width / 2
        let y = origin.y + height / 2
        return CGPoint(x: x, y: y)
    }

    
    // MARK: -
    
    var Max: CGRect {
        var rect  = self
        let _max  = max(width, height)
        rect.size = CGSize(width: _max, height: _max)
        return rect
    }
    
    var Min: CGRect {
        var rect  = self
        let _min  = min(width, height)
        rect.size = CGSize(width: _min, height: _min)
        return rect
    }


    // MARK: - 

    func changeOriginX(_ x: CGFloat) -> CGRect {
        var frame = self
        frame.origin.x = x
        return frame
    }

    func changeOriginY(_ y: CGFloat) -> CGRect {
        var frame = self
        frame.origin.y = y
        return frame
    }

    func changeMaxX(_ x: CGFloat) -> CGRect {
        return changeOriginX(x - width)
    }

    func changeMaxY(_ y: CGFloat) -> CGRect {
        return changeOriginY(y - height)
    }

    func changeMidX(_ x: CGFloat) -> CGRect {
        return changeOriginX(x - width / 2)
    }

    func changeMidY(_ y: CGFloat) -> CGRect {
        return changeOriginY(y - height / 2)
    }

    
    // MARK: - 
    
    func plusX(_ delta: CGFloat) -> CGRect {
        var frame = self
        frame.origin.x += delta
        return frame
    }
    
    func plusY(_ delta: CGFloat) -> CGRect {
        var frame = self
        frame.origin.y += delta
        return frame
    }
    
    func plusPoint(_ point: CGPoint) -> CGRect {
        var frame = self
        frame.origin.x += point.x
        frame.origin.y += point.y
        return frame
    }
    
    func plusXY(_ x: CGFloat, _ y: CGFloat) -> CGRect {
        let point = CGPoint(x: x, y: y)
        return plusPoint(point)
    }
    
    func plusWidth(_ width: CGFloat) -> CGRect {
        var rect = self
        rect.size.width += width
        return rect
    }
    
    func plusHeight(_ height: CGFloat) -> CGRect {
        var rect = self
        rect.size.height += height
        return rect
    }
}

extension CGPoint {
    
    func plusX(_ x: CGFloat) -> CGPoint {
        var point = self
        point.x += x
        return point
    }
    
    func plusY(_ y: CGFloat) -> CGPoint {
        var point = self
        point.y += y
        return point
    }
    
    func plusPoint(_ point: CGPoint) -> CGPoint {
        var new = self
        new.x += point.x
        new.y += point.y
        return new
    }
    
    func plusXY(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        return plusPoint(CGPoint(x: x, y: y))
    }
}

extension CGSize {

    init(sideLength: CGFloat) {
        self.init(width: sideLength, height: sideLength)
    }

    init(sideLength: Double) {
        self.init(width: sideLength, height: sideLength)
    }

    init(sideLength: Int) {
        self.init(width: sideLength, height: sideLength)
    }
    
    var Max: CGSize {
        let _max = max(width, height)
        return CGSize(width: _max, height: _max)
    }
    
    var Min: CGSize {
        let _max = min(width, height)
        return CGSize(width: _max, height: _max)
    }
    
    var maxSL: CGFloat {
        return max(width, height)
    }
    
    var minSL: CGFloat {
        return min(width, height)
    }

    func scale(_ delta: CGFloat) -> CGSize {
        return CGSize(width: width * delta, height: height * delta)
    }
}


// MARK: - 

extension CGRect {

    var randomPoint: CGPoint {
        let origin = self.origin
        let x = CGFloat(arc4random_uniform(UInt32(self.width))) + origin.x
        let y = CGFloat(arc4random_uniform(UInt32(self.height))) + origin.y
        return CGPoint(x: x, y: y)
    }
}


// MARK: - distance

func CGDistance(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
    guard p1 != p2 else { return 0 }
    
    return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2))
}

func CGTriangleDistance(_ l1: CGFloat, _ l2: CGFloat) -> CGFloat {
    guard l1 != 0 && l2 != 0 else { return 0 }
    
    return sqrt(pow(l1, 2) + pow(l2, 2))
}


// MARK: - point

func CGPointInsideLoop(_ point: CGPoint, center: CGPoint, firstRadius: CGFloat, secondRadius: CGFloat) -> Bool {
    let area    = touchArea(point, center: center)
    let smaller = square(min(firstRadius, secondRadius))
    let bigger  = square(max(firstRadius, secondRadius))

    if area >= smaller && area <= bigger {
        return true
    }
    
    return false
}

func CGPointInsideCircle(_ point: CGPoint, center: CGPoint, radius: CGFloat) -> Bool {
    let area = touchArea(point, center: center)
    if area <= square(radius) {
        return true
    }
    return false
}

private func touchArea(_ point: CGPoint, center: CGPoint) -> Double {
    return square(point.x - center.x) + square(point.y - center.y)
}

private func square(_ x: CGFloat) -> Double {
    return pow(Double(x), 2)
}


// MARK: -

func CGRectsNotContainPoint(_ point: CGPoint, rects: CGRect...) -> Bool {
    return CGRectsNotContainPoint(point, rects: rects)
}

func CGRectsNotContainPoint(_ point: CGPoint, rects: Array<CGRect>) -> Bool {
    for rect in rects {
        if rect.contains(point) {
            return false
        }
    }
    return true
}


// MARK: -
@available(iOS, deprecated, message: "please use: CGSize:sideLength")
func CGSizeWithEqualLength(_ sideLength: CGFloat) -> CGSize {
    return CGSize(width: sideLength, height: sideLength)
}

@available(iOS, deprecated, message: "please use: CGSize:sideLength")
func CGSizeWithEqualLength(_ sideLength: Double) -> CGSize {
    return CGSize(width: sideLength, height: sideLength)
}

@available(iOS, deprecated, message: "please use: CGSize:sideLength")
func CGSizeWithEqualLength(_ sideLength: Int) -> CGSize {
    return CGSize(width: sideLength, height: sideLength)
}


// MARK: - Math Function

func CGLinearFunction(_ point1: CGPoint, _ point2: CGPoint, x: CGFloat) -> CGPoint {
    let k = (point2.y - point1.y) / (point1.x - point1.x)
    let b = (point1.y + point2.y - k * (point1.x + point2.x)) / 2
    let y = k * x + b
    return CGPoint(x: x, y: y)
}

func CGLinearFunction(_ point1: CGPoint, _ point2: CGPoint, y: CGFloat) -> CGPoint {
    let point = CGLinearFunction(point1, point2, x: y)
    return CGPoint(x: point.y, y: point.x)
}

func CGLinearFunctionIsPointOnLine(_ point1: CGPoint, _ point2: CGPoint, _ point3: CGPoint) -> Bool {
    let k = (point2.y - point1.y) / (point1.x - point1.x)
    let b = (point1.y + point2.y - k * (point1.x + point2.x)) / 2
    return point3.y == k * point3.x + b
}




