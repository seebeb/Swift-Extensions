//
//  WebKit+Ex.swift
//
//  Created by Augus on 11/27/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import WebKit

extension HTTPCookieStorage {

    func deleteAll() {
        cookies?.forEach() {
            deleteCookie($0)
        }
    }
}

extension WKWebsiteDataStore {

    func removeAllData() {
        let types = WKWebsiteDataStore.allWebsiteDataTypes()
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: types, modifiedSince: date, completionHandler: {})
    }
}
