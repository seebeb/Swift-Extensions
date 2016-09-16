//
//  UIImage+Ex.swift
//
//  Created by Augus on 6/30/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit



extension UIImage {

    /// Convert Optional CGImage to UIImage
    ///
    /// - parameter cgImage: Optional CGImage
    ///
    /// - returns: UIImage
    convenience init(cgImage: CGImage?) {
        if cgImage == nil {
            self.init()
        } else {
            self.init(cgImage: cgImage!)
        }
    }
    

    /// Convert Optional UIView to UIImage
    ///
    /// - parameter view: Optional UIView
    ///
    /// - returns: UIImage
    convenience init(view: UIView?) {
        
        guard let view = view else {
            self.init()
            return
        }
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image?.cgImage)
    }
}


// MARK: - 

extension UIImage {

    func roundedScaledToSize(_ size: CGSize) -> UIImage {
        return scaledToSize(size).rounded()
    }

    func scaledToSize(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage ?? UIImage()
    }

    func rounded(radius: CGFloat? = nil) -> UIImage {

        let imageLayer = CALayer()
        imageLayer.frame = CGRect(origin: .zero, size: size)
        imageLayer.contents = cgImage
        imageLayer.masksToBounds = true

        let radius = radius ?? min(size.width, size.height) / 2
        imageLayer.cornerRadius = radius

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        imageLayer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return roundedImage ?? UIImage()
    }
}
