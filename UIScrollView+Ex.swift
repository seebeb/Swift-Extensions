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
    func scrollToTopOrBottomAutomatically(animated: Bool = true) -> CGPoint {
        
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)

        let offset = contentOffset == bottomOffset ? topOffset : bottomOffset
        setContentOffset(offset, animated: animated)
        return offset
    }
    
    @objc fileprivate func didTriggerOff() {
        scrollToTopOrBottomAutomatically()
    }
    
    func configureRightBottomCornerScrollTrigger(superView: UIView? = nil) {
        
        let view: UIView
        
        if superView != nil {
            view = superView!
        } else {
            guard let sv = self.superview else { return }
            view = sv
        }
        
        print(view)
        
        let v = UIView()
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.right.bottom.equalTo(8)
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTriggerOff))
        v.addGestureRecognizer(recognizer)
        v.isUserInteractionEnabled = true
    }
}
