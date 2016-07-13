//
//  UIButton+Extension.swift
//
//  Created by Augus on 2/6/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UIButton {
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        let minimalWidthAndHeight: CGFloat = 60
        
        let buttonSize = frame.size
        let widthToAdd = (minimalWidthAndHeight - buttonSize.width > 0) ? minimalWidthAndHeight - buttonSize.width : 0
        let heightToAdd = (minimalWidthAndHeight - buttonSize.height > 0) ? minimalWidthAndHeight - buttonSize.height : 0
        let largerFrame = CGRect(x: 0-(widthToAdd / 2), y: 0-(heightToAdd / 2), width: buttonSize.width + widthToAdd, height: buttonSize.height + heightToAdd)
        return largerFrame.contains(point) ? self : nil
    }
    
}

extension UIButton {
    
    // Do NOT change these default values, many of my projects are using this function.
    func hideAndDisableButton(_ hidden: Bool = true, duration: TimeInterval = 0.3, delay: TimeInterval = 0, animated: Bool = false, closure: Closure? = nil) {
        
        isEnabled = !hidden
        
        if !animated {
            executeAfterDelay(delay, closure: {
                self.isHidden = hidden
                closure?()
            })
            
        } else {
            UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut], animations: {
                self.alpha = hidden ? 0 : 1
                }, completion: { (finished) in
                    if finished {
                        self.isHidden = hidden
                        self.alpha = 1
                        closure?()                        
                    }
            })
        }
    }
}

extension UIButton {
    
    func simulateHighlight(interval i: TimeInterval = 0.15) {
        isHighlighted = true
        DispatchQueue.main.after(when: .now() + i) { [weak self] in
            self?.isHighlighted = false
        }
    }
}
