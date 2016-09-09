//
//  UIView+Snapshot.swift
//
//  Created by Augus on 4/30/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

extension UIView {
    
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    var snapshotData: Data {
        #if os(iOS)
            UIGraphicsBeginImageContext(frame.size)
            layer.render(in: UIGraphicsGetCurrentContext()!)
            let fullScreenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            UIImageWriteToSavedPhotosAlbum(fullScreenshot!, nil, nil, nil)
            return  UIImageJPEGRepresentation(fullScreenshot!, 0.5)!
        #elseif os(OSX)
            let rep: NSBitmapImageRep = self.view.bitmapImageRepForCachingDisplayInRect(self.view.bounds)!
            self.view.cacheDisplayInRect(self.view.bounds, toBitmapImageRep:rep)
            return rep.TIFFRepresentation!
        #endif
    }
    
}
