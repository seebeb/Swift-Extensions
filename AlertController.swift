//
//  AlertController.swift
//
//  Created by Augus on 2/3/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


private let ok = NSLocalizedString("OK", comment: "")
private let cancel = NSLocalizedString("Cancel", comment: "")

class AlertController {
    
    typealias CompletionHandler = (Bool) -> ()
    
    class func alert(_ title: String = "", message: String = "", actionTitle: String = ok, baseViewController: UIViewController? = nil, tintColor: UIColor? = nil, closure: CompletionHandler?) {
        AlertController.alert(title, message: message, actionTitle: actionTitle, addCancelAction: false, baseViewController: baseViewController, tintColor: tintColor, closure: closure)
    }
    
    class func alertWithCancelAction(_ title: String = "", message: String = "", actionTitle: String = ok, baseViewController: UIViewController? = nil, tintColor: UIColor? = nil, closure: CompletionHandler?) {
        AlertController.alert(title, message: message, actionTitle: actionTitle, addCancelAction: true, baseViewController: baseViewController, tintColor: tintColor, closure: closure)
    }
    
    class func multiAlertsWithOptions(multiItemsOfInfo: [String], baseViewController: UIViewController? = nil, tintColor: UIColor? = nil, closure: CompletionHandler?) {
        alertWithOptions(multiItemsOfInfo, baseViewController: baseViewController, tintColor: tintColor, closure: closure)
    }
    
    private class func alert(_ title: String = "", message: String = "", actionTitle: String = ok, addCancelAction: Bool, baseViewController: UIViewController? = nil, tintColor: UIColor? = nil, closure: CompletionHandler?) {
        
        guard let baseVC = baseViewController ?? UIApplication.topMostViewController else { return }
        
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
        
        baseVC.present(alertController, animated: true, completion: nil)
    }
    
    private class func alertWithOptions(_ multiItemsOfInfo: [String], baseViewController: UIViewController? = nil, tintColor: UIColor? = nil, closure: CompletionHandler?) {
        
        guard let baseVC = baseViewController ?? UIApplication.topMostViewController else { return }
        
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


