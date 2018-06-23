//
//  UIButton+EventClosure.swift
//
//  Created by WangLei on 2018/5/31.
//  Copyright © 2018 Happy Iterating Inc. All rights reserved.
//

import UIKit

// REFERENCE: - https://medium.com/@jackywangdeveloper/swift-the-right-way-to-add-target-in-uibutton-in-using-closures-877557ed9455

extension UIButton {
    
    func addTarget(for event: UIControlEvents = .touchUpInside, closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(closureAction), for: event)
    }
}

typealias UIButtonTargetClosure = (UIButton) -> ()

private class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

private extension UIButton {
    
    struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    var targetClosure: UIButtonTargetClosure? {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper)?.closure
        }
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.targetClosure, ClosureWrapper(newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func closureAction() {
        targetClosure?(self)
    }
}