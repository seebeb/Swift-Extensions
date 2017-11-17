//
//  UIPlaceHolderTextView.swift
//
//  Created by Augus on 6/20/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import UIKit

class UIPlaceholderTextView : UITextView {
    
    var placeholderColor : UIColor = UIColor(white: 0.7, alpha: 1.0)
    var placeholder : String? = nil
    
    override var font : UIFont? {
        willSet(font) {
            super.font = font
        }
        didSet(font) {
            setNeedsDisplay()
        }
    }
    
    override var contentInset : UIEdgeInsets {
        willSet(text) {
            super.contentInset = contentInset
        }
        didSet(text) {
            setNeedsDisplay()
        }
    }
    
    override var textAlignment : NSTextAlignment {
        willSet(textAlignment) {
            super.textAlignment = textAlignment
        }
        didSet(textAlignment) {
            setNeedsDisplay()
        }
    }
    
    override var text : String? {
        willSet(text) {
            super.text = text
        }
        didSet(text) {
            setNeedsDisplay()
        }
    }
    
    override var attributedText: NSAttributedString! {
        willSet(attributedText) {
            super.attributedText = attributedText
        }
        didSet(text) {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        if (text! == "" && placeholder != nil) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            let attributes: [NSAttributedStringKey : Any] = [
                NSAttributedStringKey.font : UIFont.italicSystemFont(ofSize: font!.pointSize),
                NSAttributedStringKey.foregroundColor : placeholderColor,
                NSAttributedStringKey.paragraphStyle  : paragraphStyle]

            placeholder?.draw(in: placeholderRectForBounds(bounds: bounds), withAttributes: attributes)
        }
        super.draw(rect)
    }

    @objc private func textChanged(_ notification: NSNotification) {
        setNeedsDisplay()
    }
    
    private func placeholderRectForBounds(bounds : CGRect) -> CGRect {

        let left = contentInset.left
        let right = contentInset.right
        let top = contentInset.top
        let bottom = contentInset.bottom

        var x = left + 4.0
        var y = top  + 9.0
        let w = frame.size.width - left - right - 16.0
        let h = frame.size.height - top - bottom - 16.0

        if let style = self.typingAttributes[NSAttributedStringKey.paragraphStyle.rawValue] as? NSParagraphStyle {
            x += style.headIndent
            y += style.firstLineHeadIndent
        }

        return CGRect(x: x, y: y, width: w, height: h)
    }
}
