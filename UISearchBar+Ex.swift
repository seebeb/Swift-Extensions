//
//  UISearchBar+Ex.swift
//
//  Created by Augus on 10/20/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit

public extension UISearchBar {

    public func selectAll() {

        loopViews("UISearchBarTextField", shouldReturn: false, execute: {

            // do not use `value(forKey: "searchField") as? UITextField`, may rejected by Apple
            guard let tf = $0 as? UITextField else { return }
            print(tf)

            guard tf.responds(to: #selector(selectAll(_:))) else { return }

            print("in")
            // ensure texts can be selected
            tf.selectAll(nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            }
        })
    }
}


