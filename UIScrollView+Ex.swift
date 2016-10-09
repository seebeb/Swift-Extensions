//
//  UIScrollView+Ex.swift
//  PushUps
//
//  Created by Augus on 8/23/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit
import SnapKit

extension UIScrollView {

    enum Priority {
        case top
        case bottom
    }

    var isOnTop: Bool {
        return contentOffset.y == -contentInset.top
    }

    var isAtBottom: Bool {
        return contentOffset.y == contentSize.height - bounds.size.height
    }
    
    @discardableResult
    func scrollToTop(animated: Bool = true) -> CGPoint {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
        return topOffset
    }
    
    @discardableResult
    func scrollToBottom(animated: Bool = true) -> CGPoint {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
        return bottomOffset
    }
    
    @discardableResult
    func scrollToTopOrBottomAutomatically(animated: Bool = true, priority: Priority = .top, fuzzyOffset: CGFloat = 0) -> CGPoint {
        
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        
        guard bottomOffset.y > 0 else { return .zero }
        
        let topOffset = CGPoint(x: 0, y: -contentInset.top)

        let offset: CGPoint

        switch priority {
        case .top:
            offset = abs(contentOffset.y - topOffset.y) > abs(fuzzyOffset) ? topOffset : bottomOffset
        case .bottom:
            offset = abs(contentOffset.y - bottomOffset.y) <= abs(fuzzyOffset) ? topOffset : bottomOffset
        }

        setContentOffset(offset, animated: animated)
        
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
            color = color ?? view.tintColor ?? AppDelegate().window?.tintColor ?? .black
            color = color?.withAlphaComponent(0.8)
        }

        let center = CGPoint(x: 44, y: 44)
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = color!.cgColor
        v.layer.addSublayer(shapeLayer)

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTriggerOff))
        v.addGestureRecognizer(recognizer)
        v.isUserInteractionEnabled = true

        return v
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

        let b = UIButton()
        b.backgroundColor = .clear
        b.isUserInteractionEnabled = true
        b.addTarget(target, action: action, for: .touchUpInside)
        view.addSubview(b)
        b.snp.makeConstraints() {
            $0.width.height.equalTo(44)
            $0.left.bottom.equalTo(0)
        }

        var color = color

        if color == nil {
            color = color ?? view.tintColor ?? AppDelegate().window?.tintColor ?? .black
            color = color?.withAlphaComponent(0.8)
        }

        let center = CGPoint(x: 0, y: 44)
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = color!.cgColor
        b.layer.addSublayer(shapeLayer)

        return b
    }
}
