//
//  NSAttributedString+Ex.swift
//
//  Created by Augus on 4/4/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation

// MARK: - Trim
extension NSAttributedString {
	
	func attributedStringByTrimmingNewlines() -> NSAttributedString {
		var attributedString = self
		while attributedString.string.first == "\n" {
			attributedString = attributedString.attributedSubstring(from: NSMakeRange(1, attributedString.string.count - 1))
		}
		while attributedString.string.last == "\n" {
			attributedString = attributedString.attributedSubstring(from: NSMakeRange(0, attributedString.string.count - 1))
		}
		return attributedString
	}
}

// MARK: - Convert to html
extension NSAttributedString {

    convenience init(htmlString: String) throws {
        guard let data = htmlString.data(using: .utf8) else {
            throw NSError(domain: "com.iAugus.error", code: 0, userInfo: nil)
        }
        try self .init(htmlData: data)
    }

    convenience init(htmlData: Data) throws {
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        try self.init(data: htmlData, options: options, documentAttributes: nil)
    }
}