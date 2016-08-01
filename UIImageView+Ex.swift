//
//  UIImageView+Ex.swift
//
//  Created by Augus on 10/11/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit


extension UIImageView {
    
    var renderingMode: UIImageRenderingMode {
        get {
            return image?.renderingMode ?? .automatic
        }
        set {
            guard image != nil else { return }
            image = image!.withRenderingMode(newValue)
        }
    }
    
    func changeImageColor(_ tintColor: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = tintColor
    }
    
    func changeImageWithAnimation(name: String, duration: TimeInterval = 1.0, animation: Bool = true) {
        
        let img = UIImage(named: name)
        _changeImageWithAnimation(img, duration: duration, animation: animation)
    }
    
    func _changeImageWithAnimation(_ img: UIImage?, duration: TimeInterval = 1.0, animation: Bool = true) {
        
        if animation {
            let transition = CATransition()
            transition.duration = duration
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionFade
            layer.add(transition, forKey: nil)
        }
        
        // change image now
        image = img
    }
    
}
