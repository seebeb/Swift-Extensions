//
//  ReplaceRootViewController.swift
//
//  Created by Augus on 4/30/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


// REFERENCE: http://stackoverflow.com/a/34679549/4656574

extension UIWindow {
    
    func replaceRootViewControllerWith(replacementController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let snapshotImageView = UIImageView(image: self.snapshot)
        self.addSubview(snapshotImageView)
        self.rootViewController!.dismiss(animated: false, completion: { () -> Void in // dismiss all modal view controllers
            self.rootViewController = replacementController
            self.bringSubview(toFront: snapshotImageView)
            if animated {
                UIView.animate(withDuration: 0.4, animations: { () -> Void in
                    snapshotImageView.alpha = 0
                    }, completion: { (success) -> Void in
                        snapshotImageView.removeFromSuperview()
                        completion?()
                })
            }
            else {
                snapshotImageView.removeFromSuperview()
                completion?()
            }
        })
    }
}


private extension UIView {
    
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
