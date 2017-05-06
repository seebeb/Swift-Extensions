//
//  UITableView+Ex.swift
//
//  Created by Augus on 1/7/17.
//  Copyright © 2017 iAugus. All rights reserved.
//

import UIKit

extension UITableView {

    func reloadData(with animation: UITableViewRowAnimation) {
        reloadSections(IndexSet(integersIn: 0 ..< numberOfSections), with: animation)
    }

    func reloadVisibleRows(with animation: UITableViewRowAnimation = .none) {
        
        guard let ips = indexPathsForVisibleRows else { return }

        reloadRows(at: ips, with: animation)
    }
}
