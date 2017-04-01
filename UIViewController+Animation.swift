//
//  UIViewController+Animation.swift
//
//  Created by Augus on 10/10/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentViewControllerLikePushAnimation(destinationVC: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window?.layer.add(transition, forKey: nil)
        
        present(destinationVC, animated: false, completion: nil)
    }
    
    func dismissViewControllerLikePopAnimation() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window?.layer.add(transition, forKey: nil)
        
        dismiss(animated: false , completion: nil)
    }
}
