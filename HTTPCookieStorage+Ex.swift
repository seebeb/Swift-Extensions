//
//  HTTPCookieStorage+Ex.swift
//  iTumblr
//
//  Created by Augus on 11/27/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


extension HTTPCookieStorage {

    func deleteAll() {

        cookies?.forEach() {
            deleteCookie($0)
        }
    }
}
