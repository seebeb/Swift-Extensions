//
//  UITextView+Ex.swift
//
//
//  Created by Augus on 9/8/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit

extension UITextView {
    
    /**
    Methods to allow using HTML code with CoreText
    
    */

    func ausAttributedText(_ data: String) {

        let formatedData = data.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let data = formatedData.data(using: .unicode, allowLossyConversion: false) else { return }

        attributedText = try? NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
    }
    
    /**
    calculate size of UITextView
    
    :returns: CGSize
    */
    var sizeAfterResizingTextView: CGSize {
        let fixedWidth = self.frame.size.width
        self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = self.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        self.frame = newFrame
        return self.frame.size
    }
}


func sizeForAttributedText(_ text: String) -> CGSize {
    let calculationView = UITextView()
    calculationView.ausAttributedText(text)
    let size = calculationView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
    return size
}
