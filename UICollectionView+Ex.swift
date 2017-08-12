//
//  UICollectionView+Ex.swift
//  Unsplash
//
//  Created by Augus on 12/08/2017.
//  Copyright © 2017 iAugus. All rights reserved.
//

import UIKit

extension UICollectionView {

    var visibleIndexPath: [IndexPath] {
        return visibleCells.map() {
            self.indexPath(for: $0)!
        }
    }
}
