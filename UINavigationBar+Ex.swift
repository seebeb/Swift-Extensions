//
//  UINavigationBar+Ex.swift
//
//  Created by Augus on 12/7/15.
//  Copyright © 2015 iAugus. All rights reserved.
//


import UIKit


private var xoAssociationKey: UInt8 = 0

extension UINavigationBar {
    
    var isBottomHairlineHidden: Bool {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? Bool ?? false
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
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
