//
//  UIView+Gradient.swift
//
//  Created by Augus on 3/18/17.
//  Copyright © 2017 iAugus. All rights reserved.
//

/// REFERENCE: http://stackoverflow.com/a/42020700/4656574

import UIKit

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {

    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical

    fileprivate var startPoint : CGPoint { get { return points.startPoint } }
    fileprivate var endPoint : CGPoint { get { return points.endPoint } }

    fileprivate var points : GradientPoints {
        get {
            switch(self) {
            case .topRightBottomLeft:
                return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
            case .topLeftBottomRight:
                return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1.0, y: 1.0))
            case .horizontal:
                return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
            case .vertical:
                return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
            }
        }
    }
}

extension UIView {

    @discardableResult
    func applyGradient(withColors colors: [UIColor], locations: [NSNumber]? = nil) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }

    @discardableResult
    func applyGradient(withColors colors: [UIColor], points: GradientPoints) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = points.startPoint
        gradient.endPoint = points.endPoint
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }

    @discardableResult
    func applyGradient(withColors colors: [UIColor], gradientOrientation orientation: GradientOrientation) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }

    static func gradientLayer(colors: [UIColor], gradientOrientation orientation: GradientOrientation) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        return gradient
    }

    static func gradientLayer(colors: [UIColor], points: GradientPoints) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = points.startPoint
        gradient.endPoint = points.endPoint
        return gradient
    }
}
