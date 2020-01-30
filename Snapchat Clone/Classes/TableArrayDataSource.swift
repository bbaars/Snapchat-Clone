//
//  TableArrayDataSource.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/30/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

open class TableArrayDataSource<T, Cell: UITableViewCell> : TableDataSource<TableArrayDataProvider<T>, Cell>
    where T == Cell.T, Cell: ConfigurableCell {
    
    public convenience init(tableView: UITableView, array: [T], cellHeight: CGFloat, sectionHeaderViews: [UIView?]) {
        self.init(tableView: tableView, array: [array], cellHeight: cellHeight, sectionHeaderViews: sectionHeaderViews)
    }
    
    public init(tableView: UITableView, array: [[T]], cellHeight: CGFloat, sectionHeaderViews: [UIView?]) {
        let provider = TableArrayDataProvider(array: array, cellHeight: cellHeight, sectionHeaderViews: sectionHeaderViews)
        super.init(tableView: tableView, provider: provider)
    }
    
    public func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }
}
