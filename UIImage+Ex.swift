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

    convenience init(frame: CGRect, color: UIColor?, isOpaque: Bool = true, scale: CGFloat = 0) {
        if color == nil {
            self.init()
        } else {

            UIGraphicsBeginImageContextWithOptions(frame.size, isOpaque, scale)
            color?.setFill()
            UIRectFill(frame)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.init(cgImage: image?.cgImage)
        }
    }
}


// MARK: - 

extension UIImage {

    func tintedImageWithColor(_ color: UIColor) -> UIImage? {

        guard let maskImage = self.cgImage else { return nil }

        let width = self.size.width
        let height = self.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        guard let bitmapContext = CGContext(data: nil,
                                            width: Int(width),
                                            height: Int(height),
                                            bitsPerComponent: 8,
                                            bytesPerRow: 0,
                                            space: colorSpace,
                                            bitmapInfo: bitmapInfo.rawValue) else { return nil }

        bitmapContext.clip(to: bounds, mask: maskImage)
        bitmapContext.setFillColor(color.cgColor)
        bitmapContext.fill(bounds)

        guard let cImage = bitmapContext.makeImage() else { return nil }

        let coloredImage = UIImage(cgImage: cImage)

        return coloredImage
    }

    /// Invert the color of the image, then return the new image
    ///
    /// REFERENCE: http://stackoverflow.com/a/38835122/4656574
    ///
    /// - parameter cgResult: whether oa not to convert to cgImgae, default is false
    ///
    /// - returns: inverted image, may nil if failed
    func inverseImage(cgResult: Bool = false) -> UIImage? {

        let coreImage = UIKit.CIImage(image: self)

        guard let filter = CIFilter(name: "CIColorInvert") else { return nil }

        filter.setValue(coreImage, forKey: kCIInputImageKey)

        guard let result = filter.value(forKey: kCIOutputImageKey) as? UIKit.CIImage else { return nil }

        if cgResult {

            guard let cgImage = CIContext(options: nil).createCGImage(result, from: result.extent) else { return nil }

            return UIImage(cgImage: cgImage)
        }
        
        return UIImage(ciImage: result)
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
