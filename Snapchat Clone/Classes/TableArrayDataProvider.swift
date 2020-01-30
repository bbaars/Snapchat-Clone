//
//  TableArrayDataProvider.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/30/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

public class TableArrayDataProvider<T>: TableDataProvider {
    private var items: [[T]] = []
    
    public var cellHeight: CGFloat
    public var sectionHeaderViews: [UIView?]
    
    init(array: [[T]], cellHeight: CGFloat, sectionHeaderViews: [UIView?]) {
        self.items = array
        self.cellHeight = cellHeight
        self.sectionHeaderViews = sectionHeaderViews
    }
    
    public func numberOfSections() -> Int {
        return items.count
    }
    
    public func numberOfRows(in section: Int) -> Int {
        return items[section].count
    }
    
    public func item(at indexPath: IndexPath) -> T? {
        guard check(indexPath: indexPath) else { return nil }
        
        return items[indexPath.section][indexPath.row]
    }
    
    private func check(indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0
            && indexPath.section < items.count
            && indexPath.row >= 0
            && indexPath.row < items[indexPath.section].count
    }
}
