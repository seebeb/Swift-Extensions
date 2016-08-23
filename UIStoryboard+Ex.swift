//
//  UIStoryboard+Extension.swift
//
//  Created by Augus on 4/30/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UIStoryboard {
    static var Main: UIStoryboard { return UIStoryboard(name: "Main", bundle: nil) }
    static var MainInterface: UIStoryboard { return UIStoryboard(name: "MainInterface", bundle: nil) }
}

extension UIStoryboard {

    /// Instantiates and returns the view controller with the specified identifier.
    /// Note: withIdentifier must equal to the vc Class
    func instantiateViewController(with vc: Swift.AnyClass) -> UIViewController {
        return instantiateViewController(withIdentifier: String(describing: vc.self))
    }

}



// MARK: - 

extension UITableView {
    
    /// Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
    /// Note: withIdentifier must equal to the Cell Class.
    func dequeueReusableCell(with cell: Swift.AnyClass, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: String(describing: cell.self), for: indexPath)
    }
    
    /// Registers a nib object containing a cell with the table view under a specified identifier.
    /// Nib name must equal to the Cell Class, and the forCellReuseIdentifier must equal to Cell Class as well.
    func registerNib(_ cell: Swift.AnyClass) {
        let id = String(describing: cell.self)
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forCellReuseIdentifier: id)
    }

    /// Registers a class for use in creating new table cells.
    /// Note: forCellReuseIdentifier must equal to the Cell Class.
    func register(_ cellClass: Swift.AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }

}
