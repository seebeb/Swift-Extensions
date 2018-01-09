//
//  NSAttributedString+Trim.swift
//  Lucis
//
//  Created by Augus on 4/4/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation

public extension NSAttributedString {
	public func attributedStringByTrimmingNewlines() -> NSAttributedString {
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
