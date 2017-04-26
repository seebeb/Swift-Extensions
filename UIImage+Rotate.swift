//
//  UIImage+Rotate.swift
//
//  Created by Augus on 27/04/2017.
//  Copyright © 2017 iAugus. All rights reserved.
//

import UIKit

extension UIImage {

    var rotatedImageByOrientation: UIImage {

        // return if the orientation is already correct
        guard imageOrientation != .up else { return self }

        let transform = calculatedAffineTransform

        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.

        guard let cgImage = self.cgImage, let colorSpace = cgImage.colorSpace else { return self }

        let width = size.width
        let height = size.height

        guard let ctx = CGContext(data: nil,
                                  width: Int(width),
                                  height: Int(height),
                                  bitsPerComponent: cgImage.bitsPerComponent,
                                  bytesPerRow: 0,
                                  space: colorSpace,
                                  bitmapInfo: cgImage.bitmapInfo.rawValue) else { return self }

        ctx.concatenate(transform)

        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: height, height: width))

        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        }

        // And now we just create a new UIImage from the drawing context
        if let cgImage = ctx.makeImage() {
            return UIImage(cgImage: cgImage)
        } else {
            return self
        }
    }

    private var calculatedAffineTransform: CGAffineTransform {

        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform = CGAffineTransform.identity

        let width = size.width
        let height = size.height

        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: width, y: height)
            transform = transform.rotated(by: .pi)

        case .left, .leftMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.rotated(by: .pi / 2)

        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: height)
            transform = transform.rotated(by: .pi / -2)

        default:
            break
        }

        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        default:
            break
        }
        
        return transform
    }
}
