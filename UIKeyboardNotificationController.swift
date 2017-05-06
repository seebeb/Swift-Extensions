//
//  UIKeyboardNotificationController.swift
//
//  Created by Augus on 9/14/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit


enum UIKeyboardState {
    case willShow
    case didShow
    case willHide
    case didHide
    case willChange
    case didChange
    case all
}

enum UIApplicationState {
    case willEnterForeground
    case didBecomeActive
    case willResignActive
    case didEnterBackground
}

class UIKeyboardNotificationController: UIViewController {

    var isSubviewsAnimatedAutomatically = true

    /// nil means keyboard's default duration
    var customAnimatedDuration: TimeInterval?

    func registerNotificationsWithStates(_ keyboardStates: [UIKeyboardState] = [], _ applicationStates: [UIApplicationState] = []) {
        keyboardStates.forEach() {
            switch $0 {
            case .all:        registerAll(); return
            case .willShow:   registerWillShow()
            case .didShow:    registerDidShow()
            case .willHide:   registerWillHide()
            case .didHide:    registerDidHide()
            case .willChange: registerWillChange()
            case .didChange:  registerDidChange()
            }
        }
        applicationStates.forEach() {
            switch $0 {
            case .willEnterForeground: registerApplicationWillEnterForground()
            case .didBecomeActive:     registerApplicationDidBecomeActive()
            case .willResignActive:    registerApplicationWillResignActive()
            case .didEnterBackground:  registerApplicationDidEnterBackground()
            }
        }
    }

    func resignNotificationsWithStates(_ states: [UIKeyboardState] = [], applicationStates: [UIApplicationState] = []) {
        states.forEach() {
            switch $0 {
            case .all:        resignAll(); return
            case .willShow:   resignWillShow()
            case .didShow:    resignDidShow()
            case .willHide:   resignWillHide()
            case .didHide:    resignDidHide()
            case .willChange: resignWillChange()
            case .didChange:  resignDidChange()
            }
        }
        applicationStates.forEach() {
            switch $0 {
            case .willEnterForeground: resignApplicationWillEnterForground()
            case .didBecomeActive:     resignApplicationDidBecomeActive()
            case .willResignActive:    resignApplicationWillResignActive()
            case .didEnterBackground:  resignApplicationDidEnterBackground()
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension UIKeyboardNotificationController {

    func keyboardWillShow(kbRect: CGRect, duration: TimeInterval) {}

    func keyboardDidShow(kbRect: CGRect, duration: TimeInterval) {}

    func keyboardWillHide(kbRect: CGRect, duration: TimeInterval) {}

    func keyboardDidHide(kbRect: CGRect, duration: TimeInterval) {}

    func keyboardWillChangeFrame(kbRect: CGRect, duration: TimeInterval) {}

    func keyboardDidChangeFrame(kbRect: CGRect, duration: TimeInterval) {}
}

extension UIKeyboardNotificationController {

    func applicationWillEnterForeground() {}

    func applicationDidBecomeActive() {}

    func applicationWillResignActive() {}

    func applicationDidEnterBackground() {}
}

fileprivate extension Selector {

    static let keyboardWillShow        = #selector(UIKeyboardNotificationController.keyboardWillShow(_:))
    static let keyboardWillHide        = #selector(UIKeyboardNotificationController.keyboardWillHide(_:))
    static let keyboardDidShow         = #selector(UIKeyboardNotificationController.keyboardDidShow(_:))
    static let keyboardDidHide         = #selector(UIKeyboardNotificationController.keyboardDidHide(_:))
    static let keyboardWillChangeFrame = #selector(UIKeyboardNotificationController.keyboardWillChangeFrame(_:))
    static let keyboardDidChangeFrame  = #selector(UIKeyboardNotificationController.keyboardDidChangeFrame(_:))

    static let applicationWillEnterForeground = #selector(UIKeyboardNotificationController.applicationWillEnterForeground)
    static let applicationDidBecomeActive     = #selector(UIKeyboardNotificationController.applicationDidBecomeActive)
    static let applicationWillResignActive    = #selector(UIKeyboardNotificationController.applicationWillResignActive)
    static let applicationDidEnterBackground  = #selector(UIKeyboardNotificationController.applicationDidEnterBackground)
}

fileprivate extension UIKeyboardNotificationController {

    func registerApplicationWillEnterForground() {
        NotificationCenter.default.addObserver(self, selector: .applicationWillEnterForeground, name: .UIApplicationWillEnterForeground, object: nil)
    }

    func registerApplicationDidBecomeActive() {
        NotificationCenter.default.addObserver(self, selector: .applicationDidBecomeActive, name: .UIApplicationDidBecomeActive, object: nil)
    }

    func registerApplicationWillResignActive() {
        NotificationCenter.default.addObserver(self, selector: .applicationWillResignActive, name: .UIApplicationWillResignActive, object: nil)
    }

    func registerApplicationDidEnterBackground() {
        NotificationCenter.default.addObserver(self, selector: .applicationDidEnterBackground, name: .UIApplicationDidEnterBackground, object: nil)
    }


    func resignApplicationWillEnterForground() {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillEnterForeground, object: nil)
    }

    func resignApplicationDidBecomeActive() {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
    }

    func resignApplicationWillResignActive() {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillResignActive, object: nil)
    }

    func resignApplicationDidEnterBackground() {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidEnterBackground, object: nil)
    }
}

fileprivate extension UIKeyboardNotificationController {

    func registerWillShow()   { NotificationCenter.default.addObserver(self, selector: .keyboardWillShow, name: .UIKeyboardWillShow, object: nil) }
    func registerDidShow()    { NotificationCenter.default.addObserver(self, selector: .keyboardDidShow, name: .UIKeyboardDidShow, object: nil) }
    func registerWillHide()   { NotificationCenter.default.addObserver(self, selector: .keyboardWillHide, name: .UIKeyboardWillHide, object: nil) }
    func registerDidHide()    { NotificationCenter.default.addObserver(self, selector: .keyboardDidHide, name: .UIKeyboardDidHide, object: nil) }
    func registerWillChange() { NotificationCenter.default.addObserver(self, selector: .keyboardWillChangeFrame, name: .UIKeyboardWillChangeFrame, object: nil) }
    func registerDidChange()  { NotificationCenter.default.addObserver(self, selector: .keyboardDidChangeFrame, name: .UIKeyboardDidChangeFrame, object: nil) }

    func registerAll() {
        registerWillShow()
        registerWillHide()
        registerWillHide()
        registerDidHide()
        registerWillChange()
        registerDidChange()
    }

    func resignWillShow()   { NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil) }
    func resignDidShow()    { NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil) }
    func resignWillHide()   { NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil) }
    func resignDidHide()    { NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidHide, object: nil) }
    func resignWillChange() { NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillChangeFrame, object: nil) }
    func resignDidChange()  { NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidChangeFrame, object: nil) }

    func resignAll() {
        resignWillShow()
        resignDidShow()
        resignWillHide()
        resignDidHide()
        resignWillChange()
        resignDidChange()
    }
}

