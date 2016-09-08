//
//  Colors.swift
//  SwiftExtensions
//
//  Created by Grigory Avdyushin on 12.07.16.
//  Copyright © 2016 Grigory Avdyushin. All rights reserved.
//

import UIKit

/*
 [UIColor.flat.turquoise,
 UIColor.flat.greenSea,
 UIColor.flat.emerald,
 UIColor.flat.nephritis,
 UIColor.flat.peterRiver,
 UIColor.flat.belizeHole,
 UIColor.flat.amethyst,
 UIColor.flat.wisteria,
 UIColor.flat.wetAsphalt,
 UIColor.flat.midnightBlue,
 UIColor.flat.sunFlower,
 UIColor.flat.orange,
 UIColor.flat.carrot,
 UIColor.flat.pumpkin,
 UIColor.flat.alizarin,
 UIColor.flat.pomegranate,
 UIColor.flat.clouds,
 UIColor.flat.silver,
 UIColor.flat.concrete,
 UIColor.flat.asbestos]
 */

/// Flat UIColors
extension UIColor {
    /// Flat colors
    struct flat {
        /// green sea
        static let turquoise    = UIColor(hex: 0x1abc9c)
        /// green sea
        static let greenSea     = UIColor(hex: 0x16a085)
        /// green
        static let emerald      = UIColor(hex: 0x2ecc71)
        /// green
        static let nephritis    = UIColor(hex: 0x27ae60)
        /// blue
        static let peterRiver   = UIColor(hex: 0x3498db)
        /// blue
        static let belizeHole   = UIColor(hex: 0x2980b9)
        /// purple
        static let amethyst     = UIColor(hex: 0x9b59b6)
        /// purple
        static let wisteria     = UIColor(hex: 0x8e44ad)
        /// dark blue
        static let wetAsphalt   = UIColor(hex: 0x34495e)
        /// dark blue
        static let midnightBlue = UIColor(hex: 0x2c3e50)
        /// yellow
        static let sunFlower    = UIColor(hex: 0xf1c40f)
        /// yellow
        static let orange       = UIColor(hex: 0xf39c12)
        /// orange
        static let carrot       = UIColor(hex: 0xe67e22)
        /// orange
        static let pumpkin      = UIColor(hex: 0xd35400)
        /// red
        static let alizarin     = UIColor(hex: 0xe74c3c)
        /// red
        static let pomegranate  = UIColor(hex: 0xc0392b)
        /// white
        static let clouds       = UIColor(hex: 0xecf0f1)
        /// white
        static let silver       = UIColor(hex: 0xbdc3c7)
        /// gray
        static let asbestos     = UIColor(hex: 0x7f8c8d)
        /// gray
        static let concrete     = UIColor(hex: 0x95a5a6)
    }
    
    /// Color formats
    enum ColorFormat: Int {
        
        case RGB = 12
        case RGBA = 16
        case RRGGBB = 24
//        case RRGGBBAA = 32
        
        init?(bitsCount: Int) {
            self.init(rawValue: bitsCount)
        }
        
    }
    
    /// Returns color with given hex string
    convenience init(string: String) {
        
        let string = string.replacingOccurrences(of: "#", with: "")
        
        if let hex = Int(string, radix: 16),
            let format = ColorFormat(bitsCount: string.characters.count * 4) {
            
            self.init(hex: hex, format: format)
            
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
        }
        
    }
    
    /// Returns color with given hex integer value and color format
    convenience init(hex: Int, format: ColorFormat = ColorFormat.RRGGBB) {
        
        var red = 0, green = 0, blue = 0, alpha = 255
        
        switch format {
        case .RGB:
            red   = ((hex & 0xf00) >> 8) << 4 + ((hex & 0xf00) >> 8)
            green = ((hex & 0x0f0) >> 4) << 4 + ((hex & 0x0f0) >> 4)
            blue  = ((hex & 0x00f) >> 0) << 4 + ((hex & 0x00f) >> 0)
            break;
        case .RGBA:
            red   = ((hex & 0xf000) >> 12) << 4 + ((hex & 0xf000) >> 12)
            green = ((hex & 0x0f00) >>  8) << 4 + ((hex & 0x0f00) >>  8)
            blue  = ((hex & 0x00f0) >>  4) << 4 + ((hex & 0x00f0) >>  4)
            alpha = ((hex & 0x000f) >>  0) << 4 + ((hex & 0x000f) >>  4)
            break;
        case .RRGGBB:
            red   = ((hex & 0xff0000) >> 16)
            green = ((hex & 0x00ff00) >>  8)
            blue  = ((hex & 0x0000ff) >>  0)
            break;
//        case .RRGGBBAA:
//            red   = ((hex & 0xff000000) >> 24)
//            green = ((hex & 0x00ff0000) >> 16)
//            blue  = ((hex & 0x0000ff00) >>  8)
//            alpha = ((hex & 0x000000ff) >>  0)
//            break;
        }
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/255.0)
        
    }

}
