//
//  UIColor+Extension.swift
//
//  Created by Augus on 9/4/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func random() -> UIColor {
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
    
}

extension UIColor {
    
    private var components: UnsafePointer<CGFloat> { get { return cgColor.components! } }
    
    var red: CGFloat { get { return components[0] } }
    
    var green: CGFloat { get { return components[1] } }
    
    var blue: CGFloat { get { return components[2] } }
    
    func whiter(_ scale: CGFloat) -> UIColor {
        return UIColor(
            red: red * scale,
            green: green * scale,
            blue: blue,
            alpha: 1.0
        )
    }
}
