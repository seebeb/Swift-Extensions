//
//  UIColor+Ex.swift
//
//  Created by Augus on 9/4/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit


// MARK: -

extension UIColor {

    /// Compare two colors
    ///
    /// - Parameters:
    ///   - color: color to be compared
    ///   - tolerance: tolerance (0.0 ~ 1.0)
    /// - Returns: result
    func isEqual(to color: UIColor, withTolerance tolerance: CGFloat = 0.0) -> Bool {

        var r1 : CGFloat = 0
        var g1 : CGFloat = 0
        var b1 : CGFloat = 0
        var a1 : CGFloat = 0
        var r2 : CGFloat = 0
        var g2 : CGFloat = 0
        var b2 : CGFloat = 0
        var a2 : CGFloat = 0

        getRed(&r1, green: &g1, blue: &b1, alpha: &a1)

        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return fabs(r1 - r2) <= tolerance
            && fabs(g1 - g2) <= tolerance
            && fabs(b1 - b2) <= tolerance
            && fabs(a1 - a2) <= tolerance
    }
}


// MARK: -

extension UIColor {

    class var random: UIColor {
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }

    func darker(_ scale: CGFloat) -> UIColor {
        var h = CGFloat(0)
        var s = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * scale, alpha: a)
    }

    func lighter(_ scale: CGFloat) -> UIColor {
        var h = CGFloat(0)
        var s = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s * scale, brightness: b, alpha: a)
    }

    func alpha(_ scale: CGFloat) -> UIColor {
        return withAlphaComponent(scale)
    }

    var alpha: CGFloat {
        var h = CGFloat(0)
        var s = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return a
    }

}

extension UIColor {

    var components: UnsafePointer<CGFloat> { get { return cgColor.__unsafeComponents! } }

    var cRed: CGFloat { get { return components[0] } }

    var cGreen: CGFloat { get { return components[1] } }

    var cBlue: CGFloat { get { return components[2] } }

    func whiter(_ scale: CGFloat) -> UIColor {
        return UIColor(
            red: cRed * scale,
            green: cGreen * scale,
            blue: cBlue,
            alpha: 1.0
        )
    }
}
