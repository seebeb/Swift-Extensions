//
//  UIViewController+Ex.swift
//
//  Created by Augus on 9/30/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit


// MARK: - 

extension UIViewController {

    var isModal: Bool {
        if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
}


// MARK: - Top bar (status bar + navigation bar)

extension UIViewController {
    
    var statusBarFrame: CGRect {
        return view.window?.convert(UIApplication.shared.statusBarFrame, to: view) ?? CGRect.zero
    }
    
    var topBarHeight: CGFloat {
        var navBarHeight: CGFloat {
            guard let bar = navigationController?.navigationBar else { return 0 }
            return view.window?.convert(bar.frame, to: view).height ?? 0
        }
        let statusBarHeight = view.window?.convert(UIApplication.shared.statusBarFrame, to: view).height ?? 0
        return statusBarHeight + navBarHeight
    }
    
    /**
     While trying to present a new controller, current controller' bar may disappear temporary.
     But I still need the real height of top bar.
     - Why not set a constant (64.0 or 32.0)? Apple may change the constant in some device in the future.
    */
    func topBarHeightWhenTemporaryDisappear() -> CGFloat {
        let key = "kASTopBarHeightWhenTemporaryDisappear"
        if UserDefaults.standard.value(forKey: key) == nil {
            UserDefaults.standard.setValue(topBarHeight, forKey: key)
        }
        else if topBarHeight != 0 && topBarHeight != UserDefaults.standard.value(forKey: key) as! CGFloat {
            UserDefaults.standard.setValue(topBarHeight, forKey: key)
        }
        return UserDefaults.standard.value(forKey: key) as! CGFloat
    }
    
}


// MARK: - Keyboard notification

extension UIViewController {
    func keyboardWillChangeFrameNotification(_ notification: Notification, scrollBottomConstant: NSLayoutConstraint) {
        let duration = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let curve = (notification as NSNotification).userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let keyboardBeginFrame = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = ((notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let screenHeight = UIScreen.main.bounds.height
        let isBeginOrEnd = keyboardBeginFrame.origin.y == screenHeight || keyboardEndFrame.origin.y == screenHeight
        let heightOffset = keyboardBeginFrame.origin.y - keyboardEndFrame.origin.y - (isBeginOrEnd ? bottomLayoutGuide.length : 0)
        
        UIView.animate(withDuration: duration.doubleValue,
            delay: 0,
            options: UIViewAnimationOptions(rawValue: UInt(curve.intValue << 16)),
            animations: { () in
                scrollBottomConstant.constant = scrollBottomConstant.constant + heightOffset
                self.view.layoutIfNeeded()
            },
            completion: nil
        )
    }
    
}


// MARK: - Dismiss view controller

extension UIViewController {

    @IBAction func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissWithoutAnimation() {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func popViewControllerAnimated() {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func popViewControllerWithoutAnimation() {
        _ = navigationController?.popViewController(animated: false)
    }
}


// MARK: - 

extension Selector {
    static let dismissAnimated                   = #selector(UIViewController.dismissAnimated)
    static let dismissWithoutAnimation           = #selector(UIViewController.dismissWithoutAnimation)
    static let popViewControllerAnimated         = #selector(UIViewController.popViewControllerAnimated)
    static let popViewControllerWithoutAnimation = #selector(UIViewController.popViewControllerWithoutAnimation)
}


// MAEK: - Edge dismiss gesture

extension UIViewController {
    
    func configureScreenEdgeDismissGesture(_ edges: UIRectEdge = .left, animated: Bool = true, alsoForPad: Bool = false) {
        let action = animated ? #selector(dismissAnimated) : #selector(dismissWithoutAnimation)
        configureScreenEdgeGestures(edges, alsoForPad: alsoForPad, action: action)
    }

    func configureScreenEdgePopGesture(_ edges: UIRectEdge = .left, animated: Bool = true, alsoForPad: Bool = false) {
        let action = animated ? #selector(popViewControllerAnimated) : #selector(popViewControllerWithoutAnimation)
        configureScreenEdgeGestures(edges, alsoForPad: alsoForPad, action: action)
    }

    func configureScreenEdgeGestures(_ edges: UIRectEdge = .left, alsoForPad: Bool = false, action: Selector) {

        if UIDevice.current.userInterfaceIdiom == .pad && !alsoForPad { return }

        view.isUserInteractionEnabled = true

        func left() {
            let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: action)
            gesture.edges = .left
            view.addGestureRecognizer(gesture)
        }

        func right() {
            let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: action)
            gesture.edges = .right
            view.addGestureRecognizer(gesture)
        }

        if edges == .left {
            left()
        } else if edges == .right {
            right()
        } else if edges == [.left, .right] {
            left()
            right()
        }
    }
}
