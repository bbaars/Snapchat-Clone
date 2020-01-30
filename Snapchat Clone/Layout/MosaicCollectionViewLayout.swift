//
//  MosaicCollectionViewLayout.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 2/27/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class MosaicCollectionViewLayout: UICollectionViewLayout {
    
    private let columns = 2
    private let cellPadding: CGFloat = 5
    private var contentHeight: CGFloat = 0
    
    private var cachedAttributes = [UICollectionViewLayoutAttributes]()
    
    // computed properties must have accessors specified.
    private var width: CGFloat {
        get {
            return collectionView!.bounds.width - (cellPadding * 2)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: width,
                          height: contentHeight)
        }
    }
    
    override func prepare() {
        super.prepare()
        
        if cachedAttributes.isEmpty {
            let columnWidth = width / CGFloat(columns)
            
            var column = 0
            var yOffsets = [CGFloat](repeating: 0, count: columns)
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let frame = CGRect(x: CGFloat(column) * columnWidth + cellPadding, y: yOffsets[column], width: columnWidth, height: 300)
//                let frame = CGRect(x: CGFloat(column) * columnWidth + cellPadding, y: yOffsets[column], width: columnWidth, height: CGFloat((arc4random_uniform(4) + 1) * 100))

                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cachedAttributes.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
//                yOffsets[column] = yOffsets[column] + 350
                yOffsets[column] = yOffsets[column] + frame.size.height
                column = column >= (columns - 1) ? 0 : column + 1
            }
        }
    }
    
    // gives us a target view, we see if our attribute above should be added to this target view
    // if so, we add the layout attributes to that frame containing our custom attribute.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in cachedAttributes {
            if (attribute.frame.intersects(rect)) {
                layoutAttributes.append(attribute)
            }
        }
        
        return layoutAttributes
    }
}
