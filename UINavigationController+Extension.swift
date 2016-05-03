//
//  UINavigationController+Extension.swift
//
//  Created by Augus on 1/30/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit
import SnapKit


extension UINavigationController {
    
    func completelyTransparentBar() {
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        navigationBar.translucent = true
        view.backgroundColor = UIColor.clearColor()
        navigationBar.backgroundColor = UIColor.clearColor()
    }
    
    func transparentBlurBar() {
        
        completelyTransparentBar()
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        view.insertSubview(visualEffectView, belowSubview: navigationBar)
        
        visualEffectView.snp_makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.bottom.right.equalTo(navigationBar)
        }
    }
    
}