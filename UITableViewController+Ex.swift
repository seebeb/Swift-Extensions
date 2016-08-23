//
//  UITableViewController+Ex.swift
//  PushUps
//
//  Created by Augus on 8/23/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation
import SnapKit


extension UITableViewController {
    
    func configureScrollToTopView() {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.right.bottom.equalTo(8)
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(scrollToTopViewDidTap))
        v.addGestureRecognizer(recognizer)
        v.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func scrollToTopViewDidTap() {
        let point = CGPoint(x: 0, y: -tableView.contentInset.top)
        tableView.setContentOffset(point, animated: true)
    }
}
