//
//  IndexPath+Ex.swift
//
//  Created by Augus on 8/15/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation

extension IndexPath {
    
    @discardableResult
    func plusRowAndSection(_ row: Int, _ section: Int) -> IndexPath {
        return IndexPath(row: self.row + row, section: self.section + section)
    }
    
    @discardableResult
    func plusRow(_ by: Int) -> IndexPath {
        return plusRowAndSection(by, 0)
    }
    
    @discardableResult
    func plusSection(_ by: Int) -> IndexPath {
        return plusRowAndSection(0, by)
    }
}
