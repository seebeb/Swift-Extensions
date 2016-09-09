//
//  AlertController.swift
//
//  Created by Augus on 2/3/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


// MARK: - 

private var xoAssociationKey: UInt8 = 0

extension UIAlertController {
    
    func addActions(_ actions: [UIAlertAction]) {
        actions.forEach({
            self.addAction($0)
        })
    }
    
    func addActions(_ actions: UIAlertAction...) {
        addActions(actions)
    }
    
    fileprivate var alertWindow: UIWindow? {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? UIWindow
        }
        set {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func show(animated a: Bool = true, hideStatusBar: Bool = false, statusBarStyle: UIStatusBarStyle? = nil, completion: Closure? = nil) {
        
        alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow?.backgroundColor = .clear
        alertWindow?.windowLevel = UIWindowLevelAlert
        
        let vc = BlankViewController()
        
        if let _w = UIApplication.shared.delegate?.window, let w = _w {
            alertWindow?.tintColor = w.tintColor
            
            vc.isStatusBarHidden = hideStatusBar
            
            if let style = w.rootViewController?.preferredStatusBarStyle {
                vc.statusBarStyle = style
            }
        }
        
        statusBarStyle != nil ? vc.statusBarStyle = statusBarStyle : ()
        
        alertWindow?.rootViewController = vc
        alertWindow?.makeKeyAndVisible()
        alertWindow?.rootViewController?.present(self, animated: a, completion: completion)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        alertWindow?.removeFromSuperview()
        alertWindow = nil
    }
}

private class BlankViewController: UIViewController {
    
    var statusBarStyle: UIStatusBarStyle! = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    var isStatusBarHidden: Bool = false
    
    fileprivate var tempIsStatusBarHidden: Bool?
    
    fileprivate override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        
        // hide status bar in landscape on iPhone if needed
        
        tempIsStatusBarHidden == nil ? tempIsStatusBarHidden = isStatusBarHidden : ()
        
        guard !UIDevice.current.isPad && !tempIsStatusBarHidden! else { return }
        
        isStatusBarHidden = toInterfaceOrientation.isLandscape        
    }
    
    fileprivate override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    fileprivate override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}


// MARK: -

private let ok = NSLocalizedString("OK", comment: "")
private let cancel = NSLocalizedString("Cancel", comment: "")

class AlertController {
    
    typealias CompletionHandler = (Bool) -> ()
    
    class func alert(_ title: String = "", message: String = "", actionTitle: String = ok, baseViewController: UIViewController? = nil, tintColor: UIColor? = nil, closure: CompletionHandler?) {
        alert(title, message: message, actionTitle: actionTitle, addCancelAction: false, baseViewController: baseViewController, tintColor: tintColor, closure: closure)
    }
    
    class func configured(_ title: String = "", message: String = "", actionTitle: String = ok, tintColor: UIColor? = nil, closure: CompletionHandler?) -> UIAlertController {
        return configured(title, message: message, actionTitle: actionTitle, addCancelAction: false, tintColor: tintColor, closure: closure)
    }
    
    class func alertWithCancelAction(_ title: String = "", message: String = "", actionTitle: String = ok, baseViewController: UIViewController? = nil, tintColor: UIColor? = nil, closure: CompletionHandler?) {
        alert(title, message: message, actionTitle: actionTitle, addCancelAction: true, baseViewController: baseViewController, tintColor: tintColor, closure: closure)
    }
    
    class func configuredWithCancelAction(_ title: String = "", message: String = "", actionTitle: String = ok, tintColor: UIColor? = nil, closure: CompletionHandler?) -> UIAlertController {
        return configured(title, message: message, actionTitle: actionTitle, addCancelAction: true, tintColor: tintColor, closure: closure)
    }
    
    class func multiAlertsWithOptions(multiItemsOfInfo: [String], baseViewController: UIViewController? = nil, tintColor: UIColor? = nil, closure: CompletionHandler?) {
        alertWithOptions(multiItemsOfInfo, baseViewController: baseViewController, tintColor: tintColor, closure: closure)
    }
    
    fileprivate class func alert(_ title: String = "", message: String = "", actionTitle: String = ok, addCancelAction: Bool, baseViewController: UIViewController? = nil, tintColor: UIColor? = nil, closure: CompletionHandler?) {
        
        guard let baseVC = baseViewController ?? UIApplication.shared.topMostViewController else { return }
        
        let alertController = configured(title, message: message, actionTitle: actionTitle, addCancelAction: addCancelAction, tintColor: tintColor, closure: closure)
        
        baseVC.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate class func configured(_ title: String = "", message: String = "", actionTitle: String = ok, addCancelAction: Bool, tintColor: UIColor? = nil, closure: CompletionHandler?) -> UIAlertController {
        
        let okAction = UIAlertAction(title: actionTitle, style: .default) { (_) -> Void in
            closure?(true)
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if addCancelAction {
            let cancelAction = UIAlertAction(title: cancel, style: .cancel) { (_) -> Void in
                closure?(false)
            }
            
            alertController.addAction(cancelAction)
        }
        
        alertController.addAction(okAction)
        
        tintColor != nil ? alertController.view.tintColor = tintColor : ()
        
        return alertController
    }
    
    fileprivate class func alertWithOptions(_ multiItemsOfInfo: [String], baseViewController: UIViewController? = nil, tintColor: UIColor? = nil, closure: CompletionHandler?) {
        
        guard let baseVC = baseViewController ?? UIApplication.shared.topMostViewController else { return }
        
        GlobalMainQueue.async {
            
            var tempInfoArray = multiItemsOfInfo
            
            let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: { (_) -> Void in
                tempInfoArray.removeAll()
                closure?(false)
            })
            
            let okAction = UIAlertAction(title: ok, style: .default, handler: { (_) -> Void in
                
                tempInfoArray.removeFirst()
                
                if tempInfoArray.count == 0 {
                    closure?(true)
                    return
                }
                
                self.alertWithOptions(tempInfoArray, closure: closure)
            })
            
            guard tempInfoArray.count > 0 else { return }
            
            let alertController = UIAlertController(title: nil, message: tempInfoArray.first, preferredStyle: .alert)
            
            tintColor != nil ? alertController.view.tintColor = tintColor : ()

            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            baseVC.present(alertController, animated: true, completion: nil)
        }
    }
    
}


