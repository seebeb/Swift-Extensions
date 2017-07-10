//
//  UITabBarController+Ex.swift
//  Unsplash
//
//  Created by Augus on 08/07/2017.
//  Copyright © 2017 iAugus. All rights reserved.
//

import UIKit

extension UITabBarController {


    /// If the selected view controller is a navigation controller, then return the top view controller.
    var selectedTopViewController: UIViewController? {
        guard let selected = selectedViewController else { return nil }

        if let nav = selected as? UINavigationController {
            return nav.topViewController
        } else {
            return selected
        }
    }
}
