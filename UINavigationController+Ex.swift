//
//  UINavigationController+Ex.swift
//
//  Created by Augus on 1/30/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit
import SnapKit

extension UINavigationController {

    open override var preferredStatusBarStyle: UIStatusBarStyle {

        // fix that set status bar style does not work on iPad
        guard UIDevice.current.isPad else { return super.preferredStatusBarStyle }

        if let rootViewController = self.viewControllers.first {
            return rootViewController.preferredStatusBarStyle
        }

        return super.preferredStatusBarStyle
    }
}

extension UINavigationController {
    
    func completelyTransparentBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage     = UIImage()
        navigationBar.isTranslucent   = true
        view.backgroundColor          = UIColor.clear
        navigationBar.backgroundColor = UIColor.clear
    }

    func transparentBlurBar() {
        
        completelyTransparentBar()
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        
        // Do NOT insert to `navigationBar`, or the bar items will be covered.
        // navigationBar.insertSubview(visualEffectView, belowSubview: navigationBar)
        view.insertSubview(visualEffectView, belowSubview: navigationBar)
        
        visualEffectView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.bottom.right.equalTo(navigationBar)
        }
    }
    
    func blurBarWithColor(_ color: UIColor, alpha: CGFloat = 1) {
        
        completelyTransparentBar()
        
        let visualEffectView                      = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.backgroundColor          = color
        visualEffectView.alpha                    = alpha
        visualEffectView.isUserInteractionEnabled = false
        navigationBar.insertSubview(visualEffectView, aboveSubview: navigationBar)

        visualEffectView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBar).offset(-22)
            make.left.bottom.right.equalToSuperview()
        }
    }
}
