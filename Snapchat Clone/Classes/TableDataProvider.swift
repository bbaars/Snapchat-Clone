//
//  TableDataSource.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/30/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

public protocol TableDataProvider {
    associatedtype T
    
    var cellHeight: CGFloat { get set }
    var sectionHeaderViews: [UIView?] { get set }
    
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
}
