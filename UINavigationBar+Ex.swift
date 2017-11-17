//
//  UINavigationBar+Ex.swift
//
//  Created by Augus on 12/7/15.
//  Copyright © 2015 iAugus. All rights reserved.
//


import UIKit

extension UINavigationBar {

    var lagreTitleHeight: CGFloat {
        let maxSize = subviews
            .filter { $0.frame.origin.y > 0 }
            .max { $0.frame.origin.y < $1.frame.origin.y }
            .map { $0.frame.size }
        return maxSize?.height ?? 0
    }
}

extension UINavigationBar {

    private struct Association {
        static var key = 0
    }
    
    var isBottomHairlineHidden: Bool {
        get {
            return objc_getAssociatedObject(self, &Association.key) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &Association.key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            navigationBarImageView?.isHidden = newValue
        }
    }
    
    fileprivate var navigationBarImageView: UIImageView? {
        return hairlineImageViewInNavigationBar(self)
    }
    
    fileprivate func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        
        if view is UIImageView && view.bounds.height <= 1.0 {
            return view as? UIImageView
        }
        
        let subviews = view.subviews as [UIView]
        for subview: UIView in subviews {
            if let imageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}
