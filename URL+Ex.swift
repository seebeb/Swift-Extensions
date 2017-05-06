//
//  URL+Ex.swift
//
//  Created by Augus on 12/17/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation

let EMPTY_URL = URL(string: "https://")!

extension URL {

    func httpsURL() -> URL {

        guard scheme != "https" else {
            return self
        }

        let str = absoluteString.replacingOccurrences(of: "http://", with: "https://")

        return URL(string: str)!
    }
}

extension String {

    func toURL(forceToHttps: Bool = false) -> URL? {
        if forceToHttps {
            return URL(string: self)?.httpsURL()
        } else {
            return URL(string: self)
        }
    }

    func toNoneNilURL(forceToHttps: Bool = false) -> URL {
        return toURL(forceToHttps: forceToHttps) ?? URL(string: "https://")!
    }

    func httpsURL() -> URL? {

        guard let url = URL(string: self) else { return nil }
        
        return url.httpsURL()
    }
}
