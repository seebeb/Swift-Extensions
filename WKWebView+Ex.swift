//
//  WKWebView+Ex.swift
//  iTumblr
//
//  Created by Augus on 11/28/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {

    // for both Text Field and Text Area
    func javaScriptInjectionTextFieldBy(id: String, value: String, completionHandler: ((Any?, Error?) -> ())?) {
        let js = "document.getElementById('" + id + "').value = '" + value + "'"
        evaluateJavaScript(js, completionHandler: completionHandler)
    }
}

extension WKWebView {

    func labelTextBy(id: String, completion: @escaping (String?) -> ()) {

        let js = "document.getElementById('\(id)').textContent"
        
        evaluateJavaScript(js, completionHandler: { result, error in
            if error == nil, let text = result as? String {
                completion(text)
            } else {
                completion(nil)
            }
        })
    }

    func labelTextBy(name: String, completion: @escaping (String?) -> ()) {

        let js = "document.getElementsByName('\(name)')[0].textContent"

        evaluateJavaScript(js, completionHandler: { result, error in

            if error == nil, let text = result as? String {
                completion(text)
            } else {
                completion(nil)
            }
        })
    }
}

extension WKWebView {

    func clickElememtBy(className name: String, completionHandler: ((Any?, Error?) -> ())?) {

        let js = "document.getElementsByClassName('\(name)')[0];element.onclick = function() {};"

        evaluateJavaScript(js, completionHandler: completionHandler)
    }

    func clickButtonBy(id: String, completionHandler: ((Any?, Error?) -> ())?) {

        let js = "document.getElementById('\(id)').click();"

        evaluateJavaScript(js, completionHandler: completionHandler)
    }

    func scrollToBottom(_ completion: ((Bool) -> ())? = nil) {

        evaluateJavaScript("document.body.offsetHeight", completionHandler: { value, error in

            guard let height = value as? Double else { return }

            let js = "window.scrollBy(0, \(Int(height)))"
            
            self.evaluateJavaScript(js, completionHandler: { _, error in
                completion?(error == nil)
            })
        })
    }

    func positionOfElementById(_ id: String, completion: @escaping (CGRect?) -> ()) {

        let js = "function f(){ var r = document.getElementById('\(id)').getBoundingClientRect(); return '{{'+r.left+','+r.top+'},{'+r.width+','+r.height+'}}'; } f();"

        evaluateJavaScript(js, completionHandler: { result, error in

            guard error == nil else {
                completion(nil)
                return
            }

            guard let str = result as? String else {
                completion(nil)
                return
            }

            let rect = CGRectFromString(str)

            completion(rect != CGRect.zero ? rect : nil)
        })
    }
}
