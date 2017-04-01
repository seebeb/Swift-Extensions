//
//  Encrypt+Ex.swift
//
//  Created by Augus on 9/24/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import Foundation

// NOTE:  #import <CommonCrypto/CommonCrypto.h> to the ObjC-Swift bridging header that Xcode creates

extension Data {

    var hexString: String {
        let string = self.map{Int($0).hexString}.joined()
        return string
    }
    
    var MD5: Data {
        var result = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes {resultPtr in
            self.withUnsafeBytes {(bytes: UnsafePointer<UInt8>) in
                CC_MD5(bytes, CC_LONG(count), resultPtr)
            }
        }
        return result
    }
    
    var SHA1: Data {
        var result = Data(count: Int(CC_SHA1_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes {resultPtr in
            self.withUnsafeBytes {(bytes: UnsafePointer<UInt8>) in
                CC_SHA1(bytes, CC_LONG(count), resultPtr)
            }
        }
        return result
    }
}

extension String {

    var MD5: String {
        return data(using: .utf8)!.MD5.hexString
    }
    
    var SHA1: String {
        return data(using: .utf8)!.SHA1.hexString
    }
}


private extension Int {
    var hexString: String {
        return String(format:"%02x", self)
    }
}
