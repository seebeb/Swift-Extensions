//
//  NSMutableArray+Ex.swift
//
//  Created by Augus on 11/8/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import Foundation


extension NSMutableArray {
    /**
     
     remove array's last object and insert a new object in the first index.
     
     - parameter newValue:  the new object you want to insert in the fisrt index.
     - parameter maxLenght: set a fixed lenght for the array.
     
     - returns: return the new array.
     */
    @discardableResult
    func insertNewElementAndRemoveLastOne(newValue: NSObject, maxLenght: Int? = nil) -> NSMutableArray {
        if let max = maxLenght {
            if self.count >= max {
                self.removeLastObject()
            }
        } else {
            self.removeLastObject()
        }
        self.insert(newValue, at: 0)
        return self
    }
    
    /**
     if array contains the new object, just move it to fisrt index.
     */
    @discardableResult
    func filterInsertNewElementAndRemoveLastOne(newValue: NSObject, maxLenght: Int? = nil) -> NSMutableArray {
        if self.contains(newValue) {
            let index = self.index(of: newValue)
            self.moveObject(from: index, to: 0)
            return self
        } else {
            self.insertNewElementAndRemoveLastOne(newValue: newValue, maxLenght: maxLenght)
            return self
        }
    }
    
    func moveObject(from index0: Int, to index1: Int) {
        if index0 < self.count && index1 < self.count {
            let object = self.object(at: index0)
            self.removeObject(at: index0)
            self.insert(object, at: index1)
        }
    }
}
