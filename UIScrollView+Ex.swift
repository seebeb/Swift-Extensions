//
//  UIScrollView+Ex.swift
//
//  Created by Augus on 8/23/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit
import SnapKit

protocol UIScrollViewScrollToTopDelegate {
    func scrollViewWillScrollToTop(_ scrollView: UIScrollView)
}

protocol UIScrollViewScrollToBottomDelegate {
    func scrollViewWillScrollToBottom(_ scrollView: UIScrollView)
    func scrollViewDidScrollToBottom(_ scrollView: UIScrollView)
}

extension UIScrollView {

    private struct AssociationKey {
        static var topDelegate = 0
        static var bottomDelegate = 0
        static var triggerToTop = 0
    }

    var scrollToTopDelegate: UIScrollViewScrollToTopDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociationKey.topDelegate) as? UIScrollViewScrollToTopDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociationKey.topDelegate, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    var scrollToBottomDelegate: UIScrollViewScrollToBottomDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociationKey.bottomDelegate) as? UIScrollViewScrollToBottomDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociationKey.bottomDelegate, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    enum Priority {
        case top
        case bottom
    }

    var isOnTop: Bool {
        if #available(iOS 11.0, *) {
            return contentOffset.y == -safeAreaInsets.top
        } else {
            return contentOffset.y == -contentInset.top
        }
    }

    var isAtBottom: Bool {
        return contentOffset.y == contentSize.height - bounds.size.height
    }

    /// default is false
    var rightBottomTriggerBoundToScrollViewDidScrollToTop: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociationKey.triggerToTop) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociationKey.triggerToTop, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @discardableResult
    func scrollToTop(appending view: UIView? = nil, animated: Bool = true) -> CGPoint {

        scrollToTopDelegate?.scrollViewWillScrollToTop(self)

        let topOffset: CGFloat
        let appendingHeight = view != nil ? view!.frame.height : 0

        if #available(iOS 11.0, *) {
            topOffset = -safeAreaInsets.top - appendingHeight
        } else {
            topOffset = -contentInset.top - appendingHeight
        }

        let point = CGPoint(x: 0, y: topOffset)
        setContentOffset(point, animated: animated)

        bindToScrollViewDidScrollToTopIfNeeded()
        return point
    }
    
    @discardableResult
    func scrollToBottom(animated: Bool = true) -> CGPoint {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
        scrollViewScrollingToBottom()
        return bottomOffset
    }
    
    @discardableResult
    func scrollToTopOrBottomAutomatically(animated: Bool = true, priority: Priority = .top, fuzzyOffset: CGFloat = 0) -> CGPoint {
        
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        
        guard bottomOffset.y > 0 else { return .zero }
        
        let topOffset: CGPoint
        if #available(iOS 11.0, *) {
            topOffset = CGPoint(x: 0, y: -safeAreaInsets.top)
        } else {
            topOffset = CGPoint(x: 0, y: -contentInset.top)
        }

        let offset: CGPoint

        switch priority {
        case .top:
            let shouldBeTop = abs(contentOffset.y - topOffset.y) > abs(fuzzyOffset)
            offset = shouldBeTop ? topOffset : bottomOffset
        case .bottom:
            let shouldBeTop = abs(contentOffset.y - bottomOffset.y) <= abs(fuzzyOffset)
            offset = shouldBeTop ? topOffset : bottomOffset
        }

        setContentOffset(offset, animated: animated)

        if offset == topOffset {
            bindToScrollViewDidScrollToTopIfNeeded()
        } else {
            scrollViewScrollingToBottom()
        }
        
        return offset
    }
    
    @objc fileprivate func didTriggerOff() {
        scrollToTopOrBottomAutomatically()
    }

    @discardableResult
    func configureRightBottomCornerScrollTrigger(superView: UIView? = nil, color: UIColor? = nil, radius: CGFloat = 4) -> UIView? {
        
        let view: UIView
        
        if superView != nil {
            view = superView!
        } else {
            guard let sv = self.superview else { return nil }
            view = sv
        }
        
        let v = UIView()
        view.addSubview(v)
        v.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.right.bottom.equalTo(0)
        }

        var color = color

        if color == nil {
            color = ((color ?? view.tintColor) ?? AppDelegate().window?.tintColor) ?? .black
            color = color?.withAlphaComponent(0.8)
        }

        let center           = CGPoint(x: 44, y: 44)
        let circlePath       = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        let shapeLayer       = CAShapeLayer()
        shapeLayer.path      = circlePath.cgPath
        shapeLayer.fillColor = color!.cgColor
        v.layer.addSublayer(shapeLayer)

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTriggerOff))
        v.addGestureRecognizer(recognizer)
        v.isUserInteractionEnabled = true

        return v
    }

    @discardableResult
    func configureLeftBottomCornerScrollTrigger(superView: UIView? = nil, color: UIColor? = nil, radius: CGFloat = 4) -> UIView? {
        let action = #selector(didTriggerOff)
        return configureLeftBottomCornerTrigger(target: self, action: action, superView: superView, color: color, radius: radius)
    }

    @discardableResult
    func configureLeftBottomCornerTrigger(target: Any?, action: Selector, superView: UIView? = nil, color: UIColor? = nil, radius: CGFloat = 4) -> UIButton? {

        let view: UIView

        if superView != nil {
            view = superView!
        } else {
            guard let sv = self.superview else { return nil }
            view = sv
        }

        let b                      = UIButton()
        b.backgroundColor          = .clear
        b.isUserInteractionEnabled = true
        b.addTarget(target, action: action, for: .touchUpInside)
        view.addSubview(b)
        b.snp.makeConstraints() {
            $0.width.height.equalTo(44)
            $0.left.bottom.equalTo(0)
        }

        var color = color

        if color == nil {
            color = ((color ?? view.tintColor) ?? AppDelegate().window?.tintColor) ?? .black
            color = color?.withAlphaComponent(0.8)
        }

        let center           = CGPoint(x: 0, y: 44)
        let circlePath       = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        let shapeLayer       = CAShapeLayer()
        shapeLayer.path      = circlePath.cgPath
        shapeLayer.fillColor = color!.cgColor
        b.layer.addSublayer(shapeLayer)

        return b
    }

    private func bindToScrollViewDidScrollToTopIfNeeded() {

        guard rightBottomTriggerBoundToScrollViewDidScrollToTop else { return }

        // call scrollViewShouldScrollToTop as well, may be needed somewhere
        _ = delegate?.scrollViewShouldScrollToTop?(self)

        executeAfterDelay(0.3, closure: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.scrollViewDidScrollToTop?(strongSelf)
        })
    }

    private func scrollViewScrollingToBottom() {

        scrollToBottomDelegate?.scrollViewWillScrollToBottom(self)

        executeAfterDelay(0.3) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.scrollToBottomDelegate?.scrollViewDidScrollToBottom(strongSelf)
        }
    }
}
