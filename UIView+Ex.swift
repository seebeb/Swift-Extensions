//
//  UIView+Extension.swift
//
//  Created by Augus on 9/4/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit

extension UIView {
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next()
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIView {
    
    var maxSize: CGSize {
        let maxL = max(frame.width, frame.height)
        return CGSize(width: maxL, height: maxL)
    }
    
    var minSize: CGSize {
        let minL = min(frame.width, frame.height)
        return CGSize(width: minL, height: minL)
    }

    var maxBounds: CGRect {
        return CGRect(origin: .zero, size: maxSize)
    }
    
    var minBounds: CGRect {
        return CGRect(origin: .zero, size: minSize)
    }
}

extension UIView {
    
    func setFrameSize(_ size: CGSize) {
        var frame = self.frame
        frame.size = size
        self.frame = frame
    }
    
    func setFrameHeight(_ height: CGFloat) {
        var frame = self.frame
        frame.size.height = height
        self.frame = frame
    }
    
    func setFrameWidth(_ width: CGFloat) {
        var frame = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
    func setFrameOriginX(_ originX: CGFloat) {
        var frame = self.frame
        frame.origin.x = originX
        self.frame = frame
    }
    
    func setFrameOriginY(_ originY: CGFloat) {
        var frame = self.frame
        frame.origin.y = originY
        self.frame = frame
    }
    
    /**
     set current view's absolute center to other view's center
     
     - parameter view: other view
     */
    func centerTo(_ view: UIView) {
        self.frame.origin.x = view.bounds.midX - self.frame.width / 2
        self.frame.origin.y = view.bounds.midY - self.frame.height / 2
        
    }
}


// MARK: -

extension UIView {
    
    func plusOriginX(_ delta: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.x += delta
        self.frame = frame
        return self
    }
    
    func plusOriginY(_ delta: CGFloat) -> UIView {
        var frame = self.frame
        frame.origin.y += delta
        self.frame = frame
        return self
    }
    
    func plusPoint(_ point: CGPoint) -> UIView {
        frame.origin.x += point.x
        frame.origin.y += point.y
        return self
    }
    
    func plusOriginXY(x: CGFloat, y: CGFloat) -> UIView {
        let point = CGPoint(x: x, y: y)
        _ = plusPoint(point)
        return self
    }
    
    func plusWidth(_ width: CGFloat) -> UIView {
        frame.size.width += width
        return self
    }
    
    func plusHeight(_ height: CGFloat) -> UIView {
        frame.size.height += height
        return self
    }
}

extension UIView {
    
    func simulateHighlight(withMinAlpha alpha: CGFloat = 0.5) {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.alpha = alpha
            }, completion: { (_) -> Void in
                UIView.animate(withDuration: 0.1, delay: 0.1, options: [], animations: { [weak self] in
                    self?.alpha = 1
                    }, completion: nil)
        })
    }
}

extension UIView {
    
    func isPointInside(_ fromView: UIView, point: CGPoint, event: UIEvent?) -> Bool {
        return self.point(inside: fromView.convert(point, to: self), with: event)
    }
}


// MARK: - rotation animation

extension UIView {
    
    /// Angle: 𝞹
    ///
    /// - parameter duration:           <#duration description#>
    /// - parameter beginWithClockwise: <#beginWithClockwise description#>
    /// - parameter clockwise:          <#clockwise description#>
    /// - parameter animated:           <#animated description#>
    
    func rotationAnimation(_ duration: CFTimeInterval? = 0.4, beginWithClockwise: Bool, clockwise: Bool, animated: Bool) {
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        let angle: Double = beginWithClockwise ? (clockwise ? M_PI : 0) : (clockwise ? 0 : -M_PI)
        
        if beginWithClockwise {
            if !clockwise { rotationAnimation.fromValue = M_PI }
        } else {
            if clockwise { rotationAnimation.fromValue = -M_PI }
        }
        
        rotationAnimation.toValue = angle
        rotationAnimation.duration = animated ? duration! : 0
        rotationAnimation.repeatCount = 0
        rotationAnimation.delegate = self
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.isRemovedOnCompletion = false
        
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    /// Angle: 𝞹/2
    ///
    /// - parameter duration:  <#duration description#>
    /// - parameter clockwise: <#clockwise description#>
    /// - parameter animated:  <#animated description#>
    
    func rotationAnimation(_ duration: TimeInterval, clockwise: Bool, animated: Bool) {
        
        let angle = CGFloat(clockwise ? M_PI_2 : -M_PI_2)
        
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                self.transform = self.transform.rotate(angle)
                }, completion: nil)
        } else {
            self.transform = self.transform.rotate(angle)
        }
        
    }
    
}


// MARK: - Twinkle

extension UIView {
    
    func twinkling(_ duration: TimeInterval, minAlpha: CGFloat = 0, maxAlpha: CGFloat = 1) {
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = minAlpha
            
        }) { [weak self] (finished) in
            
            if finished {
                UIView.animate(withDuration: duration, animations: {
                    self?.alpha = maxAlpha
                    }, completion: { [weak self] (finished) in
                        
                        if finished {
                            self?.twinkling(duration, minAlpha: minAlpha, maxAlpha: maxAlpha)
                        }
                })
            }
        }
    }
}

// MARK: - Corner raidus
// REFERENCE: http://stackoverflow.com/a/35621736/4656574

extension UIView {
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        _ = _round(corners, radius: radius)
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners, radius: radius)
        addBorder(mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    private func _round(_ corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    private func addBorder(_ mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear().cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}

// MARK: - 

extension UIView {
    
    func changeAlphaAnimated(_ toAlpha: CGFloat = 0, duration: TimeInterval = 0.3, closure: ((Bool) -> ())? = nil) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.alpha = toAlpha
            }, completion: closure)
    }
}

