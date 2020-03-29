//
//  CustomLayout.swift
//  abdullahSOHL
//
//  Created by abdullah on 02/08/1441 AH.
//  Copyright © 1441 abdullah. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import FirebaseStorage
import SDWebImage
import Firebase

protocol CustomLayoutDelegate : class {
    func collectionView(_ collectionView : UICollectionView , sizeOfPhotoAtIndexPath : IndexPath) -> CGSize
    
    
}

class CustomLayout : UICollectionViewLayout {
    
    weak var delegate : CustomLayoutDelegate!
    
    var numberOfColumns = 2
    var cellPadding : CGFloat = 3
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHight : CGFloat = 0
    fileprivate var contenWidth : CGFloat{
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.width
    }
    
    override var collectionViewContentSize: CGSize {
        
        return CGSize(width: contenWidth, height: contentHight)
        
    }
    
    override func prepare() {
        guard cache.isEmpty , let collectionView = collectionView else {
            return
        }
        let columnWidth = contenWidth / CGFloat(numberOfColumns)
        var xOffest = [CGFloat]()
        for column in 0..<numberOfColumns {
            xOffest.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, sizeOfPhotoAtIndexPath: indexPath)
            let cellWidth = columnWidth
            var cellHeight = photoSize.height * cellWidth / photoSize.width
            cellHeight = cellPadding * 2 + cellHeight
            let frame = CGRect(x: xOffest[column], y: yOffset[column], width: cellWidth, height: cellHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            contentHight = max(contentHight, frame.maxY)
            yOffset[column] = yOffset[column] + cellHeight
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}


