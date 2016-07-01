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
    
    func hideAndDisableButton(_ hidden: Bool = false, duration: TimeInterval = 0.3, animate: Bool) {
        
        isEnabled = !hidden
        
        if !animate {
            isHidden = hidden
        } else {
            UIView.animate(withDuration: duration, animations: {
                self.alpha = !hidden ? 0 : 1
                }, completion: { (_) in
                    self.isHidden = hidden
                    self.alpha = 1
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
