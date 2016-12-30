//
//  UIApplication+Ex.swift
//
//  Created by Augus on 3/1/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


extension UIApplication {
    
    func initializeInTheFirstTime(_ completion: (() -> Void)) {
        initializeInTheFirstTime(nil, completion: completion)
    }
    
    func initializeInTheFirstTime(_ key: String?, completion: (() -> Void)) {
        
        let _key = (key == nil) ? "ausHasLaunchedHostAppOnce" : key!
        
        if !UserDefaults.standard.bool(forKey: _key) {
            UserDefaults.standard.set(true, forKey: _key)
            
            completion()
        }
    }
}

extension UIApplication {
    
    @objc fileprivate func simulateMemoryWarning() {
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
    }
    
    func simulatingMemoryWarningInDebugging() {
        
        #if DEBUG
        
        guard let vc = UIApplication.shared.topMostViewController else { return }
        
        let button = UIButton()
        button.setTitle("Simulate Memory Warning", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.addTarget(self, action: #selector(simulateMemoryWarning), for: .touchUpInside)
        
        vc.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-8)
        }
        
        #endif
    }
}
