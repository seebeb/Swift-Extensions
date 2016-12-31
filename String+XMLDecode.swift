//
//  String+XMLDecode.swift
//  iTumblr
//
//  Created by Augus on 12/31/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation


// REFERENCE: http://stackoverflow.com/a/40268406/4656574

extension String {

    static private let mappings = ["&quot;" : "\"","&amp;" : "&", "&lt;" : "<", "&gt;" : ">","&nbsp;" : " ","&iexcl;" : "¡","&cent;" : "¢","&pound;" : " £","&curren;" : "¤","&yen;" : "¥","&brvbar;" : "¦","&sect;" : "§","&uml;" : "¨","&copy;" : "©","&ordf;" : " ª","&laquo" : "«","&not" : "¬","&reg" : "®","&macr" : "¯","&deg" : "°","&plusmn" : "±","&sup2; " : "²","&sup3" : "³","&acute" : "´","&micro" : "µ","&para" : "¶","&middot" : "·","&cedil" : "¸","&sup1" : "¹","&ordm" : "º","&raquo" : "»&","frac14" : "¼","&frac12" : "½","&frac34" : "¾","&iquest" : "¿","&times" : "×","&divide" : "÷","&ETH" : "Ð","&eth" : "ð","&THORN" : "Þ","&thorn" : "þ","&AElig" : "Æ","&aelig" : "æ","&OElig" : "Œ","&oelig" : "œ","&Aring" : "Å","&Oslash" : "Ø","&Ccedil" : "Ç","&ccedil" : "ç","&szlig" : "ß","&Ntilde;" : "Ñ","&ntilde;":"ñ",]

    func stringByDecodingXMLEntities() -> String {

        guard let _ = self.range(of: "&", options: [.literal]) else { return self }

        var result = ""

        let scanner = Scanner(string: self)
        scanner.charactersToBeSkipped = nil

        let boundaryCharacterSet = CharacterSet(charactersIn: " \t\n\r;")

        repeat {

            var nonEntityString: NSString? = nil

            if scanner.scanUpTo("&", into: &nonEntityString) {
                if let s = nonEntityString as? String {
                    result.append(s)
                }
            }

            if scanner.isAtEnd {
                break
            }

            var didBreak = false
            for (k,v) in String.mappings {
                if scanner.scanString(k, into: nil) {
                    result.append(v)
                    didBreak = true
                    break
                }
            }

            if !didBreak {

                if scanner.scanString("&#", into: nil) {

                    var gotNumber = false
                    var charCodeUInt: UInt32 = 0
                    var charCodeInt: Int32 = -1
                    var xForHex: NSString? = nil

                    if scanner.scanString("x", into: &xForHex) {
                        gotNumber = scanner.scanHexInt32(&charCodeUInt)
                    }
                    else {
                        gotNumber = scanner.scanInt32(&charCodeInt)
                    }

                    if gotNumber {
                        let newChar = String(format: "%C", (charCodeInt > -1) ? charCodeInt : charCodeUInt)
                        result.append(newChar)
                        scanner.scanString(";", into: nil)
                    }
                    else {
                        var unknownEntity: NSString? = nil
                        scanner.scanUpToCharacters(from: boundaryCharacterSet, into: &unknownEntity)
                        let h = xForHex ?? ""
                        let u = unknownEntity ?? ""
                        result.append("&#\(h)\(u)")
                    }
                }
                else {
                    scanner.scanString("&", into: nil)
                    result.append("&")
                }
            }
            
        } while (!scanner.isAtEnd)
        
        return result
    }
}
