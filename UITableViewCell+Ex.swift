//
//  UITableViewCell+Ex.swift
//
//  Created by Augus on 9/26/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UITableViewCell {

    var relatedTableView: UITableView? {

        var view = superview

        while view != nil && !(view is UITableView) {
            view = view?.superview
        }

        return view as? UITableView
    }
}