fileprivate extension UIKeyboardNotificationController {

    @objc func keyboardWillShow(_ notification: Notification) {

        guard let kbRectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }

        keyboardWillShow(kbRect: kbRectValue.cgRectValue, duration: kbDurationNumber.doubleValue)

        animateToKeyboardHeightWithDuration(kbDurationNumber.doubleValue)
    }

    @objc func keyboardWillHide(_ notification: Notification) {

        guard let kbRectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }

        keyboardWillHide(kbRect: kbRectValue.cgRectValue, duration: kbDurationNumber.doubleValue)

        animateToKeyboardHeightWithDuration(kbDurationNumber.doubleValue)
    }

    @objc func keyboardDidShow(_ notification: Notification) {

        guard let kbRectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }

        keyboardDidShow(kbRect: kbRectValue.cgRectValue, duration: kbDurationNumber.doubleValue)

        animateToKeyboardHeightWithDuration(kbDurationNumber.doubleValue)
    }

    @objc func keyboardDidHide(_ notification: Notification) {

        guard let kbRectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }

        keyboardDidHide(kbRect: kbRectValue.cgRectValue, duration: kbDurationNumber.doubleValue)

        animateToKeyboardHeightWithDuration(kbDurationNumber.doubleValue)
    }

    @objc func keyboardWillChangeFrame(_ notification: Notification) {

        guard let kbRectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }

        keyboardWillChangeFrame(kbRect: kbRectValue.cgRectValue, duration: kbDurationNumber.doubleValue)

        animateToKeyboardHeightWithDuration(kbDurationNumber.doubleValue)
    }

    @objc func keyboardDidChangeFrame(_ notification: Notification) {

        guard let kbRectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }

        keyboardDidChangeFrame(kbRect: kbRectValue.cgRectValue, duration: kbDurationNumber.doubleValue)

        animateToKeyboardHeightWithDuration(kbDurationNumber.doubleValue)
    }

    func animateToKeyboardHeightWithDuration(_ duration: Double) {

        guard isSubviewsAnimatedAutomatically else { return }

        UIView.animate(withDuration: duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
}

